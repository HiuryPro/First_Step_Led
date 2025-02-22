import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

import '../Auxiliadores/app_controller.dart';
import '../DadosDB/crud.dart';

class JogoMemoriaFase1 extends StatefulWidget {
  const JogoMemoriaFase1({super.key});

  @override
  State<JogoMemoriaFase1> createState() => _JogoMemoriaFase1State();
}

class _JogoMemoriaFase1State extends State<JogoMemoriaFase1> {
  bool visivel = true;
  int fase = 1;
  List<GlobalObjectKey<FlipCardState>> cardKeys = [];
  final audioPlayer = AudioPlayer();
  List cartas = [
    "abacate",
    "abacate",
  ];

  CRUD crud = CRUD();

  List<Color?> listaColor = [
    null,
    null,
  ];

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight]);
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

        await cardKeys[segundaCartaSelecionada].currentState!.toggleCard();
        await cardKeys[primeiraCartaSelecionada].currentState!.toggleCard();

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
                              mainAxisSpacing: 20,
                              crossAxisSpacing: 20,
                              crossAxisCount: 10),
                      itemBuilder: (BuildContext context, int index) {
                        return FlipCard(
                          flipOnTouch: false,
                          key: cardKeys[index],
                          fill: Fill
                              .fillBack, // Fill the back side of the card to make in the same size as the front.
                          direction: FlipDirection.HORIZONTAL, // default
                          side:
                              CardSide.FRONT, // The side to initially display.
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
                                  int id = AppController.instance.idUsuario;
                                  await crud.update(
                                      query:
                                          'Update fases_memoria set FASE_1 = 1 where ID_USUARIO = $id',
                                      lista: []);

                                  await Future.delayed(Duration(seconds: 1));
                                  Navigator.of(context)
                                      .pushNamed("/memoriaFase${fase + 1}");
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
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          cartas.shuffle();
                        });
                        await Future.delayed(const Duration(seconds: 2));
                        for (int i = 0; i < cardKeys.length; i++) {
                          await cardKeys[i].currentState!.toggleCard();
                        }
                      },
                      child: const Text('Começar')),
                ],
              )),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushNamed('/fasemenumemoria');
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
              'assets/images/fundomemoria.jpg',
              fit: BoxFit.cover,
            ),
          ),
          body(),
        ],
      ),
    );
  }
}
