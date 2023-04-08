import 'package:flutter/material.dart';

import '../app_controller.dart';

class MenuFaseMemoria extends StatefulWidget {
  const MenuFaseMemoria({super.key});

  @override
  State<MenuFaseMemoria> createState() => _MenuFaseMemoriaState();
}

class _MenuFaseMemoriaState extends State<MenuFaseMemoria> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () async {
      await AppController.instance.backgroundMusic('memoria');
    });
  }

  Widget body() {
    return SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed("/memoriaFase1");
                          },
                          child: const Text('Fase 1')),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed("/memoriaFase2");
                          },
                          child: const Text('Fase 2')),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed("/memoriaFase3");
                          },
                          child: const Text('Fase 3')),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed("/memoriaFase4");
                          },
                          child: const Text('Fase 4')),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed("/memoriaFase5");
                          },
                          child: const Text('Fase 5')),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed("/memoriaFase6");
                          },
                          child: const Text('Fase 6')),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: body());
  }
}
