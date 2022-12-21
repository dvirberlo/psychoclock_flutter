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

enum ResetType { never, essay, always }

extension ResetTypeJsonable on ResetType {
  String toJson() {
    switch (this) {
      case ResetType.never:
        return 'never';
      case ResetType.essay:
        return 'essay';
      case ResetType.always:
        return 'always';
    }
  }

  static ResetType? fromJson(String? json) {
    switch (json) {
      case 'never':
        return ResetType.never;
      case 'essay':
        return ResetType.essay;
      case 'always':
        return ResetType.always;
      default:
        return null;
    }
  }
}

class Settings {
  static const int version = 3;

  bool withEssay;
  int essaySeconds;
  int chaptersCount;
  int chapterSeconds;
  bool notifyBeforeEnd;
  int secondsLeftCount;
  bool notifyEnds;
  bool showReset;
  ResetType resetType;
  ProgressType progressType;

  Settings({
    this.withEssay = true,
    this.essaySeconds = 30 * 60,
    this.chaptersCount = 8,
    this.chapterSeconds = 20 * 60,
    this.notifyBeforeEnd = true,
    this.secondsLeftCount = 5 * 60,
    this.notifyEnds = true,
    this.showReset = true,
    this.resetType = ResetType.always,
    this.progressType = ProgressType.perPhase,
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
        showReset = json['showReset'] ?? defaultSettings.showReset,
        progressType = ProgressTypeJsonable.fromJson(json['progressType']) ??
            defaultSettings.progressType,
        resetType = ResetTypeJsonable.fromJson(json['resetType']) ??
            defaultSettings.resetType;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['withEssay'] = withEssay;
    data['essaySeconds'] = essaySeconds;
    data['chaptersCount'] = chaptersCount;
    data['chapterSeconds'] = chapterSeconds;
    data['notifyMinutesLeft'] = notifyBeforeEnd;
    data['secondsLeftCount'] = secondsLeftCount;
    data['notifyEnds'] = notifyEnds;
    data['showReset'] = showReset;
    data['resetType'] = resetType.toJson();
    data['progressType'] = progressType.toJson();
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
    bool? showReset,
    ResetType? resetType,
    ProgressType? progressType,
  }) {
    return Settings(
      withEssay: withEssay ?? this.withEssay,
      essaySeconds: essaySeconds ?? this.essaySeconds,
      chaptersCount: chaptersCount ?? this.chaptersCount,
      chapterSeconds: chapterSeconds ?? this.chapterSeconds,
      notifyBeforeEnd: notifyBeforeEnd ?? this.notifyBeforeEnd,
      secondsLeftCount: secondsLeftCount ?? this.secondsLeftCount,
      notifyEnds: notifyEnds ?? this.notifyEnds,
      showReset: showReset ?? this.showReset,
      resetType: resetType ?? this.resetType,
      progressType: progressType ?? this.progressType,
    );
  }
}
