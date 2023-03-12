import 'package:audioplayers/audioplayers.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

class JogoMemoria extends StatefulWidget {
  const JogoMemoria({super.key, required this.title});
  final String title;

  @override
  State<JogoMemoria> createState() => _JogoMemoriaState();
}

class _JogoMemoriaState extends State<JogoMemoria> {
  List<GlobalObjectKey<FlipCardState>> cardKeys = [];
  final audioPlayer = AudioPlayer();
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
  @override
  void initState() {
    super.initState();
    cartas.shuffle();
    listaColor = List.filled(cartas.length, null);
    cardKeys = List.generate(
        cartas.length, (index) => GlobalObjectKey<FlipCardState>(index));
  }

  int primeiraCartaSelecionada = -1;
  int segundaCartaSelecionada = -1;

  void verificarPareamento(int index) async {
    if (primeiraCartaSelecionada == -1) {
      primeiraCartaSelecionada = index;
      setState(() {
        listaColor[primeiraCartaSelecionada] = Colors.green;
      });
    } else if (segundaCartaSelecionada == -1) {
      segundaCartaSelecionada = index;
      if (cartas[primeiraCartaSelecionada] == cartas[segundaCartaSelecionada]) {
        print(cartas[primeiraCartaSelecionada]);
        var player = AudioCache(prefix: 'assets/sounds/frutas/');
        var url = await player.load('${cartas[primeiraCartaSelecionada]}.mp3');
        print(url);
        print('Pareou');
        setState(() {
          listaColor[segundaCartaSelecionada] = Colors.green;
        });
        await audioPlayer.play(url.path);
      } else {
        print('Burro');

        listaColor[segundaCartaSelecionada] = Colors.red;
        listaColor[primeiraCartaSelecionada] = Colors.red;
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
                        side: CardSide.FRONT, // The side to initially display.
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
                                verificarPareamento(index);
                                setState(() {});
                              }

                              if (!listaColor.contains(null)) {
                                for (var i = 0; i < 3; i++) {
                                  await piscaImagens();
                                }

                                await Future.delayed(
                                    const Duration(seconds: 1));
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
                    child: const Text('Começar'))
              ],
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: body(),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
