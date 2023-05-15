import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tea_games/Formas/estrela.dart';
import 'package:tea_games/Formas/formax.dart';
import 'package:tea_games/Formas/losango.dart';

import 'Formas/circulo.dart';
import 'Formas/quadrado.dart';
import 'Formas/triangulo.dart';

class JogoFormas extends StatefulWidget {
  const JogoFormas({super.key});

  @override
  State<JogoFormas> createState() => _JogoFormasState();
}

int seed = 0;

class _JogoFormasState extends State<JogoFormas> {
  Map<String, Widget> formas = {
    'estrela': const StarWidget(color: Colors.yellow, size: 80),
    'circulo': const CircleWidget(color: Colors.red, size: 80),
    'quadrado': const SquareWidget(color: Colors.blue, size: 80),
    'triangulo': const TriangleWidget(color: Colors.orange, size: 80),
    'losango': const LosangoWidget(
      size: 80,
      color: Colors.purple,
    ),
    'x': const XWidget(color: Colors.green, size: 70)
  };

  Map<String, Widget> zonaSoltarFormas = {
    'estrela': const StarWidget(color: Colors.black, size: 80),
    'circulo': const CircleWidget(color: Colors.black, size: 80),
    'quadrado': const SquareWidget(color: Colors.black, size: 80),
    'triangulo': const TriangleWidget(color: Colors.black, size: 80),
    'losango': const LosangoWidget(
      size: 70,
      color: Colors.black,
    ),
    'x': const XWidget(color: Colors.black, size: 70)
  };

  Map<String, bool> score = {};

  Widget body() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: formas.keys.map((forma) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: Draggable(
                        data: forma,
                        childWhenDragging: Container(),
                        feedback: formas[forma]!,
                        child: formas[forma]!),
                  );
                }).toList(),
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: zonaSoltarFormas.keys
                      .map((forma) => _soltaForma(forma))
                      .toList()
                    ..shuffle(Random(seed))),
            ],
          ),
        ),
      ),
    );
  }

  Widget _soltaForma(forma) {
    return Padding(
      padding: const EdgeInsets.only(right: 30),
      child: DragTarget<String>(onWillAccept: (data) {
        print(data);
        return data == forma;
      }, onAccept: (data) {
        setState(() {
          score[forma] = true;
        });
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
        appBar: AppBar(
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
        ),
        body: body());
  }
}
