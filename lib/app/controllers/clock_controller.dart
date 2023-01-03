import 'dart:async';
import 'dart:math';

import 'package:wakelock/wakelock.dart';

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

  int _msRan = 0;
  int _lastStart = 0;
  final List<Timer> _timers = [];

  Timer? _tickTimer;
  TickCache? _tickCache;

  void reset() {
    _stop();
    _msRan = 0;
    _lastStart = 0;
    clockState.set(const ClockState());
    clockMode.set(ClockMode.off);
    Wakelock.disable();
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
    _msRan += DateTime.now().millisecondsSinceEpoch - _lastStart;

    _tickTimer?.cancel();
    _tickCache = null;
    _timers.clear();
    if (!muted) _notifier.currentPlayer.cancel();
    clockMode.set(ClockMode.paused);
    Wakelock.disable();
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
    Wakelock.enable();
  }

  void pauseStreaming() {
    _tickTimer?.cancel();
    _tickTimer = null;
  }

  void continueStreaming() {
    if (_tickTimer != null || clockMode.current != ClockMode.on) return;
    _tick();
    _tickTimer = Timer.periodic(
      const Duration(milliseconds: clockIntervalMs),
      (t) {
        _tick();
      },
    );
  }

  void _setupTimeouts() {
    final settings = SettingsController().generateSettings();
    int baseMs = -_msRan;
    // before essay
    if (settings.withEssay) {
      baseMs += (settings.essaySeconds - settings.secondsLeftCount) * 1000;
      if (baseMs > 0) {
        _timers.add(
          Timer(
            Duration(milliseconds: baseMs),
            () {
              if (settings.notifyBeforeEnd) {
                _notifier.currentPlayer.play(VoicePlays.minLeft);
              }
            },
          ),
        );
      }
      // essay end
      baseMs += settings.secondsLeftCount * 1000;
      if (baseMs > 0) {
        _timers.add(
          Timer(
            Duration(milliseconds: baseMs),
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
      baseMs += (settings.chapterSeconds - settings.secondsLeftCount) * 1000;
      if (baseMs > 0) {
        _timers.add(
          Timer(
            Duration(milliseconds: baseMs),
            () {
              if (settings.notifyBeforeEnd) {
                _notifier.currentPlayer.play(VoicePlays.minLeft);
              }
            },
          ),
        );
      }
      // each chapter end, except last
      baseMs += settings.secondsLeftCount * 1000;
      if (baseMs > 0 && i < settings.chaptersCount - 1) {
        _timers.add(
          Timer(
            Duration(milliseconds: baseMs),
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
        Duration(milliseconds: baseMs),
        () {
          reset();
          clockMode.set(ClockMode.done);
          _notifier.currentPlayer.play(VoicePlays.clockEnd);
          Wakelock.disable();
        },
      ),
    );
  }

  void _tick() {
    final settings = SettingsController().generateSettings();
    final now = DateTime.now().millisecondsSinceEpoch;
    if (_tickCache == null) {
      _initCache(settings, now);
    } else {
      _cacheTick(settings, now);
    }
    final cache = _tickCache!;
    int seconds = cache.currentMs ~/ 1000;
    if (cache.phase.type == ClockPhaseType.chapters) {
      if (settings.resetType != ResetType.never && settings.withEssay) {
        seconds -= settings.essaySeconds;
      }
      if (settings.resetType == ResetType.always &&
          (cache.phase.counter ?? 0) > 0) {
        seconds = seconds % settings.chapterSeconds;
      }
    }
    final double progressFraction = settings.progressType == ProgressType.total
        ? cache.currentMs / cache.totalMs
        : cache.phaseMs / (cache.phase.getSeconds(settings) * 1000);
    clockState.set(
      clockState.current.copyWith(
        seconds: seconds,
        progressFraction: min(progressFraction, 1),
        phase: cache.phase,
      ),
    );
  }

  void _initCache(Settings settings, int now) {
    final int currentMs = _msRan + (now - _lastStart);
    final int totalMs = _essayMs(settings) +
        1000 * settings.chaptersCount * settings.chapterSeconds;
    var phase = const ClockPhase(type: ClockPhaseType.essay);
    if (!settings.withEssay || currentMs > settings.essaySeconds * 1000) {
      final chapterCounter =
          (currentMs - _essayMs(settings)) ~/ (settings.chapterSeconds * 1000);
      phase = ClockPhase(
        type: ClockPhaseType.chapters,
        counter: chapterCounter + 1,
      );
    }
    final int currentPhaseMs = phase.type == ClockPhaseType.essay
        ? currentMs
        : (currentMs - _essayMs(settings)) % (settings.chapterSeconds * 1000);
    _tickCache = TickCache(
      totalMs: totalMs,
      phase: phase,
      currentMs: currentMs,
      cachedTime: now,
      phaseMs: currentPhaseMs,
    );
  }

  void _cacheTick(Settings settings, int now) {
    final cache = _tickCache!;
    final int deltaMs = now - cache.cachedTime;
    int phaseMs = cache.phaseMs + deltaMs;
    if (phaseMs > cache.phase.getSeconds(settings) * 1000) {
      phaseMs -= cache.phase.getSeconds(settings) * 1000;
      if (cache.phase.type == ClockPhaseType.essay) {
        cache.phase =
            const ClockPhase(type: ClockPhaseType.chapters, counter: 1);
      } else {
        cache.phase = ClockPhase(
            type: ClockPhaseType.chapters,
            counter: (cache.phase.counter ?? 0) + 1);
      }
    }
    cache.cachedTime = now;
    cache.currentMs = cache.currentMs + deltaMs;
    cache.phaseMs = phaseMs;
  }

  int _essayMs(Settings settings) =>
      (settings.withEssay ? settings.essaySeconds : 0) * 1000;

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
  int totalMs;
  int currentMs;
  int cachedTime;

  ClockPhase phase;
  int phaseMs;

  TickCache({
    required this.totalMs,
    required this.currentMs,
    required this.cachedTime,
    required this.phase,
    required this.phaseMs,
  });
}
