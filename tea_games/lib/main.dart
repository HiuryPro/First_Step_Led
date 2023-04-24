import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:tea_games/textoprafala.dart';

import 'app_controller.dart';
import 'app_widget.dart';

void main() async {
  runApp(const MyApp());
  await Fala.instance.initTts();
}
