import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tea_games/Auxiliadores/emailteste.dart';
import 'package:tea_games/Login_Cadastro/confirmarcadastro.dart';
import 'package:tea_games/Login_Cadastro/novasenha.dart';
import 'package:tea_games/alfabeto.dart';
import 'package:tea_games/fases_memorias/fase_menu_memoria.dart';
import 'package:tea_games/home.dart';
import 'package:tea_games/jogocalcular.dart';
import 'package:tea_games/jogoformas.dart';
import 'package:tea_games/jogomemoria.dart';
import 'package:tea_games/Auxiliadores/testetts.dart';

import 'Login_Cadastro/cadastror.dart';
import 'Login_Cadastro/loginr.dart';
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
import 'homeTeste.dart';
import 'jogoanimal.dart';
import 'jogoformasalternativo.dart';
import 'jogopareamento.dart';
import 'numeros.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: const [Locale('pt', 'BR')],
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/home',
      routes: {
        '/confirmarCadastro': (context) => const ConfirmarCadastro(),
        '/novasenha': (context) => const NovaSenha(),
        '/testes': (context) => const TesteTela(),
        '/home': (context) => const Home(),
        '/homeTeste': (context) => const HomeTeste(),
        '/pareamento': (context) =>
            const JogoPareamento(title: 'Flutter Demo Home Page'),
        '/memoria': (context) => const JogoMemoria(
              title: 'Teste',
            ),
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
        '/fasemenupareamento': (context) => const MenuFasePareamento(),
        '/jogocalcular': (context) => const JogoCalcular(title: 're'),
        '/numeros': (context) => const Numeros(
              title: 're',
            ),
        '/alfabeto': (context) => const Alfabeto(title: 're'),
        '/tts': (context) => const Testetts(),
        '/loginr': (context) => const LoginR(),
        '/cadastror': (context) => const CadastroR(),
        '/formas': (context) => const JogoFormas(),
        '/formas2': (context) => const JogoFormasAlternativo(),
        '/jogoanimal': (context) => const Animal()
      },
    );
  }
}
