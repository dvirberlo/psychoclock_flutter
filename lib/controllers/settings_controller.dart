import 'dart:async';
import 'dart:convert';

import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/settings.dart';

// Did you hear it? OOP mean boillerplate code, sad but true.
// Where are you, my dear TypeScript? :(
class SettingsController {
  final BehaviorSubject _setAll = BehaviorSubject.seeded(null);
  ValueStream get stream$ => _setAll.stream;

  final BehaviorSubject _setWithEssay = BehaviorSubject.seeded(null);
  ValueStream get streamWithEssay$ => _setWithEssay.stream;
  final BehaviorSubject _setEssaySeconds = BehaviorSubject.seeded(null);
  ValueStream get streamEssaySeconds$ => _setEssaySeconds.stream;

  final BehaviorSubject _setChaptersCount = BehaviorSubject.seeded(null);
  ValueStream get streamChaptersCount$ => _setChaptersCount.stream;
  final BehaviorSubject _setChapterSeconds = BehaviorSubject.seeded(null);
  ValueStream get streamChapterSeconds$ => _setChapterSeconds.stream;

  final BehaviorSubject _setNotifyMinutesLeft = BehaviorSubject.seeded(null);
  ValueStream get streamNotifyMinutesLeft$ => _setNotifyMinutesLeft.stream;
  final BehaviorSubject _setSecondsLeftCount = BehaviorSubject.seeded(null);
  ValueStream get streamSecondsLeftCount$ => _setSecondsLeftCount.stream;

  final BehaviorSubject _setNotifyEnds = BehaviorSubject.seeded(null);
  ValueStream get streamNotifyEnds$ => _setNotifyEnds.stream;
  final BehaviorSubject _setResetVisualClockEssay =
      BehaviorSubject.seeded(null);
  ValueStream get streamResetVisualClockEssay$ =>
      _setResetVisualClockEssay.stream;
  final BehaviorSubject _setResetVisualClockChapter =
      BehaviorSubject.seeded(null);
  ValueStream get streamResetVisualClockChapter$ =>
      _setResetVisualClockChapter.stream;
  final BehaviorSubject _setChapterPercent = BehaviorSubject.seeded(null);
  ValueStream get streamChapterPercent$ => _setChapterPercent.stream;
  final BehaviorSubject _setShowReset = BehaviorSubject.seeded(null);
  ValueStream get streamShowReset$ => _setShowReset.stream;

  final _settings = Settings();

  Settings get settings => _settings;

  void setAll(Settings settings) {
    if (_settings.withEssay != settings.withEssay) {
      _settings.withEssay = settings.withEssay;
      _setWithEssay.add(null);
    }
    if (_settings.essaySeconds != settings.essaySeconds) {
      _settings.essaySeconds = settings.essaySeconds;
      _setEssaySeconds.add(null);
    }

    if (_settings.chaptersCount != settings.chaptersCount) {
      _settings.chaptersCount = settings.chaptersCount;
      _setChaptersCount.add(null);
    }
    if (_settings.chapterSeconds != settings.chapterSeconds) {
      _settings.chapterSeconds = settings.chapterSeconds;
      _setChapterSeconds.add(null);
    }

    if (_settings.notifyMinutesLeft != settings.notifyMinutesLeft) {
      _settings.notifyMinutesLeft = settings.notifyMinutesLeft;
      _setNotifyMinutesLeft.add(null);
    }
    if (_settings.secondsLeftCount != settings.secondsLeftCount) {
      _settings.secondsLeftCount = settings.secondsLeftCount;
      _setSecondsLeftCount.add(null);
    }

    if (_settings.notifyEnds != settings.notifyEnds) {
      _settings.notifyEnds = settings.notifyEnds;
      _setNotifyEnds.add(null);
    }
    if (_settings.resetVisualClockEssay != settings.resetVisualClockEssay) {
      _settings.resetVisualClockEssay = settings.resetVisualClockEssay;
      _setResetVisualClockEssay.add(null);
    }
    if (_settings.resetVisualClockChapter != settings.resetVisualClockChapter) {
      _settings.resetVisualClockChapter = settings.resetVisualClockChapter;
      _setResetVisualClockChapter.add(null);
    }
    if (_settings.onlyChapterPercent != settings.onlyChapterPercent) {
      _settings.onlyChapterPercent = settings.onlyChapterPercent;
      _setChapterPercent.add(null);
    }
    if (_settings.showReset != settings.showReset) {
      _settings.showReset = settings.showReset;
      _setShowReset.add(null);
    }
    _setAll.add(settings);
    _onSettingsChanged();
  }

  void setWithEssay(bool withEssay) {
    if (_settings.withEssay != withEssay) {
      _settings.withEssay = withEssay;
      _setWithEssay.add(null);
      _setAll.add(null);
      _onSettingsChanged();
    }
  }

  void setEssaySeconds(int essaySeconds) {
    if (_settings.essaySeconds != essaySeconds) {
      _settings.essaySeconds = essaySeconds;
      _setEssaySeconds.add(null);
      _setAll.add(null);
      _onSettingsChanged();
    }
  }

  void setChaptersCount(int chaptersCount) {
    if (_settings.chaptersCount != chaptersCount) {
      _settings.chaptersCount = chaptersCount;
      _setChaptersCount.add(null);
      _setAll.add(null);
      _onSettingsChanged();
    }
  }

  void setChapterSeconds(int chapterSeconds) {
    if (_settings.chapterSeconds != chapterSeconds) {
      _settings.chapterSeconds = chapterSeconds;
      _setChapterSeconds.add(null);
      _setAll.add(null);
      _onSettingsChanged();
    }
  }

  void setNotifyMinutesLeft(bool notifyMinutesLeft) {
    if (_settings.notifyMinutesLeft != notifyMinutesLeft) {
      _settings.notifyMinutesLeft = notifyMinutesLeft;
      _setNotifyMinutesLeft.add(null);
      _setAll.add(null);
      _onSettingsChanged();
    }
  }

  void setSecondsLeftCount(int secondsLeftCount) {
    if (_settings.secondsLeftCount != secondsLeftCount) {
      _settings.secondsLeftCount = secondsLeftCount;
      _setSecondsLeftCount.add(null);
      _setAll.add(null);
      _onSettingsChanged();
    }
  }

  void setNotifyEnds(bool notifyEnds) {
    if (_settings.notifyEnds != notifyEnds) {
      _settings.notifyEnds = notifyEnds;
      _setNotifyEnds.add(null);
      _setAll.add(null);
      _onSettingsChanged();
    }
  }

  void setResetVisualClockEssay(bool resetVisualClockEssay) {
    if (_settings.resetVisualClockEssay != resetVisualClockEssay) {
      _settings.resetVisualClockEssay = resetVisualClockEssay;
      _setResetVisualClockEssay.add(null);
      _setAll.add(null);
      _onSettingsChanged();
    }
  }

  void setResetVisualClockChapter(bool resetVisualClockChapter) {
    if (_settings.resetVisualClockChapter != resetVisualClockChapter) {
      _settings.resetVisualClockChapter = resetVisualClockChapter;
      _setResetVisualClockChapter.add(null);
      _setAll.add(null);
      _onSettingsChanged();
    }
  }

  void setOnlyChapterPercent(bool onlyChapterPercent) {
    if (_settings.onlyChapterPercent != onlyChapterPercent) {
      _settings.onlyChapterPercent = onlyChapterPercent;
      _setChapterPercent.add(null);
      _setAll.add(null);
      _onSettingsChanged();
    }
  }

  void setShowReset(bool showReset) {
    if (_settings.showReset != showReset) {
      _settings.showReset = showReset;
      _setShowReset.add(null);
      _setAll.add(null);
      _onSettingsChanged();
    }
  }

  final _prefs = SharedPreferences.getInstance();
  bool _loaded = false;
  Timer? _timer;
  static const saveTimerDuration = Duration(seconds: 3);

  void _load(SharedPreferences prefs) {
    final jsonData = prefs.getString('settings') ?? '{}';
    setAll(
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
