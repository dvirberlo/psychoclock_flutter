import 'dart:async';
import 'dart:convert';

import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/settings.dart';
import 'shared/streamable.dart';

// Did you hear it? OOP mean boillerplate code, sad but true.
// Where are you, my dear TypeScript? :(

class SettingsController {
  final BehaviorSubject _settingsSubject = BehaviorSubject.seeded(null);
  Stream get settingsChanges$ => _settingsSubject.stream;

  final withEssay = Streamable<bool>.withListener(
      defaultSettings.withEssay, () => _instance._onSettingsChanged());
  final essaySeconds = Streamable<int>.withListener(
      defaultSettings.essaySeconds, () => _instance._onSettingsChanged());
  final chaptersCount = Streamable<int>.withListener(
      defaultSettings.chaptersCount, () => _instance._onSettingsChanged());
  final chapterSeconds = Streamable<int>.withListener(
      defaultSettings.chapterSeconds, () => _instance._onSettingsChanged());
  final notifyBeforeEnd = Streamable<bool>.withListener(
      defaultSettings.notifyBeforeEnd, () => _instance._onSettingsChanged());
  final secondsLeftCount = Streamable<int>.withListener(
      defaultSettings.secondsLeftCount, () => _instance._onSettingsChanged());
  final notifyEnds = Streamable<bool>.withListener(
      defaultSettings.notifyEnds, () => _instance._onSettingsChanged());
  final resetVisualClockEssay = Streamable<bool>.withListener(
      defaultSettings.resetVisualClockEssay,
      () => _instance._onSettingsChanged());
  final resetVisualClockChapter = Streamable<bool>.withListener(
      defaultSettings.resetVisualClockChapter,
      () => _instance._onSettingsChanged());
  final progressType = Streamable<ProgressType>.withListener(
      defaultSettings.progressType, () => _instance._onSettingsChanged());
  final showReset = Streamable<bool>.withListener(
      defaultSettings.showReset, () => _instance._onSettingsChanged());

  Settings generateSettings() => Settings(
        withEssay: withEssay.current,
        essaySeconds: essaySeconds.current,
        chaptersCount: chaptersCount.current,
        chapterSeconds: chapterSeconds.current,
        notifyBeforeEnd: notifyBeforeEnd.current,
        secondsLeftCount: secondsLeftCount.current,
        notifyEnds: notifyEnds.current,
        resetVisualClockEssay: resetVisualClockEssay.current,
        resetVisualClockChapter: resetVisualClockChapter.current,
        progressType: progressType.current,
        showReset: showReset.current,
      );

  void _setAll(Settings settings) {
    withEssay.set(settings.withEssay);
    essaySeconds.set(settings.essaySeconds);
    chaptersCount.set(settings.chaptersCount);
    chapterSeconds.set(settings.chapterSeconds);
    notifyBeforeEnd.set(settings.notifyBeforeEnd);
    secondsLeftCount.set(settings.secondsLeftCount);
    notifyEnds.set(settings.notifyEnds);
    resetVisualClockEssay.set(settings.resetVisualClockEssay);
    resetVisualClockChapter.set(settings.resetVisualClockChapter);
    progressType.set(settings.progressType);
    showReset.set(settings.showReset);
  }

  static const _storageKey = 'settingsV${Settings.version}';
  final _prefs = SharedPreferences.getInstance();
  bool _loaded = false;
  Timer? _timer;
  static const saveTimerDuration = Duration(seconds: 1);

  void _load(SharedPreferences prefs) {
    final jsonData = prefs.getString(_storageKey) ?? '{}';
    _setAll(
      Settings.fromJson(
        json.decode(jsonData),
      ),
    );
    if (jsonData == '{}') {
      _save(prefs);
    }
  }

  void _save(SharedPreferences prefs) {
    prefs.setString(_storageKey, json.encode(generateSettings().toJson()));
  }

  void _onSettingsChanged() {
    _timer?.cancel();
    _timer = Timer(
      saveTimerDuration,
      () async {
        var prefs = await _prefs;
        _save(prefs);
      },
    );
    _settingsSubject.add(null);
  }

  SettingsController._createInstance() {
    if (!_loaded) {
      (() async {
        var prefs = await _prefs;
        _loaded = true;
        _load(prefs);
      })();
    }
  }

  // singleton
  static final SettingsController _instance =
      SettingsController._createInstance();
  factory SettingsController() => _instance;
  static SettingsController get instance => _instance;
}
