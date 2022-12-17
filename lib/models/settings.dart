final Settings defaults = Settings.fromJson({
  'withEssay': true,
  'essaySeconds': 30 * 60,
  'chaptersCount': 8,
  'chapterSeconds': 20 * 60,
  'notifyMinutesLeft': true,
  'secondsLeftCount': 5 * 60,
  'notifyEnds': true,
  'resetVisualClockEssay': true,
  'resetVisualClockChapter': true,
  'chapterPercent': true,
  'showReset': true,
});

class Settings {
  bool withEssay;
  int essaySeconds;

  int chaptersCount;
  int chapterSeconds;

  bool notifyMinutesLeft;
  int secondsLeftCount;

  bool notifyEnds;
  bool resetVisualClockEssay;
  bool resetVisualClockChapter;
  bool onlyChapterPercent;
  bool showReset;

  Settings({
    this.withEssay = true,
    this.essaySeconds = 30 * 60,
    this.chaptersCount = 8,
    this.chapterSeconds = 20 * 60,
    this.notifyMinutesLeft = true,
    this.secondsLeftCount = 5 * 60,
    this.notifyEnds = true,
    this.resetVisualClockEssay = true,
    this.resetVisualClockChapter = true,
    this.onlyChapterPercent = true,
    this.showReset = true,
  });

  Settings.fromJson(Map<String, dynamic> json)
      : withEssay = json['withEssay'] ?? defaults.withEssay,
        essaySeconds = json['essaySeconds'] ?? defaults.essaySeconds,
        chaptersCount = json['chaptersCount'] ?? defaults.chaptersCount,
        chapterSeconds = json['chapterSeconds'] ?? defaults.chapterSeconds,
        notifyMinutesLeft =
            json['notifyMinutesLeft'] ?? defaults.notifyMinutesLeft,
        secondsLeftCount =
            json['secondsLeftCount'] ?? defaults.secondsLeftCount,
        notifyEnds = json['notifyEnds'] ?? defaults.notifyEnds,
        resetVisualClockEssay =
            json['resetVisualClockEssay'] ?? defaults.resetVisualClockEssay,
        resetVisualClockChapter =
            json['resetVisualClockChapter'] ?? defaults.resetVisualClockChapter,
        onlyChapterPercent =
            json['chapterPercent'] ?? defaults.onlyChapterPercent,
        showReset = json['showReset'] ?? defaults.showReset;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['withEssay'] = withEssay;
    data['essaySeconds'] = essaySeconds;
    data['chaptersCount'] = chaptersCount;
    data['chapterSeconds'] = chapterSeconds;
    data['notifyMinutesLeft'] = notifyMinutesLeft;
    data['secondsLeftCount'] = secondsLeftCount;
    data['notifyEnds'] = notifyEnds;
    data['resetVisualClockEssay'] = resetVisualClockEssay;
    data['resetVisualClockChapter'] = resetVisualClockChapter;
    data['chapterPercent'] = onlyChapterPercent;
    data['showReset'] = showReset;
    return data;
  }
}
