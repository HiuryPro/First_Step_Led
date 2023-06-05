import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tea_games/Auxiliadores/app_controller.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map<String, List> jogos = {
    'Menu de Fases do Jogo da Memória': [
      '/fasemenumemoria',
      [
        const ImageIcon(
          AssetImage('assets/images/cardsIcon.png'),
        ),
        const Icon(
          Icons.grid_view,
        )
      ]
    ],
    'Menu de Fases do Jogo de Pareamento': [
      '/fasemenumemoria',
      [
        const ImageIcon(
          AssetImage('assets/images/fruitIcon.png'),
        ),
        const Icon(
          Icons.grid_view,
        )
      ]
    ],
    'Jogo da Memoria': [
      '/memoria',
      [
        const ImageIcon(
          AssetImage('assets/images/cardsIcon.png'),
        )
      ]
    ],
    'Jogo de Pareamento': [
      '/pareamento',
      [
        const ImageIcon(
          AssetImage('assets/images/fruitIcon.png'),
        )
      ]
    ],
    'Calculadora': [
      '/jogocalcular',
      [
        const Icon(
          Icons.calculate,
        )
      ]
    ],
    'Jogo de Formas': [
      '/formas2',
      [
        const Icon(
          Icons.interests,
        )
      ]
    ],
    'Jogo das Letras': [
      '/alfabeto',
      [
        const Icon(
          Icons.abc,
        )
      ]
    ],
    'Jogo dos Números': [
      '/numeros',
      [
        const Icon(
          Icons.pin,
        ),
      ]
    ],
    'Jogo de Animais': [
      '/jogoanimal',
      [const Icon(Icons.pets)]
    ]
  };

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight]);
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
                              crossAxisCount: 5),
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          color: Colors.blue,
                          child: ElevatedButton(
                              onPressed: () {
                                String key = jogos.keys.toList()[index];
                                Navigator.of(context).pushNamed(jogos[key]![0]);
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    jogos.keys.toList()[index],
                                    textAlign: TextAlign.center,
                                  ),
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
