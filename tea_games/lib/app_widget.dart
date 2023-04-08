import 'package:flutter/material.dart';
import 'package:tea_games/fases_memorias/fase_menu_memoria.dart';
import 'package:tea_games/jogomemoria.dart';

import 'fases_memorias/jogomemoria_fase1.dart';
import 'fases_memorias/jogomemoria_fase2.dart';
import 'fases_memorias/jogomemoria_fase3.dart';
import 'fases_memorias/jogomemoria_fase4.dart';
import 'fases_memorias/jogomemoria_fase5.dart';
import 'fases_memorias/jogomemoria_fase6.dart';
import 'fases_pareamento/fase_menu_pareamento.dart';
import 'fases_pareamento/jogopareamento_fase1.dart';
import 'fases_pareamento/jogopareamento_fase2.dart';
import 'fases_pareamento/jogopareamento_fase3.dart';
import 'fases_pareamento/jogopareamento_fase4.dart';
import 'fases_pareamento/jogopareamento_fase5.dart';
import 'fases_pareamento/jogopareamento_fase6.dart';
import 'jogopareamento.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/fasemenupareamento',
      routes: {
        '/pareamento': (context) =>
            const JogoPareamento(title: 'Flutter Demo Home Page'),
        '/memoriaFase1': (context) => const JogoMemoriaFase1(title: 'Teste'),
        '/memoriaFase2': (context) => const JogoMemoriaFase2(title: 'Teste'),
        '/memoriaFase3': (context) => const JogoMemoriaFase3(title: 'Teste'),
        '/memoriaFase4': (context) => const JogoMemoriaFase4(title: 'Teste'),
        '/memoriaFase5': (context) => const JogoMemoriaFase5(title: 'Teste'),
        '/memoriaFase6': (context) => const JogoMemoriaFase6(title: 'Teste'),
        '/fasemenumemoria': (context) => const MenuFaseMemoria(),
        '/pareamentoFase1': (context) =>
            const JogoPareamentoFase1(title: 'Teste'),
        '/pareamentoFase2': (context) =>
            const JogoPareamentoFase2(title: 'Teste'),
        '/pareamentoFase3': (context) =>
            const JogoPareamentoFase3(title: 'Teste'),
        '/pareamentoFase4': (context) =>
            const JogoPareamentoFase4(title: 'Teste'),
        '/pareamentoFase5': (context) =>
            const JogoPareamentoFase5(title: 'Teste'),
        '/pareamentoFase6': (context) =>
            const JogoPareamentoFase6(title: 'Teste'),
        '/fasemenupareamento': (context) => const MenuFasePareamento()
      },
    );
  }
}
