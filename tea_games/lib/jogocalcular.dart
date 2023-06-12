import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:tea_games/Auxiliadores/textoprafala.dart';

import 'Auxiliadores/app_controller.dart';

class JogoCalcular extends StatefulWidget {
  const JogoCalcular({super.key});

  @override
  State<JogoCalcular> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<JogoCalcular> {
  int acceptedData = 0;
  final audioPlayer = AudioPlayer();
  int escolha = 0;
  List cartas = [
    '1',
    '2',
    '3',
    '+',
    '4',
    '5',
    '6',
    '-',
    '7',
    '8',
    '9',
    '÷',
    '0',
    '*',
  ];
  bool divisao = false;
  String? num1;
  String? operador;
  String? num2;
  int? conta;
  int? resto;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight]);
    Future.delayed(Duration.zero, () async {
      await AppController.instance.backgroundMusic('calculadora');
    });
  }

  int primeiraCartaSelecionada = -1;
  int segundaCartaSelecionada = -1;

  void fazerConta() {
    if (operador != null && num1 != null && num2 != null) {
      if (operador == '+') {
        setState(() {
          conta = int.parse(num1!) + int.parse(num2!);
        });
      } else if (operador == '-') {
        setState(() {
          conta = int.parse(num1!) - int.parse(num2!);
        });
      } else if (operador == '*') {
        setState(() {
          conta = int.parse(num1!) * int.parse(num2!);
        });
      } else {
        setState(() {
          if (num2 != '0') {
            conta = int.parse(num1!) ~/ int.parse(num2!);
            resto = int.parse(num1!) % int.parse(num2!);
          } else {
            conta = 0;
            resto = 0;
          }
        });
      }
    }
  }

  void limpar() {
    setState(() {
      num1 = null;
      num2 = null;
      operador = null;
      conta = null;
    });
  }

  Widget body() {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: DragTarget(
                        builder: (
                          BuildContext context,
                          List<dynamic> accepted,
                          List<dynamic> rejected,
                        ) {
                          return Container(
                            color: Colors.lightGreenAccent,
                            child: Center(
                                child: num1 == null
                                    ? null
                                    : ImageIcon(AssetImage(
                                        'assets/numeros/$num1.png'))),
                          );
                        },
                        onAccept: (dynamic data) async {
                          await Fala.instance.flutterTts.stop();
                          if (!data
                              .toString()
                              .contains(RegExp(r'^[\+\-\÷\*]$'))) {
                            setState(() {
                              num1 = data;
                            });
                            if (escolha == 0) {
                              await Fala.instance.flutterTts.speak(data);
                              escolha = 1;
                            } else {
                              await Fala.instance2.flutterTts.speak(data);
                              escolha = 0;
                            }

                            fazerConta();
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: DragTarget(
                        builder: (
                          BuildContext context,
                          List<dynamic> accepted,
                          List<dynamic> rejected,
                        ) {
                          return Container(
                            color: Colors.blue,
                            child: Center(
                                child: operador == null
                                    ? null
                                    : ImageIcon(AssetImage(
                                        'assets/numeros/${operador == '*' ? 'vezes' : operador}.png'))),
                          );
                        },
                        onAccept: (dynamic data) async {
                          await Fala.instance.flutterTts.stop();
                          if (data
                                  .toString()
                                  .contains(RegExp(r'^[\+\-\÷\*]$')) &&
                              num1 != null) {
                            setState(() {
                              operador = data;
                              divisao = false;
                            });
                            print(data);
                            if (data == '*') {
                              if (escolha == 0) {
                                await Fala.instance.flutterTts.speak('vezes');
                                escolha = 1;
                              } else {
                                await Fala.instance2.flutterTts.speak('vezes');
                                escolha = 0;
                              }
                            } else if (data == '-') {
                              if (escolha == 0) {
                                await Fala.instance.flutterTts.speak('menos');
                                escolha = 1;
                              } else {
                                await Fala.instance2.flutterTts.speak('menos');
                                escolha = 0;
                              }
                            } else if (data == '÷') {
                              setState(() {
                                divisao = true;
                              });
                              if (escolha == 0) {
                                await Fala.instance.flutterTts.speak(data);
                                escolha = 1;
                              } else {
                                await Fala.instance2.flutterTts.speak(data);
                                escolha = 0;
                              }
                            } else {
                              if (escolha == 0) {
                                await Fala.instance.flutterTts.speak(data);
                                escolha = 1;
                              } else {
                                await Fala.instance2.flutterTts.speak(data);
                                escolha = 0;
                              }
                            }

                            await Future.delayed(const Duration(seconds: 1));
                            fazerConta();
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: DragTarget(
                        builder: (
                          BuildContext context,
                          List<dynamic> accepted,
                          List<dynamic> rejected,
                        ) {
                          return Container(
                            color: Colors.lightGreenAccent,
                            child: Center(
                                child: num2 == null
                                    ? null
                                    : ImageIcon(AssetImage(
                                        'assets/numeros/$num2.png'))),
                          );
                        },
                        onAccept: (dynamic data) async {
                          await Fala.instance.flutterTts.stop();
                          if (!data
                              .toString()
                              .contains(RegExp(r'^[\+\-\÷\*]$'))) {
                            setState(() {
                              num2 = data;
                            });
                            if (escolha == 0) {
                              await Fala.instance.flutterTts.speak(data);
                              escolha = 1;
                            } else {
                              await Fala.instance2.flutterTts.speak(data);
                              escolha = 0;
                            }

                            fazerConta();
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.lightGreenAccent,
                        child: const Center(
                            child:
                                ImageIcon(AssetImage('assets/numeros/=.png'))),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                          color: Colors.lightGreenAccent,
                          child: Center(
                            child: AutoSizeText(
                              conta == null ? '' : '$conta',
                              maxLines: 1,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25),
                            ),
                          )),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Visibility(
                        visible: divisao,
                        child: const AutoSizeText(
                          "Resto",
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: divisao,
                      child: const SizedBox(
                        width: 10,
                      ),
                    ),
                    Expanded(
                      child: Visibility(
                        visible: divisao,
                        child: Container(
                            color: Colors.lightGreenAccent,
                            child: Center(
                              child: AutoSizeText(
                                conta == null ? '' : '$resto',
                                maxLines: 1,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 25),
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    for (int i = 0; i <= 2; i++)
                      butaoConta(posicao: i, color: Colors.lightGreenAccent),
                    butaoConta(posicao: 3, color: Colors.blue)
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    for (int i = 4; i <= 6; i++)
                      butaoConta(posicao: i, color: Colors.lightGreenAccent),
                    butaoConta(posicao: 7, color: Colors.blue)
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    for (int i = 8; i <= 10; i++)
                      butaoConta(posicao: i, color: Colors.lightGreenAccent),
                    butaoConta(posicao: 11, color: Colors.blue)
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    butaoConta(posicao: 12, color: Colors.lightGreenAccent),
                    butaoConta(posicao: 13, color: Colors.blue)
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, // Background color
                ),
                onPressed: () {
                  limpar();
                },
                child: const Text('Apagar conta'),
              )
            ])));
  }

  Expanded butaoConta({required int posicao, required Color color}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(right: 3, bottom: 3),
        child: LayoutBuilder(
          builder: (context, constraints) => Draggable(
            // Data is the value this Draggable stores.
            data: cartas[posicao],
            feedback: Container(
              height: constraints.maxHeight,
              width: constraints.maxWidth,
              color: color,
              child: Center(
                  child: ImageIcon(AssetImage(
                      'assets/numeros/${cartas[posicao] == '*' ? 'vezes' : cartas[posicao]}.png'))),
            ),
            childWhenDragging: Container(
              color: Colors.yellow,
              child: Center(
                  child: ImageIcon(AssetImage(
                      'assets/numeros/${cartas[posicao] == '*' ? 'vezes' : cartas[posicao]}.png'))),
            ),
            child: Container(
              color: color,
              child: Center(
                  child: ImageIcon(AssetImage(
                      'assets/numeros/${cartas[posicao] == '*' ? 'vezes' : cartas[posicao]}.png'))),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        flexibleSpace: Image.asset(
          'assets/images/calculadora.jpg',
          fit: BoxFit.cover,
        ),
        leading: IconButton(
            onPressed: () async {
              await AppController.instance.backgroundMusic('home');
              Navigator.of(context).pushNamed('/home');
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              'assets/images/calculadora.jpg',
              fit: BoxFit.cover,
            ),
          ),
          body(),
        ],
      ),
    );
  }
}
