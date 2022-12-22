import 'package:audioplayers/audioplayers.dart';

import 'settings_controller.dart';

const List<Voice> voiceList = [
  Voice(
    name: "Male",
    folder: "male",
  ),
  Voice(
    name: "Female",
    folder: "female",
  ),
  Voice(
    name: "Kid",
    folder: "kid",
  ),
];
Voice? getVoice(int id) {
  if (id < 0 || id >= voiceList.length) return null;
  return voiceList[id];
}

class VoiceNotifier {
  final Map<int, VoicePlayer> _voicePlayers = {};

  VoicePlayer getPlayer(int voiceId) {
    if (voiceId < 0 || voiceId >= voiceList.length) {
      return VoicePlayer(voiceList[0]);
    }
    if (!_voicePlayers.containsKey(voiceId)) {
      _voicePlayers[voiceId] = VoicePlayer(voiceList[voiceId]);
    }
    return _voicePlayers[voiceId]!;
  }

  VoicePlayer get currentPlayer =>
      getPlayer(SettingsController().voiceId.current);

  // singleton
  VoiceNotifier._createInstance();
  static final _instance = VoiceNotifier._createInstance();
  factory VoiceNotifier() => _instance;
  static VoiceNotifier get instance => _instance;
}

enum VoicePlays {
  clockStart,
  clockContinue,
  minLeft,
  nextChapter,
  clockEnd,
  demoVoice
}

class Voice {
  final String name;
  final String folder;
  const Voice({
    required this.name,
    required this.folder,
  });
}

class VoicePlayer {
  final Voice voice;
  final AudioPlayer _player;

  VoicePlayer(this.voice)
      : _player = AudioPlayer(playerId: 'voicePlayer_${voice.name}');

  Future<void> play(VoicePlays play, {bool parallel = false}) async {
    if (!parallel) cancel();
    await _player.play(AssetSource(_getPath(play)));
  }

  Future<void> cancel() => _player.stop();

  String _getPath(VoicePlays play) {
    String name = 'voice';
    switch (play) {
      case VoicePlays.clockStart:
        name = 'start';
        break;
      case VoicePlays.clockContinue:
        name = 'cont';
        break;
      case VoicePlays.minLeft:
        name = 'left';
        break;
      case VoicePlays.nextChapter:
        name = 'next';
        break;
      case VoicePlays.clockEnd:
        name = 'end';
        break;
      case VoicePlays.demoVoice:
        name = 'voice';
        break;
    }
    return 'voices/${voice.folder}_$name.mp3';
  }
}
