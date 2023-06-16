import 'package:flutter/material.dart';

import 'Auxiliadores/app_controller.dart';

class TelaSobre extends StatefulWidget {
  const TelaSobre({super.key});

  @override
  State<TelaSobre> createState() => _TelaSobreState();
}

class _TelaSobreState extends State<TelaSobre> {
  Widget body() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: const Padding(
        padding: EdgeInsets.all(8),
        child: Center(
            child: Text(
                style: TextStyle(color: Colors.white, fontSize: 30),
                "Este trabalho tem como objetivo desenvolver um aplicativo educativo baseado em jogos"
                "interativos para crianças de 3 a 7 anos, visando auxiliar seu processo de aprendizado"
                "por meio de atividades que estimulem habilidades cognitivas, como raciocínio lógico, memória,"
                "coordenação motora e desenvolvimento da linguagem e promovam uma experiência lúdica e envolvente")),
      ),
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
            icon: const Icon(Icons.arrow_back)),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              "assets/images/crianca.png",
              fit: BoxFit.cover,
            ),
          ),
          body()
        ],
      ),
    );
  }
}
