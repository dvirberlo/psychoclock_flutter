final defaultSettings = Settings();

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
      : withEssay = json['withEssay'] ?? defaultSettings.withEssay,
        essaySeconds = json['essaySeconds'] ?? defaultSettings.essaySeconds,
        chaptersCount = json['chaptersCount'] ?? defaultSettings.chaptersCount,
        chapterSeconds =
            json['chapterSeconds'] ?? defaultSettings.chapterSeconds,
        notifyMinutesLeft =
            json['notifyMinutesLeft'] ?? defaultSettings.notifyMinutesLeft,
        secondsLeftCount =
            json['secondsLeftCount'] ?? defaultSettings.secondsLeftCount,
        notifyEnds = json['notifyEnds'] ?? defaultSettings.notifyEnds,
        resetVisualClockEssay = json['resetVisualClockEssay'] ??
            defaultSettings.resetVisualClockEssay,
        resetVisualClockChapter = json['resetVisualClockChapter'] ??
            defaultSettings.resetVisualClockChapter,
        onlyChapterPercent =
            json['chapterPercent'] ?? defaultSettings.onlyChapterPercent,
        showReset = json['showReset'] ?? defaultSettings.showReset;

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
