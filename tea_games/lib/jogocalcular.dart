import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:tea_games/Auxiliadores/textoprafala.dart';

import 'Auxiliadores/app_controller.dart';

class JogoCalcular extends StatefulWidget {
  const JogoCalcular({super.key, required this.title});
  final String title;

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

  String? num1;
  String? operador;
  String? num2;
  int? conta;
  int? resto;

  @override
  void initState() {
    super.initState();

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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DragTarget(
                    builder: (
                      BuildContext context,
                      List<dynamic> accepted,
                      List<dynamic> rejected,
                    ) {
                      return Container(
                        height: 100.0,
                        width: 100.0,
                        color: Colors.lightGreenAccent,
                        child: Center(
                            child: num1 == null
                                ? null
                                : ImageIcon(
                                    AssetImage('assets/numeros/$num1.png'))),
                      );
                    },
                    onAccept: (dynamic data) async {
                      await Fala.instance.flutterTts.stop();
                      if (!data.toString().contains(RegExp(r'^[\+\-\÷\*]$'))) {
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
                  const SizedBox(
                    width: 10,
                  ),
                  DragTarget(
                    builder: (
                      BuildContext context,
                      List<dynamic> accepted,
                      List<dynamic> rejected,
                    ) {
                      return Container(
                        height: 100.0,
                        width: 100.0,
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
                      if (data.toString().contains(RegExp(r'^[\+\-\÷\*]$')) &&
                          num1 != null) {
                        setState(() {
                          operador = data;
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
                  const SizedBox(
                    width: 10,
                  ),
                  DragTarget(
                    builder: (
                      BuildContext context,
                      List<dynamic> accepted,
                      List<dynamic> rejected,
                    ) {
                      return Container(
                        height: 100.0,
                        width: 100.0,
                        color: Colors.lightGreenAccent,
                        child: Center(
                            child: num2 == null
                                ? null
                                : ImageIcon(
                                    AssetImage('assets/numeros/$num2.png'))),
                      );
                    },
                    onAccept: (dynamic data) async {
                      await Fala.instance.flutterTts.stop();
                      if (!data.toString().contains(RegExp(r'^[\+\-\÷\*]$'))) {
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
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 100.0,
                    width: 100.0,
                    color: Colors.lightGreenAccent,
                    child: const Center(
                        child: ImageIcon(AssetImage('assets/numeros/=.png'))),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                      height: 100.0,
                      width: 100.0,
                      color: Colors.lightGreenAccent,
                      child: Center(
                        child: Text(
                          conta == null ? '' : '$conta',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25),
                        ),
                      )),
                  const SizedBox(
                    width: 15,
                  ),
                  if (operador == '÷')
                    Row(
                      children: [
                        const Text(
                          "Resto",
                          style: TextStyle(fontSize: 25),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                            height: 100.0,
                            width: 100.0,
                            color: Colors.lightGreenAccent,
                            child: Center(
                              child: Text(
                                conta == null ? '' : '$resto',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 25),
                              ),
                            )),
                      ],
                    )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  for (int i = 0; i <= 2; i++)
                    ButaoConta(posicao: i, color: Colors.lightGreenAccent),
                  ButaoConta(posicao: 3, color: Colors.blue)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  for (int i = 4; i <= 6; i++)
                    ButaoConta(posicao: i, color: Colors.lightGreenAccent),
                  ButaoConta(posicao: 7, color: Colors.blue)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  for (int i = 8; i <= 10; i++)
                    ButaoConta(posicao: i, color: Colors.lightGreenAccent),
                  ButaoConta(posicao: 11, color: Colors.blue)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ButaoConta(posicao: 12, color: Colors.lightGreenAccent),
                  ButaoConta(posicao: 13, color: Colors.blue)
                ],
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

  Padding ButaoConta({required int posicao, required Color color}) {
    return Padding(
      padding: const EdgeInsets.only(right: 3, bottom: 3),
      child: Draggable(
        // Data is the value this Draggable stores.
        data: cartas[posicao],
        feedback: Container(
          color: color,
          height: 100,
          width: 100,
          child: Center(
              child: ImageIcon(AssetImage(
                  'assets/numeros/${cartas[posicao] == '*' ? 'vezes' : cartas[posicao]}.png'))),
        ),
        childWhenDragging: Container(
          height: 100.0,
          width: 100.0,
          child: Center(
              child: ImageIcon(AssetImage(
                  'assets/numeros/${cartas[posicao] == '*' ? 'vezes' : cartas[posicao]}.png'))),
        ),
        child: Container(
          height: 100.0,
          width: 100.0,
          color: color,
          child: Center(
              child: ImageIcon(AssetImage(
                  'assets/numeros/${cartas[posicao] == '*' ? 'vezes' : cartas[posicao]}.png'))),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leading: IconButton(
            onPressed: () async {
              await AppController.instance.backgroundMusic('home');
              Navigator.of(context).pushNamed('/home');
            },
            icon: Icon(Icons.arrow_back)),
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
