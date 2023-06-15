import 'package:flutter/material.dart';

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
                "TEA GAMES é para crianças e adolescentes com autismo, atraso no desenvolvimento ou dificuldades de aprendizagem. O conjunto de exercícios compostos no aplicativo, foi planejado, de acordo com as técnicas baseadas em evidências científicas para o desenvolvimento de crianças com TEA (Transtorno do Espectro Autista).")),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              "assets/images/autista.png",
              fit: BoxFit.cover,
            ),
          ),
          body()
        ],
      ),
    );
  }
}
