import 'package:flutter/material.dart';
import 'package:tea_games/Auxiliadores/app_controller.dart';
import 'package:tea_games/DadosDB/crud.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body(),
    );
  }
}
