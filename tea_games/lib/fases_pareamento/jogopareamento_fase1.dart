import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../Auxiliadores/app_controller.dart';

class JogoPareamentoFase1 extends StatefulWidget {
  const JogoPareamentoFase1({super.key, required this.title});
  final String title;

  @override
  State<JogoPareamentoFase1> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<JogoPareamentoFase1> {
  final audioPlayer = AudioPlayer();
  int fase = 1;
  List cartas = [
    "abacate",
    "abacate",
  ];

  List<Color?> listaColor = [
    null,
    null,
  ];

  @override
  void initState() {
    super.initState();
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
          print(index);
        });
        setState(() {
          listaColor[segundaCartaSelecionada] = Colors.green;
          print(index);
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
                          print(index);
                          if (primeiraCartaSelecionada == -1 ||
                              segundaCartaSelecionada == -1) {
                            if (listaColor[index] == null) {
                              setState(() {
                                verificarPareamento(index);
                              });
                            }
                            print(listaColor);
                            if (!listaColor.contains(null)) {
                              print('Nfsdf');
                              for (var i = 0; i < 3; i++) {
                                await piscaImagens();
                              }

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
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: body(),
    );
  }
}
