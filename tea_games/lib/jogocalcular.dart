import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:tea_games/textoprafala.dart';

class JogoCalcular extends StatefulWidget {
  const JogoCalcular({super.key, required this.title});
  final String title;

  @override
  State<JogoCalcular> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<JogoCalcular> {
  int acceptedData = 0;
  final audioPlayer = AudioPlayer();
  int _counter = 0;
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

  ElevatedButton button = ElevatedButton(
    child: const Text("Button"),
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

    Future.delayed(Duration.zero, () async {
      // button.onPressed?.call();
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
          try {
            conta = int.parse(num1!) ~/ int.parse(num2!);
          } catch (e) {}
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
                        await Fala.instance.flutterTts.speak(data);

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
                          await Fala.instance.flutterTts.speak('vezes');
                        } else if (data == '-') {
                          await Fala.instance.flutterTts.speak('menos');
                        } else {
                          await Fala.instance.flutterTts.speak(data);
                        }

                        await Future.delayed(Duration(seconds: 1));
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
                        await Fala.instance.flutterTts.speak(data);

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
                      ))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  for (int i = 0; i <= 3; i++)
                    Padding(
                      padding: const EdgeInsets.only(right: 3, bottom: 3),
                      child: Draggable(
                        // Data is the value this Draggable stores.
                        data: cartas[i],
                        feedback: Container(
                          color: Colors.green,
                          height: 100,
                          width: 100,
                          child: Center(
                              child: ImageIcon(AssetImage(
                                  'assets/numeros/${cartas[i]}.png'))),
                        ),
                        childWhenDragging: Container(
                          height: 100.0,
                          width: 100.0,
                          child: Center(
                              child: ImageIcon(AssetImage(
                                  'assets/numeros/${cartas[i]}.png'))),
                        ),
                        child: Container(
                          height: 100.0,
                          width: 100.0,
                          color: Colors.lightGreenAccent,
                          child: Center(
                              child: ImageIcon(AssetImage(
                                  'assets/numeros/${cartas[i]}.png'))),
                        ),
                      ),
                    ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  for (int i = 4; i <= 7; i++)
                    Padding(
                      padding: const EdgeInsets.only(right: 3, bottom: 3),
                      child: Draggable(
                        // Data is the value this Draggable stores.
                        data: cartas[i],
                        feedback: Container(
                          color: Colors.green,
                          height: 100,
                          width: 100,
                          child: Center(
                              child: ImageIcon(AssetImage(
                                  'assets/numeros/${cartas[i]}.png'))),
                        ),
                        childWhenDragging: Container(
                          height: 100.0,
                          width: 100.0,
                          child: Center(
                              child: ImageIcon(AssetImage(
                                  'assets/numeros/${cartas[i]}.png'))),
                        ),
                        child: Container(
                          height: 100.0,
                          width: 100.0,
                          color: Colors.lightGreenAccent,
                          child: Center(
                              child: ImageIcon(AssetImage(
                                  'assets/numeros/${cartas[i]}.png'))),
                        ),
                      ),
                    ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  for (int i = 8; i <= 11; i++)
                    Padding(
                      padding: const EdgeInsets.only(right: 3, bottom: 3),
                      child: Draggable(
                        // Data is the value this Draggable stores.
                        data: cartas[i],
                        feedback: Container(
                          color: Colors.green,
                          height: 100,
                          width: 100,
                          child: Center(
                              child: ImageIcon(AssetImage(
                                  'assets/numeros/${cartas[i]}.png'))),
                        ),
                        childWhenDragging: Container(
                          height: 100.0,
                          width: 100.0,
                          child: Center(
                              child: ImageIcon(AssetImage(
                                  'assets/numeros/${cartas[i]}.png'))),
                        ),
                        child: Container(
                          height: 100.0,
                          width: 100.0,
                          color: Colors.lightGreenAccent,
                          child: Center(
                              child: ImageIcon(AssetImage(
                                  'assets/numeros/${cartas[i]}.png'))),
                        ),
                      ),
                    ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  for (int i = 12; i <= 13; i++)
                    Padding(
                      padding: const EdgeInsets.only(right: 3, bottom: 3),
                      child: Draggable(
                        // Data is the value this Draggable stores.
                        data: cartas[i],
                        feedback: Container(
                          color: Colors.green,
                          height: 100,
                          width: 100,
                          child: Center(
                              child: ImageIcon(AssetImage(
                                  'assets/numeros/${cartas[i] == '*' ? 'vezes' : cartas[i]}.png'))),
                        ),
                        childWhenDragging: Container(
                          height: 100.0,
                          width: 100.0,
                          child: Center(
                              child: ImageIcon(AssetImage(
                                  'assets/numeros/${cartas[i] == '*' ? 'vezes' : cartas[i]}.png'))),
                        ),
                        child: Container(
                          height: 100.0,
                          width: 100.0,
                          color: Colors.lightGreenAccent,
                          child: Center(
                              child: ImageIcon(AssetImage(
                                  'assets/numeros/${cartas[i] == '*' ? 'vezes' : cartas[i]}.png'))),
                        ),
                      ),
                    ),
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
