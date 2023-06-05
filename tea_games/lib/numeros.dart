import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:tea_games/Auxiliadores/textoprafala.dart';

import 'Auxiliadores/app_controller.dart';
import 'Auxiliadores/buttonanmation.dart';

class Numeros extends StatefulWidget {
  const Numeros({super.key, required this.title});
  final String title;

  @override
  State<Numeros> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Numeros> {
  final audioPlayer = AudioPlayer();
  int fase = 1;
  int escolha = 1;
  int clicado = 0;
  String numero = '';
  Map<String, Color> numeros = {
    '0': Colors.blue,
    '1': Colors.blue,
    '2': Colors.blue,
    '3': Colors.blue,
    '4': Colors.blue,
    '5': Colors.blue,
    '6': Colors.blue,
    '7': Colors.blue,
    '8': Colors.blue,
    '9': Colors.blue,
  };

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight]);
    Future.delayed(Duration.zero, () async {
      await AppController.instance.backgroundMusic('numero');
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
                Flexible(
                  flex: 1,
                  child: Row(
                    children: numeros.keys.map((value) {
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              return Draggable(
                                data: value,
                                childWhenDragging: Container(),
                                feedback: Container(
                                    width: constraints.maxWidth,
                                    height: constraints.maxHeight,
                                    child: butaoNumero(value)),
                                child: butaoNumero(value),
                              );
                            },
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Expanded(child: Text('')),
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
                            if (numero.length < 6) {
                              numero += data.toString();
                            }

                            print(numero);
                          });
                        }, builder: (
                          BuildContext context,
                          List<dynamic> accepted,
                          List<dynamic> rejected,
                        ) {
                          return Text(
                            numero,
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
                            await Fala.instance.flutterTts.speak(numero);
                          },
                          child: const Text('Falar Número')),
                      const SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red),
                          onPressed: () {
                            setState(() {
                              numero = '';
                            });
                          },
                          child: const Text('Apagar Número')),
                      const SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red),
                          onPressed: () {
                            setState(() {
                              if (numero.isNotEmpty) {
                                numero = numero.substring(0, numero.length - 1);
                              }
                            });
                          },
                          child: const Text('Apagar Ultima Número Digitado')),
                    ],
                  ),
                ),
              ],
            )));
  }

  ShrinkButton butaoNumero(String index) {
    return ShrinkButton(
      color: numeros[index]!,
      onPressed: () async {
        if (clicado == 0) {
          setState(() {
            numeros[index] = Colors.green;
            clicado = 1;
          });

          await Fala.instance.flutterTts.speak(index);
          setState(() {
            numeros[index] = Colors.blue;
            clicado = 0;
          });
        }
      },
      shrinkScale: 0.7,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: numeros[index]),
        child: Center(child: Text(index)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
              child: Image.asset('assets/images/numeros.jpg')),
          body(),
        ],
      ),
    );
  }
}
