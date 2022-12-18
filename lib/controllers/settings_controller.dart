import 'dart:async';
import 'dart:convert';

import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/settings.dart';
import 'shared/streamable.dart';

// Did you hear it? OOP mean boillerplate code, sad but true.
// Where are you, my dear TypeScript? :(

class SettingsController {
  final Settings _settings = Settings();
  final BehaviorSubject _settingsSubject = BehaviorSubject.seeded(null);
  Stream get settingsChanges$ => _settingsSubject.stream;
  Settings get settings => _settings;

  final Streamable withEssay = Streamable<bool>.withOnSet(
      defaultSettings.withEssay, () => _instance._onSettingsChanged());
  final Streamable essaySeconds = Streamable<int>.withOnSet(
      defaultSettings.essaySeconds, () => _instance._onSettingsChanged());
  final Streamable chaptersCount = Streamable<int>.withOnSet(
      defaultSettings.chaptersCount, () => _instance._onSettingsChanged());
  final Streamable chapterSeconds = Streamable<int>.withOnSet(
      defaultSettings.chapterSeconds, () => _instance._onSettingsChanged());
  final Streamable notifyMinutesLeft = Streamable<bool>.withOnSet(
      defaultSettings.notifyMinutesLeft, () => _instance._onSettingsChanged());
  final Streamable secondsLeftCount = Streamable<int>.withOnSet(
      defaultSettings.secondsLeftCount, () => _instance._onSettingsChanged());
  final Streamable notifyEnds = Streamable<bool>.withOnSet(
      defaultSettings.notifyEnds, () => _instance._onSettingsChanged());
  final Streamable resetVisualClockEssay = Streamable<bool>.withOnSet(
      defaultSettings.resetVisualClockEssay,
      () => _instance._onSettingsChanged());
  final Streamable resetVisualClockChapter = Streamable<bool>.withOnSet(
      defaultSettings.resetVisualClockChapter,
      () => _instance._onSettingsChanged());
  final Streamable onlyChapterPercent = Streamable<bool>.withOnSet(
      defaultSettings.onlyChapterPercent, () => _instance._onSettingsChanged());
  final Streamable showReset = Streamable<bool>.withOnSet(
      defaultSettings.showReset, () => _instance._onSettingsChanged());

  void _setAll(Settings settings) {
    withEssay.set(settings.withEssay);
    essaySeconds.set(settings.essaySeconds);
    chaptersCount.set(settings.chaptersCount);
    chapterSeconds.set(settings.chapterSeconds);
    notifyMinutesLeft.set(settings.notifyMinutesLeft);
    secondsLeftCount.set(settings.secondsLeftCount);
    notifyEnds.set(settings.notifyEnds);
    resetVisualClockEssay.set(settings.resetVisualClockEssay);
    resetVisualClockChapter.set(settings.resetVisualClockChapter);
    onlyChapterPercent.set(settings.onlyChapterPercent);
    showReset.set(settings.showReset);
  }

  final _prefs = SharedPreferences.getInstance();
  bool _loaded = false;
  Timer? _timer;
  static const saveTimerDuration = Duration(seconds: 3);

  void _load(SharedPreferences prefs) {
    final jsonData = prefs.getString('settings') ?? '{}';
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
    prefs.setString('settings', json.encode(_settings.toJson()));
  }

  void _onSettingsChanged() {
    if (_timer != null) {
      _timer!.cancel();
    }
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
