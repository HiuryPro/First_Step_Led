import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:tea_games/Auxiliadores/textoprafala.dart';

class Letras extends StatefulWidget {
  const Letras({super.key, required this.title});
  final String title;

  @override
  State<Letras> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Letras> {
  final audioPlayer = AudioPlayer();
  int fase = 1;
  List alfabeto = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z'
  ];

  @override
  void initState() {
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
                Expanded(
                  child: GridView.builder(
                    itemCount: alfabeto.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 10,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () async {},
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.blue),
                          child: Center(
                            child: IconButton(
                              iconSize: 70,
                              icon: Text(
                                alfabeto[index],
                                style: const TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              ),
                              onPressed: () async {
                                await Fala.instance.flutterTts
                                    .speak(alfabeto[index]);
                              },
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
