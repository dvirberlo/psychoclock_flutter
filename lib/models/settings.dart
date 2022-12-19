final defaultSettings = Settings();

enum ProgressType { total, perPhase }

extension ProgressTypeJsonable on ProgressType {
  String toJson() {
    switch (this) {
      case ProgressType.total:
        return 'total';
      case ProgressType.perPhase:
        return 'perPhase';
    }
  }

  static ProgressType? fromJson(String? json) {
    switch (json) {
      case 'total':
        return ProgressType.total;
      case 'perPhase':
        return ProgressType.perPhase;
      default:
        return null;
    }
  }
}

class Settings {
  static const int version = 2;

  bool withEssay;
  int essaySeconds;
  int chaptersCount;
  int chapterSeconds;
  bool notifyBeforeEnd;
  int secondsLeftCount;
  bool notifyEnds;
  bool resetVisualClockEssay;
  bool resetVisualClockChapter;
  ProgressType progressType;
  bool showReset;

  Settings({
    this.withEssay = true,
    this.essaySeconds = 30 * 60,
    this.chaptersCount = 8,
    this.chapterSeconds = 20 * 60,
    this.notifyBeforeEnd = true,
    this.secondsLeftCount = 5 * 60,
    this.notifyEnds = true,
    this.resetVisualClockEssay = true,
    this.resetVisualClockChapter = true,
    this.progressType = ProgressType.perPhase,
    this.showReset = true,
  });

  Settings.fromJson(Map<String, dynamic> json)
      : withEssay = json['withEssay'] ?? defaultSettings.withEssay,
        essaySeconds = json['essaySeconds'] ?? defaultSettings.essaySeconds,
        chaptersCount = json['chaptersCount'] ?? defaultSettings.chaptersCount,
        chapterSeconds =
            json['chapterSeconds'] ?? defaultSettings.chapterSeconds,
        notifyBeforeEnd =
            json['notifyMinutesLeft'] ?? defaultSettings.notifyBeforeEnd,
        secondsLeftCount =
            json['secondsLeftCount'] ?? defaultSettings.secondsLeftCount,
        notifyEnds = json['notifyEnds'] ?? defaultSettings.notifyEnds,
        resetVisualClockEssay = json['resetVisualClockEssay'] ??
            defaultSettings.resetVisualClockEssay,
        resetVisualClockChapter = json['resetVisualClockChapter'] ??
            defaultSettings.resetVisualClockChapter,
        progressType = ProgressTypeJsonable.fromJson(json['progressType']) ??
            defaultSettings.progressType,
        showReset = json['showReset'] ?? defaultSettings.showReset;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['withEssay'] = withEssay;
    data['essaySeconds'] = essaySeconds;
    data['chaptersCount'] = chaptersCount;
    data['chapterSeconds'] = chapterSeconds;
    data['notifyMinutesLeft'] = notifyBeforeEnd;
    data['secondsLeftCount'] = secondsLeftCount;
    data['notifyEnds'] = notifyEnds;
    data['resetVisualClockEssay'] = resetVisualClockEssay;
    data['resetVisualClockChapter'] = resetVisualClockChapter;
    data['progressType'] = progressType.toJson();
    data['showReset'] = showReset;
    return data;
  }

  Settings copyWith({
    bool? withEssay,
    int? essaySeconds,
    int? chaptersCount,
    int? chapterSeconds,
    bool? notifyBeforeEnd,
    int? secondsLeftCount,
    bool? notifyEnds,
    bool? resetVisualClockEssay,
    bool? resetVisualClockChapter,
    ProgressType? progressType,
    bool? showReset,
  }) {
    return Settings(
      withEssay: withEssay ?? this.withEssay,
      essaySeconds: essaySeconds ?? this.essaySeconds,
      chaptersCount: chaptersCount ?? this.chaptersCount,
      chapterSeconds: chapterSeconds ?? this.chapterSeconds,
      notifyBeforeEnd: notifyBeforeEnd ?? this.notifyBeforeEnd,
      secondsLeftCount: secondsLeftCount ?? this.secondsLeftCount,
      notifyEnds: notifyEnds ?? this.notifyEnds,
      resetVisualClockEssay:
          resetVisualClockEssay ?? this.resetVisualClockEssay,
      resetVisualClockChapter:
          resetVisualClockChapter ?? this.resetVisualClockChapter,
      progressType: progressType ?? this.progressType,
      showReset: showReset ?? this.showReset,
    );
  }
}
