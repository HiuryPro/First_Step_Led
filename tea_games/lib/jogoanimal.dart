import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Auxiliadores/app_controller.dart';

class Animal extends StatefulWidget {
  const Animal({Key? key}) : super(key: key);

  @override
  AnimalState createState() => AnimalState();
}

class AnimalState extends State<Animal> {
  Map<String, int> animalNames = {
    'C A C H O R R O': 0,
    'G A T O': 1,
    'E L E F A N T E': 2,
    'Z E B R A': 3,
    'P A T O': 4,
    'V A C A': 5,
    'L E Ã O': 6,
    'G I R A F A': 7,
    'T I G R E': 8,
    'C O B R A': 9
  };

  List animais = [''];

  List<String> animalImages = [
    'assets/images/animal/dog.png',
    'assets/images/animal/cat.png',
    'assets/images/animal/elephant.png',
    'assets/images/animal/zebra.png',
    'assets/images/animal/duck.png',
    'assets/images/animal/cow.png',
    'assets/images/animal/lion.png',
    'assets/images/animal/giraffe.png',
    'assets/images/animal/tiger.png',
    'assets/images/animal/snake.png'
  ];

  int phaseNumber = 0;
  int score = 0;
  int correctAnswerIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      animais = animalNames.keys.toList();
      animais.shuffle();
      String key = animais[phaseNumber];
      correctAnswerIndex = animalNames[key]!;
    });
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight]);
    Future.delayed(Duration.zero, () async {
      await AppController.instance.backgroundMusic('animal');
    });
  }

  Widget body() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Expanded(
            child: GridView.count(
              crossAxisCount: 5,
              children: List.generate(10, (index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      if (correctAnswerIndex == index) {
                        score++;
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Resposta Correta'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    goToNextPhase();
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Resposta Incorreta'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                        color: Colors.grey.shade300,
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: Image.asset(
                        animalImages[index],
                        height: 100,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 16.0),
          Text('Pontuação: $score'),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(animais[phaseNumber]),
        centerTitle: true,
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
              'assets/images/animal.jpg',
              fit: BoxFit.cover,
            ),
          ),
          body(),
        ],
      ),
    );
  }

  void goToNextPhase() {
    setState(() {
      phaseNumber++;
      if (phaseNumber > animalNames.length) {
        phaseNumber = 0;
        animais.shuffle();
      }
      String key = animais[phaseNumber];
      correctAnswerIndex = animalNames[key]!;
    });
  }
}
