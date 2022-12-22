import 'dart:async';
import 'dart:math';

import '../models/clock_state.dart';
import '../models/settings.dart';
import 'notifoer_controller.dart';
import 'settings_controller.dart';
import 'shared/streamable.dart';

// ? right now the clock ticking is based on seconds when stopping/ continuing.
// ? it means that if you stop and continue the clock many times, it won't sum up the time.
// ? maybe it should be based on milliseconds?

class ClockController {
  static const int clockIntervalMs = 500;

  final clockState = Streamable<ClockState>(const ClockState());
  final clockMode = Streamable<ClockMode>(ClockMode.off);
  final _notifier = VoiceNotifier();

  int _secondsRan = 0;
  int _lastStart = 0;
  final List<Timer> _timers = [];

  Timer? _tickTimer;
  TickCache? _tickCache;

  void reset() {
    _stop();
    _secondsRan = 0;
    _lastStart = 0;
    clockState.set(const ClockState());
    clockMode.set(ClockMode.off);
  }

  void toggleStart() {
    switch (clockMode.current) {
      case ClockMode.off:
      case ClockMode.done:
        return _start();
      case ClockMode.on:
        return _stop();
      case ClockMode.paused:
        return _continue();
    }
  }

  void _start() {
    reset();
    _continue(muted: true);
    _notifier.currentPlayer.play(VoicePlays.clockStart);
  }

  void _stop({bool muted = false}) {
    for (final timer in _timers) {
      timer.cancel();
    }
    _secondsRan += (DateTime.now().millisecondsSinceEpoch - _lastStart) ~/ 1000;

    _tickTimer?.cancel();
    _tickCache = null;
    _timers.clear();
    if (!muted) _notifier.currentPlayer.cancel();
    clockMode.set(ClockMode.paused);
  }

  void _continue({bool muted = false}) {
    _lastStart = DateTime.now().millisecondsSinceEpoch;
    _setupTimeouts();
    if (!muted) _notifier.currentPlayer.play(VoicePlays.clockContinue);
    clockMode.set(ClockMode.on);
    _tickTimer = Timer.periodic(
      const Duration(milliseconds: clockIntervalMs),
      (t) {
        _tick();
      },
    );
  }

  void _setupTimeouts() {
    final settings = SettingsController().generateSettings();
    int baseSeconds = -_secondsRan;
    // before essay
    if (settings.withEssay) {
      baseSeconds += settings.essaySeconds - settings.secondsLeftCount;
      if (baseSeconds > 0) {
        _timers.add(
          Timer(
            Duration(seconds: baseSeconds),
            () {
              if (settings.notifyBeforeEnd) {
                _notifier.currentPlayer.play(VoicePlays.minLeft);
              }
            },
          ),
        );
      }
      // essay end
      baseSeconds += settings.secondsLeftCount;
      if (baseSeconds > 0) {
        _timers.add(
          Timer(
            Duration(seconds: baseSeconds),
            () {
              if (settings.notifyBeforeEnd) {
                _notifier.currentPlayer.play(VoicePlays.nextChapter);
              }
            },
          ),
        );
      }
    }
    for (int i = 0; i < settings.chaptersCount; i++) {
      // before each chapter
      baseSeconds += settings.chapterSeconds - settings.secondsLeftCount;
      if (baseSeconds > 0) {
        _timers.add(
          Timer(
            Duration(seconds: baseSeconds),
            () {
              if (settings.notifyBeforeEnd) {
                _notifier.currentPlayer.play(VoicePlays.minLeft);
              }
            },
          ),
        );
      }
      // each chapter end, except last
      baseSeconds += settings.secondsLeftCount;
      if (baseSeconds > 0 && i < settings.chaptersCount - 1) {
        _timers.add(
          Timer(
            Duration(seconds: baseSeconds),
            () {
              if (settings.notifyBeforeEnd) {
                _notifier.currentPlayer.play(VoicePlays.nextChapter);
              }
            },
          ),
        );
      }
    }
    // after last chapter
    _timers.add(
      Timer(
        Duration(seconds: baseSeconds),
        () {
          reset();
          clockMode.set(ClockMode.done);
          _notifier.currentPlayer.play(VoicePlays.clockEnd);
        },
      ),
    );
  }

  void _tick() {
    final settings = SettingsController().generateSettings();
    final now = DateTime.now().millisecondsSinceEpoch;
    if (_tickCache == null) {
      final secondsRan = _secondsRan + (now - _lastStart) ~/ 1000;
      var totalSeconds = (settings.withEssay ? settings.essaySeconds : 0) +
          settings.chaptersCount * settings.chapterSeconds;
      var phase = const ClockPhase(type: ClockPhaseType.essay);
      if (!settings.withEssay || secondsRan > settings.essaySeconds) {
        final chapterCounter =
            (secondsRan - (settings.withEssay ? settings.essaySeconds : 0)) ~/
                settings.chapterSeconds;
        phase = ClockPhase(
          type: ClockPhaseType.chapters,
          counter: chapterCounter + 1,
        );
      }
      int? currentPhaseTotalSeconds;
      double progressFraction = secondsRan / totalSeconds;
      if (settings.progressType == ProgressType.perPhase) {
        final inEssay = phase.type == ClockPhaseType.essay;
        currentPhaseTotalSeconds =
            inEssay ? settings.essaySeconds : settings.chapterSeconds;
        final ranCurrentSeconds =
            (secondsRan - (inEssay ? 0 : settings.essaySeconds)) %
                currentPhaseTotalSeconds;
        progressFraction = ranCurrentSeconds / currentPhaseTotalSeconds;
      }
      _tickCache = TickCache(
        totalSeconds: totalSeconds,
        phase: phase,
        currentPhaseTotalSeconds: currentPhaseTotalSeconds,
        progressFraction: progressFraction,
        ranSeconds: secondsRan,
        cachedTime: now,
      );
    } else {
      final ranSeconds = _secondsRan + (now - _lastStart) ~/ 1000;
      _tickCache?.cachedTime = now;
      _tickCache?.ranSeconds = ranSeconds;
      final fractionTotal =
          _tickCache?.currentPhaseTotalSeconds ?? _tickCache!.totalSeconds;
      final fractionSeconds = ranSeconds % (fractionTotal);
      _tickCache?.progressFraction = (ranSeconds > 0 && fractionSeconds == 0)
          ? 1
          : fractionSeconds / fractionTotal;

      final chapterSeconds = ranSeconds - settings.essaySeconds;
      if (chapterSeconds > 0) {
        if (_tickCache?.phase.type == ClockPhaseType.essay) {
          _tickCache?.phase =
              const ClockPhase(type: ClockPhaseType.chapters, counter: 1);
          if (settings.progressType == ProgressType.perPhase) {
            _tickCache?.currentPhaseTotalSeconds = settings.chapterSeconds;
          }
        } else if ((chapterSeconds ~/ settings.chapterSeconds) + 1 !=
            _tickCache?.phase.counter) {
          _tickCache?.phase = ClockPhase(
            type: ClockPhaseType.chapters,
            counter: chapterSeconds ~/ settings.chapterSeconds + 1,
          );
        }
      }
    }
    final cache = _tickCache!;
    var seconds = cache.ranSeconds;
    if (cache.phase.type == ClockPhaseType.chapters) {
      if (settings.resetType != ResetType.never && settings.withEssay) {
        seconds -= settings.essaySeconds;
      }
      if (settings.resetType == ResetType.always &&
          (cache.phase.counter ?? 0) > 0) {
        seconds = seconds % settings.chapterSeconds;
      }
    }
    clockState.set(
      clockState.current.copyWith(
        seconds: seconds,
        progressFraction: min(cache.progressFraction, 1),
        phase: cache.phase,
      ),
    );
  }

  ClockController._createInstance() {
    SettingsController().settingsChanges$.listen((_) {
      if (_tickTimer != null && clockMode.current == ClockMode.on) {
        _stop(muted: true);
        _continue(muted: true);
      }
    });
  }
  // singleton
  static final ClockController _instance = ClockController._createInstance();
  factory ClockController() => _instance;
  static ClockController get instance => _instance;
}

class TickCache {
  int totalSeconds;
  int ranSeconds;
  int cachedTime;

  ClockPhase phase;
  double progressFraction;
  int? currentPhaseTotalSeconds;

  TickCache({
    required this.totalSeconds,
    required this.ranSeconds,
    required this.cachedTime,
    required this.phase,
    required this.progressFraction,
    this.currentPhaseTotalSeconds,
  });
}
