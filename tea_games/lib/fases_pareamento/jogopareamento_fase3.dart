import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';

import '../Auxiliadores/app_controller.dart';
import '../DadosDB/crud.dart';

class JogoPareamentoFase3 extends StatefulWidget {
  const JogoPareamentoFase3({super.key});

  @override
  State<JogoPareamentoFase3> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<JogoPareamentoFase3> {
  final audioPlayer = AudioPlayer();
  CRUD crud = CRUD();
  int fase = 3;
  List cartas = [
    "abacate",
    "abacate",
    "abacaxi",
    "abacaxi",
    "acerola",
    "acerola",
  ];

  List<Color?> listaColor = [
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
  ];

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight]);
    cartas.shuffle();
    listaColor = List.filled(cartas.length, null);
  }

  int primeiraCartaSelecionada = -1;
  int segundaCartaSelecionada = -1;

  Future<void> verificarPareamento(int index) async {
    if (primeiraCartaSelecionada == -1) {
      primeiraCartaSelecionada = index;
      setState(() {
        listaColor[primeiraCartaSelecionada] = Colors.green;
      });
    } else if (segundaCartaSelecionada == -1) {
      segundaCartaSelecionada = index;
      if (cartas[primeiraCartaSelecionada] == cartas[segundaCartaSelecionada]) {
        print(cartas[primeiraCartaSelecionada]);
        print('Pareou');
        setState(() {
          listaColor[segundaCartaSelecionada] = Colors.green;
        });
        await AppController.instance
            .respostaFruta('frutas/${cartas[primeiraCartaSelecionada]}.mp3');
      } else {
        print('Burro');
        await AppController.instance.respostaFruta('errou.mp3');
        setState(() {
          listaColor[segundaCartaSelecionada] = Colors.red;
          listaColor[primeiraCartaSelecionada] = Colors.red;
        });

        await Future.delayed(const Duration(seconds: 2));

        setState(() {
          listaColor[segundaCartaSelecionada] = null;
          listaColor[primeiraCartaSelecionada] = null;
        });
      }
      primeiraCartaSelecionada = -1;
      segundaCartaSelecionada = -1;
    }
  }

  Future<void> piscaImagens() async {
    setState(() {
      listaColor = List.filled(cartas.length, null);
    });
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      listaColor = List.filled(cartas.length, Colors.green);
    });
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      listaColor = List.filled(cartas.length, null);
    });
  }

  Widget body() {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 1,
                blurStyle: BlurStyle.normal // Shadow position
                ),
          ]),
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: GridView.builder(
                      itemCount: cartas.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 10),
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () async {
                            if (primeiraCartaSelecionada == -1 ||
                                segundaCartaSelecionada == -1) {
                              if (listaColor[index] == null) {
                                verificarPareamento(index);
                                setState(() {});
                              }

                              if (!listaColor.contains(null)) {
                                for (var i = 0; i < 3; i++) {
                                  await piscaImagens();
                                }
                                int id = AppController.instance.idUsuario;
                                await crud.update(
                                    query:
                                        'Update fases_pareamento set FASE_3 = 1 where ID_USUARIO = $id',
                                    lista: []);

                                await Future.delayed(Duration(seconds: 1));

                                Navigator.of(context)
                                    .pushNamed("/pareamentoFase${fase + 1}");
                              }
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: listaColor[index],
                            ),
                            child: Center(
                              child: IconButton(
                                iconSize: 70,
                                icon: Image.asset(
                                    'assets/images/frutas/${cartas[index]}.png'),
                                onPressed: null,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              )),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushNamed('/fasemenupareamento');
          },
        ),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.black.withOpacity(0.2),
      ),
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              'assets/images/pareamento.jpg',
              fit: BoxFit.cover,
            ),
          ),
          body(),
        ],
      ),
    );
  }
}
