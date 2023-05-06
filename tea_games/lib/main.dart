import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:just_audio/just_audio.dart';
import 'package:tea_games/Auxiliadores/textoprafala.dart';

import 'Auxiliadores/app_controller.dart';
import 'app_widget.dart';

void main() async {
  await dotenv.load(fileName: 'assets/.env');
  runApp(const MyApp());
  await Fala.instance.initTts();
  await Fala.instance2.initTts();
}
