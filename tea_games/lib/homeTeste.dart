import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tea_games/Auxiliadores/app_controller.dart';

class HomeTeste extends StatefulWidget {
  const HomeTeste({super.key});

  @override
  State<HomeTeste> createState() => _HomeTesteState();
}

class _HomeTesteState extends State<HomeTeste> {
  Map<String, List> jogos = {
    'Menu de Fases do Jogo da Memória': [
      '/fasemenumemoria',
      [
        const ImageIcon(
          AssetImage('assets/images/cardsIcon.png'),
          size: 70,
        ),
        const Icon(
          Icons.grid_view,
          size: 70,
        )
      ]
    ],
    'Menu de Fases do Jogo de Pareamento': [
      '/fasemenumemoria',
      [
        const ImageIcon(
          AssetImage('assets/images/fruitIcon.png'),
          size: 70,
        ),
        const Icon(
          Icons.grid_view,
          size: 70,
        )
      ]
    ],
    'Jogo da Memoria': [
      '/memoria',
      [
        const ImageIcon(
          AssetImage('assets/images/cardsIcon.png'),
          size: 70,
        )
      ]
    ],
    'Jogo de Pareamento': [
      '/pareamento',
      [
        const ImageIcon(
          AssetImage('assets/images/fruitIcon.png'),
          size: 70,
        )
      ]
    ],
    'Calculadora': [
      '/jogocalcular',
      [
        const Icon(
          Icons.calculate,
          size: 70,
        )
      ]
    ],
    'Jogo de Formas': [
      '/formas2',
      [
        const Icon(
          Icons.interests,
          size: 70,
        )
      ]
    ],
    'Jogo das Letras': [
      '/alfabeto',
      [
        const Icon(
          Icons.abc,
          size: 70,
        )
      ]
    ],
    'Jogo dos Números': [
      '/numeros',
      [
        const Icon(
          Icons.pin,
          size: 70,
        ),
      ]
    ]
  };

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await AppController.instance.backgroundMusic('home');
    });

    if (!kIsWeb && Platform.isAndroid) {
      setState(() {
        jogos['Jogo de Formas']![0] = '/formas';
      });
    }

    print(jogos['Jogo de Formas']!);
  }

  Widget body() {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 40.0, left: 40.0),
                  child: Center(
                    child: GridView.builder(
                      itemCount: jogos.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisSpacing: 5,
                              crossAxisSpacing: 5,
                              crossAxisCount: 4),
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          color: Colors.blue,
                          child: ElevatedButton(
                              onPressed: () {},
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(jogos.keys.toList()[index]),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children:
                                        jogos[jogos.keys.toList()[index]]![1]
                                            .map<Widget>((Widget value) {
                                      return value;
                                    }).toList(),
                                  )
                                ],
                              )),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () async {
              await AppController.instance.backgroundAudio.stop();
              Navigator.of(context).pushNamed('/loginr');
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: body(),
    );
  }
}
