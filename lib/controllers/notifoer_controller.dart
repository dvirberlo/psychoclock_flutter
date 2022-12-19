abstract class Notifier {
  void cancel();
  void clockStart();
  void clockContinue();
  void minutesLeft(int count);
  void nextChapter();
  void end();
}

// for now, just print to console
// TODO: implement real notifier
class VoiceNotifier implements Notifier {
  const VoiceNotifier();
  @override
  void cancel() {
    print("VoiceNotifier.cancel()");
  }

  @override
  void clockStart() {
    print("VoiceNotifier.start()");
  }

  @override
  void clockContinue() {
    print("VoiceNotifier.continue()");
  }

  @override
  void minutesLeft(int count) {
    print("VoiceNotifier.minutesLeft($count)");
  }

  @override
  void nextChapter() {
    print("VoiceNotifier.nextChapter()");
  }

  @override
  void end() {
    print("VoiceNotifier.end()");
  }
}
