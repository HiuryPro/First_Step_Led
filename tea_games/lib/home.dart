import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tea_games/Auxiliadores/app_controller.dart';
import 'package:tea_games/DadosDB/crud.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () async {
      await AppController.instance.backgroundMusic('home');
    });
  }

  Widget body() {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/fasemenumemoria');
                  },
                  child: const Text("Menu de Fases do Jogo da Memória")),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/fasemenupareamento');
                  },
                  child: const Text("Menu de Fases do Jogo de Pareamento")),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                  onPressed: () async {
                    int id = AppController.instance.idUsuario;
                    List resultado = [];
                    CRUD crud = CRUD();
                    resultado = await crud.select(
                        query:
                            'Select JOGO_MEMORIA from score where ID_USUARIO = $id');
                    AppController.instance.scoreMaximo =
                        resultado[0]['JOGO_MEMORIA'];
                    Navigator.of(context).pushNamed('/memoria');
                  },
                  child: const Text("Jogo da Memoria")),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                  onPressed: () async {
                    int id = AppController.instance.idUsuario;
                    List resultado = [];
                    CRUD crud = CRUD();
                    resultado = await crud.select(
                        query:
                            'Select JOGO_PAREAMENTO from score where ID_USUARIO = $id');
                    AppController.instance.scoreMaximo =
                        resultado[0]['JOGO_PAREAMENTO'];
                    Navigator.of(context).pushNamed('/pareamento');
                  },
                  child: const Text("Jogo de Pareamento")),
              const SizedBox(height: 15),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/jogocalcular');
                  },
                  child: const Text("Calculadora")),
              const SizedBox(height: 15),
              ElevatedButton(
                  onPressed: () {
                    if (!kIsWeb && Platform.isAndroid) {
                      Navigator.of(context).pushNamed('/formas');
                    } else {
                      Navigator.of(context).pushNamed('/formas2');
                    }
                  },
                  child: const Text("Jogo de Formas")),
              const SizedBox(height: 15),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/alfabeto');
                  },
                  child: const Text("Jogo das Letras")),
              const SizedBox(height: 15),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/numeros');
                  },
                  child: const Text("Jogo dos Números")),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () async {
              await AppController.instance.backgroundAudio.stop();
              Navigator.of(context).pushNamed('/loginr');
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: body(),
    );
  }
}
