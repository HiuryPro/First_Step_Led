import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import 'Auxiliadores/app_controller.dart';
import 'DadosDB/crud.dart';

class JogoPareamento extends StatefulWidget {
  const JogoPareamento({super.key, required this.title});
  final String title;

  @override
  State<JogoPareamento> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<JogoPareamento> {
  final audioPlayer = AudioPlayer();
  CRUD crud = CRUD();
  int scoreMaximo = AppController.instance.scoreMaximo;
  int scoreAtual = 0;
  int _counter = 0;
  List cartas = [
    "abacate",
    "abacate",
    "abacaxi",
    "abacaxi",
    "acerola",
    "acerola",
    "banana",
    "banana",
    "blueberry",
    "blueberry",
    "cereja",
    "cereja",
    "kiwi",
    "kiwi",
    "laranja",
    "laranja",
    "limao",
    "limao",
    "melancia",
    "melancia",
    "morango",
    "morango",
    "pera",
    "pera",
    "pessego",
    "pessego",
    "roma",
    "roma",
    "uva",
    "uva",
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
  ElevatedButton button = ElevatedButton(
    child: Text("Button"),
    onPressed: () async {
      while (true) {
        AudioPlayer backgroundAudio = AudioPlayer();
        await backgroundAudio.setAsset('assets/sounds/memoria.mp3',
            initialPosition: Duration.zero);
        await backgroundAudio.setVolume(0.3);
        await backgroundAudio.setLoopMode(LoopMode.all);
        await backgroundAudio.play();
        Duration? duration = await backgroundAudio.durationFuture;
        await Future.delayed(duration!);
      }
    },
  );

  @override
  void initState() {
    super.initState();
    cartas.shuffle();
    listaColor = List.filled(cartas.length, null);

    Future.delayed(Duration.zero, () async {
      button.onPressed?.call();
    });
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
          scoreAtual += 5;
        });

        if (scoreMaximo < scoreAtual) {
          List resultado = [];
          int id = AppController.instance.idUsuario;
          await crud.update(
              query:
                  'Update score set JOGO_PAREAMENTO = $scoreAtual where ID_USUARIO = $id',
              lista: []);

          resultado = await crud.select(
              query:
                  'Select JOGO_PAREAMENTO from score where ID_USUARIO = $id');
          setState(() {
            scoreMaximo = resultado[0]['JOGO_PAREAMENTO'];
          });
        }

        await audioPlayer.setAsset(
            'assets/sounds/frutas/${cartas[primeiraCartaSelecionada]}.mp3',
            initialPosition: Duration.zero);
        await audioPlayer.load();
        await audioPlayer.play();
      } else {
        print('Burro');
        await audioPlayer.setAsset('assets/sounds/errou.mp3',
            initialPosition: Duration.zero);
        await audioPlayer.load();
        await audioPlayer.play();
        setState(() {
          listaColor[segundaCartaSelecionada] = Colors.red;
          listaColor[primeiraCartaSelecionada] = Colors.red;
          scoreAtual = 0;
        });

        await Future.delayed(const Duration(seconds: 2));

        setState(() {
          listaColor.clear();
          listaColor = List.filled(cartas.length, null);
        });
      }
      primeiraCartaSelecionada = -1;
      segundaCartaSelecionada = -1;
    }
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
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

                              await Future.delayed(const Duration(seconds: 1));
                              setState(() {
                                listaColor = List.filled(cartas.length, null);
                                cartas.shuffle();
                              });
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
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () async {
                      setState(() {
                        cartas.shuffle();
                        listaColor = List.filled(cartas.length, null);
                        scoreAtual = 0;
                      });
                    },
                    icon: const Icon(
                      Icons.restart_alt,
                      size: 40,
                    )),
                const SizedBox(
                  width: 30,
                ),
                Text(
                  'Pontuação da Partida:  $scoreAtual',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  'Sua Maior Pontuação:  $scoreMaximo',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                )
              ],
            ),
          ),
        ],
      ),
      body: body(),
    );
  }
}
