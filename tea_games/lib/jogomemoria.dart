import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:tea_games/DadosDB/crud.dart';

import 'Auxiliadores/app_controller.dart';

class JogoMemoria extends StatefulWidget {
  const JogoMemoria({super.key, required this.title});
  final String title;

  @override
  State<JogoMemoria> createState() => _JogoMemoriaState();
}

class _JogoMemoriaState extends State<JogoMemoria> {
  CRUD crud = CRUD();

  int scoreMaximo = AppController.instance.scoreMaximo;
  int scoreAtual = 0;
  bool jogando = false;
  List<GlobalObjectKey<FlipCardState>> cardKeys = [];
  final GlobalKey<ScaffoldState> buttonkeyS = GlobalKey();
  GlobalKey keyButton = GlobalKey();
  final audioPlayer = AudioPlayer();
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

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight]);
    super.initState();
    Future.delayed(Duration.zero, () async {
      int id = AppController.instance.idUsuario;
      List resultado = [];
      CRUD crud = CRUD();
      resultado = await crud.select(
          query: 'Select JOGO_MEMORIA from score where ID_USUARIO = $id');
      setState(() {
        print(resultado);
        scoreMaximo =
            AppController.instance.scoreMaximo = resultado[0]['JOGO_MEMORIA'];
      });

      await AppController.instance.backgroundMusic('memoria');
    });

    cartas.shuffle();
    listaColor = List.filled(cartas.length, null);
    for (int i = 0; i < cartas.length; i++) {
      cardKeys.add(GlobalObjectKey<FlipCardState>(
          AppController.instance.incrementaCarta));
      AppController.instance.incrementaCarta++;
    }
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
                  'Update score set JOGO_MEMORIA = $scoreAtual where ID_USUARIO = $id',
              lista: []);

          resultado = await crud.select(
              query: 'Select JOGO_MEMORIA from score where ID_USUARIO = $id');
          setState(() {
            scoreMaximo = resultado[0]['JOGO_MEMORIA'];
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
        });

        await Future.delayed(const Duration(seconds: 2));

        for (int i = 0; i < listaColor.length; i++) {
          if (listaColor[i] != null) {
            await cardKeys[i].currentState!.toggleCard();
          }
        }

        setState(() {
          scoreAtual = 0;
          listaColor = List.filled(cartas.length, null);
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 40.0, left: 40.0),
                    child: Center(
                      child: GridView.builder(
                        itemCount: cartas.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisSpacing: 5,
                                crossAxisSpacing: 5,
                                crossAxisCount: 10),
                        itemBuilder: (BuildContext context, int index) {
                          return FlipCard(
                            flipOnTouch: false,
                            key: cardKeys[index],
                            fill: Fill
                                .fillBack, // Fill the back side of the card to make in the same size as the front.
                            direction: FlipDirection.HORIZONTAL, // default
                            side: CardSide
                                .FRONT, // The side to initially display.
                            front: Container(
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

                            back: GestureDetector(
                              onTap: () async {
                                if (primeiraCartaSelecionada == -1 ||
                                    segundaCartaSelecionada == -1) {
                                  if (listaColor[index] == null) {
                                    await cardKeys[index]
                                        .currentState!
                                        .toggleCard();
                                    await verificarPareamento(index);
                                    setState(() {});
                                  }

                                  if (!listaColor.contains(null)) {
                                    for (var i = 0; i < 3; i++) {
                                      await piscaImagens();
                                    }

                                    await Future.delayed(
                                        const Duration(seconds: 1));
                                    setState(() {
                                      listaColor =
                                          List.filled(cartas.length, null);
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
                                child: Image.asset(
                                  'assets/images/costasCarta.jpg',
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                if (!jogando)
                  ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          cartas.shuffle();
                          jogando = true;
                        });
                        await Future.delayed(const Duration(seconds: 2));
                        for (int i = 0; i < cardKeys.length; i++) {
                          await cardKeys[i].currentState!.toggleCard();
                        }
                      },
                      child: const Text('Começar')),
              ],
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          leading: IconButton(
              onPressed: () async {
                await AppController.instance.backgroundMusic('home');
                Navigator.of(context).pushNamed('/home');
              },
              icon: Icon(Icons.arrow_back)),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.black.withOpacity(0.2),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (jogando)
                    IconButton(
                        onPressed: () async {
                          for (int i = 0; i < listaColor.length; i++) {
                            if (listaColor[i] == null) {
                              await cardKeys[i].currentState!.toggleCard();
                            }
                          }
                          setState(() {
                            listaColor = List.filled(cartas.length, null);
                          });
                          await Future.delayed(const Duration(seconds: 2));
                          setState(() {
                            cartas.shuffle();
                            scoreAtual = 0;
                          });

                          await Future.delayed(const Duration(seconds: 5));

                          for (int i = 0; i < listaColor.length; i++) {
                            if (listaColor[i] == null) {
                              await cardKeys[i].currentState!.toggleCard();
                            }
                          }
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
          ]),
      body: Stack(children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Image.asset(
            'assets/images/fundomemoria.jpg',
            fit: BoxFit.cover,
          ),
        ),
        body()
      ]),
    );
  }
}
