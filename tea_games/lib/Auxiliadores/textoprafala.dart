import 'package:just_audio/just_audio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:io' as plataforma;

enum TtsState { playing, stopped, paused, continued }

class Fala {
  static var instance = Fala();
  static var instance2 = Fala();
  static var instance3 = Fala();

  late FlutterTts flutterTts;
  final audioPlayer = AudioPlayer();
  bool get isAndroid => !kIsWeb && plataforma.Platform.isAndroid;
  TtsState ttsState = TtsState.stopped;

  initTts() async {
    flutterTts = FlutterTts();
    await flutterTts.setVolume(1);
    await flutterTts.setSpeechRate(0.7);
    await flutterTts.setPitch(1.5);

    _setAwaitOptions();

    if (isAndroid) {
      _getDefaultEngine();
      _getDefaultVoice();
    }

    flutterTts.setErrorHandler((msg) {
      print("error: $msg");
      ttsState = TtsState.stopped;
    });
  }

  Future _getDefaultEngine() async {
    var engine = await flutterTts.getDefaultEngine;
    if (engine != null) {
      print(engine);
    }
  }

  Future _getDefaultVoice() async {
    var voice = await flutterTts.getDefaultVoice;
    if (voice != null) {
      print(voice);
    }
  }

  Future _setAwaitOptions() async {
    await flutterTts.awaitSpeakCompletion(true);
  }
}
