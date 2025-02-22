import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Auxiliadores/app_controller.dart';
import '../DadosDB/crud.dart';
import '../Formas/estrela.dart';

class MenuFasePareamento extends StatefulWidget {
  const MenuFasePareamento({super.key});

  @override
  State<MenuFasePareamento> createState() => _MenuFasePareamentoState();
}

class _MenuFasePareamentoState extends State<MenuFasePareamento> {
  Map<String, bool> fases = {
    'Fase 1': false,
    'Fase 2': false,
    'Fase 3': false,
    'Fase 4': false,
    'Fase 5': false,
    'Fase 6': false
  };
  List<Map> listaFases = [{}, {}];
  CRUD crud = CRUD();
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      int id = AppController.instance.idUsuario;
      List resultado = await crud.select(
          query: 'Select * from fases_pareamento where ID_USUARIO = $id');

      resultado[0].removeWhere((key, value) => key == 'ID_USUARIO');
      for (var value in resultado[0].keys.toList()) {
        String fase = value.toString().toLowerCase();
        fase = fase.replaceRange(0, 1, 'F');
        fase = fase.replaceFirst(RegExp(r'_'), ' ');

        if (resultado[0][value] == 0) {
          fases[fase] = false;
        } else {
          fases[fase] = true;
        }
        setState(() {
          listaFases = [
            Map.fromEntries(fases.entries.toList().getRange(0, 3)),
            Map.fromEntries(fases.entries.toList().getRange(3, 6))
          ];
        });
      }
    });
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight]);
    super.initState();
    Future.delayed(Duration.zero, () async {
      await AppController.instance.backgroundMusic('pareamento');
    });
  }

  List<Widget> fasesColuna(int index) {
    return listaFases[index].keys.map((value) {
      return Expanded(
          child: Padding(
        padding: EdgeInsets.only(bottom: 5),
        child: ElevatedButton(
            onPressed: () {
              print(
                  "/pareamento${value.toString().replaceFirst(RegExp(r' '), '')}");
              Navigator.of(context).pushNamed(
                  "/pareamento${value.toString().replaceFirst(RegExp(r' '), '')}");
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  value,
                  style: const TextStyle(fontSize: 20),
                ),
                StarWidget(
                    color:
                        listaFases[index][value] ? Colors.yellow : Colors.grey,
                    size: 30)
              ],
            )),
      ));
    }).toList();
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
                    children: fasesColuna(0)),
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: fasesColuna(1)),
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
