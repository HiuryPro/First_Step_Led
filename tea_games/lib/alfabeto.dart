import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:tea_games/Auxiliadores/textoprafala.dart';

import 'Auxiliadores/buttonanmation.dart';

class Alfabeto extends StatefulWidget {
  const Alfabeto({super.key, required this.title});
  final String title;

  @override
  State<Alfabeto> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Alfabeto> {
  final audioPlayer = AudioPlayer();
  int fase = 1;
  int escolha = 1;
  int clicado = 0;
  String palavra = '';
  Map<String, Color> alfabeto = {
    'A': Colors.blue,
    'B': Colors.blue,
    'C': Colors.blue,
    'D': Colors.blue,
    'E': Colors.blue,
    'F': Colors.blue,
    'G': Colors.blue,
    'H': Colors.blue,
    'I': Colors.blue,
    'J': Colors.blue,
  };

  Map<String, Color> alfabeto2 = {
    'K': Colors.blue,
    'L': Colors.blue,
    'M': Colors.blue,
    'N': Colors.blue,
    'O': Colors.blue,
    'P': Colors.blue,
    'Q': Colors.blue,
    'R': Colors.blue,
    'S': Colors.blue,
    'T': Colors.blue
  };

  Map<String, Color> alfabeto3 = {
    'U': Colors.blue,
    'V': Colors.blue,
    'W': Colors.blue,
    'X': Colors.blue,
    'Y': Colors.blue,
    'Z': Colors.blue,
    'Espaço': Colors.blue,
  };

  List<Map<String, Color>> listaA = [];

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight]);
    listaA = [alfabeto, alfabeto2, alfabeto3];
    super.initState();
  }

  Widget body() {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                rowAlfabeto(0),
                rowAlfabeto(1),
                rowAlfabeto(2),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                          child: Container(
                        color: const Color(0xFF1d3c1c),
                        height: 100,
                        child: DragTarget(onAccept: (data) {
                          setState(() {
                            print(data);

                            if (data != 'Espaço') {
                              palavra += data.toString();
                            } else {
                              palavra += ' ';
                            }

                            print(palavra);
                          });
                        }, builder: (
                          BuildContext context,
                          List<dynamic> accepted,
                          List<dynamic> rejected,
                        ) {
                          return Text(
                            palavra,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                            ),
                          );
                        }),
                      )),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green),
                          onPressed: () async {
                            await Fala.instance.flutterTts.speak(palavra);
                          },
                          child: const Text('Falar Palavra')),
                      const SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red),
                          onPressed: () {
                            setState(() {
                              palavra = '';
                            });
                          },
                          child: const Text('Apagar Palavra')),
                      const SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red),
                          onPressed: () {
                            setState(() {
                              if (palavra.isNotEmpty) {
                                palavra =
                                    palavra.substring(0, palavra.length - 1);
                              }
                            });
                          },
                          child: const Text('Apagar Ultima Letra Digitada')),
                    ],
                  ),
                ),
              ],
            )));
  }

  Flexible rowAlfabeto(int index) {
    return Flexible(
      flex: 1,
      child: Row(
        children: listaA[index].keys.map((value) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 10, bottom: 10),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Draggable(
                    data: value,
                    childWhenDragging: Container(),
                    feedback: Container(
                        width: constraints.maxWidth,
                        height: constraints.maxHeight,
                        child: butaopalavra(value, index)),
                    child: butaopalavra(value, index),
                  );
                },
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  ShrinkButton butaopalavra(String value, int index) {
    return ShrinkButton(
      color: listaA[index][value]!,
      onPressed: () async {
        if (clicado == 0) {
          setState(() {
            listaA[index][value] = Colors.green;
            clicado = 1;
          });
          if (value != 'Espaço') {
            await Fala.instance.flutterTts.speak(value);
          }

          setState(() {
            listaA[index][value] = Colors.blue;
            clicado = 0;
          });
        }
      },
      shrinkScale: 0.7,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: listaA[index][value]!),
        child: Center(child: Text(value)),
      ),
    );
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
