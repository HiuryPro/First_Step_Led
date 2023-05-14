import 'package:flutter/material.dart';

import '../Auxiliadores/app_controller.dart';

class MenuFasePareamento extends StatefulWidget {
  const MenuFasePareamento({super.key});

  @override
  State<MenuFasePareamento> createState() => _MenuFasePareamentoState();
}

class _MenuFasePareamentoState extends State<MenuFasePareamento> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () async {
      await AppController.instance.backgroundMusic('pareamento');
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
                            Navigator.of(context).pushNamed("/pareamentoFase1");
                          },
                          child: const Text('Fase 1')),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed("/pareamentoFase2");
                          },
                          child: const Text('Fase 2')),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed("/pareamentoFase3");
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
                            Navigator.of(context).pushNamed("/pareamentoFase4");
                          },
                          child: const Text('Fase 4')),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed("/pareamentoFase5");
                          },
                          child: const Text('Fase 5')),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed("/pareamentoFase6");
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
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () async {
                await AppController.instance.backgroundMusic('home');
                Navigator.of(context).pushNamed('/home');
              },
              icon: Icon(Icons.arrow_back)),
        ),
        body: body());
  }
}
