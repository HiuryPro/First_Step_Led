import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tea_games/Formas/estrela.dart';
import 'package:tea_games/Formas/formax.dart';
import 'package:tea_games/Formas/losango.dart';

import 'Auxiliadores/app_controller.dart';
import 'Auxiliadores/textoprafala.dart';
import 'Formas/circulo.dart';
import 'Formas/coracao.dart';
import 'Formas/quadrado.dart';
import 'Formas/triangulo.dart';

class JogoFormasAlternativo extends StatefulWidget {
  const JogoFormasAlternativo({super.key});

  @override
  State<JogoFormasAlternativo> createState() => _JogoFormasAlternativoState();
}

int seed = 0;

class _JogoFormasAlternativoState extends State<JogoFormasAlternativo> {
  Map<String, Widget> formas = {
    'estrela': const StarWidget(color: Colors.yellow, size: 50),
    'circulo': const CircleWidget(color: Colors.pink, size: 50),
    'quadrado': const SquareWidget(color: Colors.blue, size: 50),
    'triangulo': const TriangleWidget(color: Colors.orange, size: 50),
    'losango': const LosangoWidget(
      size: 50,
      color: Colors.purple,
    ),
    'x': const XWidget(color: Colors.green, size: 50),
    'coração': const Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: HeartWidget(size: 80, color: Colors.red))
  };

  Map<String, Widget> zonaSoltarFormas = {
    'estrela': const StarWidget(color: Colors.black, size: 50),
    'circulo': const CircleWidget(color: Colors.black, size: 50),
    'quadrado': const SquareWidget(color: Colors.black, size: 50),
    'triangulo': const TriangleWidget(color: Colors.black, size: 50),
    'losango': const LosangoWidget(
      size: 50,
      color: Colors.black,
    ),
    'x': const XWidget(color: Colors.black, size: 50),
    'coração': const Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: HeartWidget(size: 80, color: Colors.black))
  };

  Map<String, bool> score = {};
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight]);
    setState(() {
      seed = Random().nextInt(100000);
    });
    Future.delayed(Duration.zero, () async {
      AppController.instance.backgroundMusic('formas');
    });
    super.initState();
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
          child: Center(
            child: Column(
              children: [
                const Expanded(child: Text('')),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: formas.keys.map((forma) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Draggable(
                            data: forma,
                            childWhenDragging: Container(),
                            feedback: formas[forma]!,
                            child: formas[forma]!),
                      );
                    }).toList(),
                  ),
                ),
                Expanded(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: zonaSoltarFormas.keys
                          .map((forma) => _soltaForma(forma))
                          .toList()
                        ..shuffle(Random(seed))),
                ),
                const Expanded(child: Text('')),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _soltaForma(forma) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: DragTarget<String>(onWillAccept: (data) {
        print(data);
        return data == forma;
      }, onAccept: (data) async {
        setState(() {
          score[forma] = true;
        });

        await Fala.instance.flutterTts
            .speak(forma == 'circulo' ? 'siirculo' : forma);

        if (score.length == formas.length) {
          await AppController.instance.falaAudio('vitoria.mp3');
          await Future.delayed(Duration(seconds: 1));
          setState(() {
            seed = Random().nextInt(100000);
            score.clear();
          });
        }
      }, builder: (
        BuildContext context,
        List<String?> accepted,
        List rejected,
      ) {
        if (score[forma] == true) {
          return formas[forma]!;
        } else {
          print('Opa');
          return zonaSoltarFormas[forma]!;
        }
      }),
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
          shadowColor: Colors.black.withOpacity(0.1),
        ),
        body: Stack(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Image.asset(
                'assets/images/formas.jpg',
                fit: BoxFit.cover,
              ),
            ),
            body(),
          ],
        ));
  }
}
