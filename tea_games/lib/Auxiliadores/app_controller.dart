import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class AppController extends ChangeNotifier {
  static AppController instance = AppController();
  AudioPlayer backgroundAudio = AudioPlayer();
  AudioPlayer audioPlayer = AudioPlayer();
  bool isDarkTheme = false;
  String background = "assets/images/back2.jpg";
  String logo = "assets/images/Stocker_blue_transpN.png";
  Color theme1 = Colors.black;
  Color theme2 = const Color(0xFF0080d9);

  String email = '';
  String senha = '';
  String nome = '';
  int idUsuario = 0;
  int scoreMaximo = 0;

  int incrementaCarta = 0;

  int loginAntigo = 0;
  String nomeNS = "";
  bool alteraTela = true;
  String musicaAtual = "";

  changeTheme() {
    isDarkTheme = !isDarkTheme;
    if (isDarkTheme) {
      background = "assets/images/back2B.jpg";
      logo = "assets/images/Stocker_blue_transpNB.png";
      theme1 = Colors.white;
      theme2 = const Color(0xFF710a9f);
    } else {
      background = "assets/images/back2.jpg";
      logo = "assets/images/Stocker_blue_transpN.png";
      theme1 = Colors.black;
      theme2 = const Color(0xFF0080d9);
    }
    notifyListeners();
  }

  Future<void> backgroundMusic(String musica) async {
    await backgroundAudio.stop();
    backgroundAudio = new AudioPlayer();
    await backgroundAudio.setAsset('assets/sounds/$musica.mp3',
        initialPosition: Duration.zero);
    await backgroundAudio.setLoopMode(LoopMode.one);
    await backgroundAudio.setVolume(0.15);
    await backgroundAudio.play();
  }

  Future<void> respostaFruta(String resposta) async {
    await audioPlayer.setAsset('assets/sounds/$resposta',
        initialPosition: Duration.zero);
    await audioPlayer.setVolume(1.0);
    await audioPlayer.load();
    await audioPlayer.play();
  }
}
