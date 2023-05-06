import 'package:flutter/material.dart';

import '../DadosDB/crud.dart';
import '../SendEmail/enviaemail.dart';

class TesteTela extends StatefulWidget {
  const TesteTela({super.key});

  @override
  State<TesteTela> createState() => _TesteTelaState();
}

class _TesteTelaState extends State<TesteTela> {
  CRUD crud = CRUD();

  Widget body() {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: ListView(
          shrinkWrap: true,
          children: [
            ElevatedButton(
                onPressed: () async {
                  print('Teste');
                  EnviaEmail envia = EnviaEmail();
                  await envia.enviaEmailConfirmacao(
                      'hiurylucas@unipam.edu.br', '289712');

                  var resposta = await crud.select(
                      query: 'Select * from usuario where ID_USUARIO = 2');
                  print(resposta);
                  print(resposta[0]['NOME_USUARIO']);
                  print('Funciona');
                },
                child: Text('Aperta'))
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: body());
  }
}
