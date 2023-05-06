import 'dart:math';

import 'package:flutter/material.dart';

import '../Auxiliadores/mensagens.dart';
import '../Auxiliadores/telacarregamento.dart';
import '../DadosDB/crud.dart';
import '../SendEmail/enviaemail.dart';

class NovaSenha extends StatefulWidget {
  const NovaSenha({super.key});

  @override
  State<NovaSenha> createState() => _NovaSenhaState();
}

class _NovaSenhaState extends State<NovaSenha> {
  TextEditingController codigoController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  TextEditingController confirmaSenhaController = TextEditingController();

  CRUD crud = CRUD();

  String? emailError;
  String? senhaError;
  late TelaCarregamento telaCarregamento;
  @override
  void initState() {
    super.initState();
    setState(() {
      telaCarregamento = TelaCarregamento();
    });
  }

  bool isEmailVerdadeiro = false;
  bool carregando = false;

  Widget email() {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(shrinkWrap: true, children: [
            const Text(
              'Digite seu email para que seja enviado um codigo para alterar sua senha.',
              style: TextStyle(color: Colors.black),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: emailController,
              onChanged: (value) {
                setState(() {
                  emailError = null;
                });
              },
              decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  label: const Text('Email'),
                  errorText: emailError),
            ),
            ElevatedButton(
                onPressed: () async {
                  var enviaEmail = EnviaEmail();
                  var mensagem = Mensagem();
                  try {
                    setState(() {
                      carregando = true;
                    });
                    var user = await crud.select(
                        query:
                            "Select * from usuario where EMAIL = '${emailController.text.trim()}'");

                    if (user.isEmpty) {
                      setState(() {
                        emailError =
                            'Este email está incorreto ou não está cadastrado';
                      });
                      // ignore: use_build_context_synchronously
                      await mensagem.mensagem(context, 'Erro de Email',
                          'Email incorreto ou Usúario inexistente', null);
                    } else {
                      var random = Random();
                      String codigo = '';
                      for (int i = 0; i < 6; i++) {
                        var randomNumber = random.nextInt(
                            10); // gera um número aleatório entre 0 e 9
                        codigo += randomNumber.toString();
                      }
                      var resposta = await crud.update(
                          query:
                              "Update usuario set CODIGO = '$codigo' where EMAIL = '${emailController.text.trim()}'",
                          lista: []);

                      await enviaEmail.enviaEmailRedfinirSenha(
                          emailController.text, codigo);

                      // ignore: use_build_context_synchronously
                      await mensagem.mensagem(
                          context,
                          'Codigo para troca de senha',
                          'Um codigo foi enviado para seu email',
                          null);

                      setState(() {
                        isEmailVerdadeiro = true;
                        carregando = false;
                      });
                    }
                  } catch (e) {
                    print(e);
                    await mensagem.mensagem(context, 'Erro de Email',
                        'Email incorreto ou Usúario inexistente', null);
                    setState(() {
                      emailError = 'Email incorreto ou Usúario inexistente';
                      carregando = false;
                    });
                  }
                },
                child: const Text('Confirmar'))
          ]),
        ));
  }

  Widget novasenha() {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(shrinkWrap: true, children: [
            const Text('Digite seu código de Redefinção de Senha',
                style: TextStyle(
                  color: Colors.black,
                )),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: codigoController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), label: Text('Codigo')),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              obscureText: true,
              controller: senhaController,
              onChanged: (value) {
                setState(() {
                  senhaError = null;
                });
              },
              decoration: InputDecoration(
                  errorText: senhaError,
                  border: const OutlineInputBorder(),
                  label: const Text('Senha')),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              obscureText: true,
              controller: confirmaSenhaController,
              onChanged: (value) {
                setState(() {
                  senhaError = null;
                });
              },
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                label: const Text('Confirmar Senha'),
                errorText: senhaError,
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  try {
                    var mensagem = Mensagem();
                    String senha = senhaController.text;
                    String senhaConfirma = confirmaSenhaController.text;

                    if (senha == senhaConfirma) {
                      var resposta = await crud.update(
                          query:
                              "Update usuario set SENHA = '${senhaController.text.trim()}', CODIGO = NULL where EMAIL = '${emailController.text.trim()}' and CODIGO = ${codigoController.text.trim()}",
                          lista: []);

                      // ignore: use_build_context_synchronously
                      await mensagem.mensagem(
                          context,
                          'Sua Senha foi alterada com sucesso',
                          'A senha de seu usuário foi alterada',
                          '/login');
                    } else {
                      setState(() {
                        senhaError = 'Senhas não são iguais';
                      });
                    }

                    // ignore: use_build_context_synchronously
                  } catch (e) {
                    print(e);
                  }
                },
                child: const Text('Confirmar'))
          ]),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon((Icons.arrow_back)),
          onPressed: () {
            Navigator.of(context).pushNamed('/login');
          },
        ),
      ),
      body: Stack(children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Image.asset(
            'assets/images/loginback.jpg',
            fit: BoxFit.cover,
          ),
        ),
        isEmailVerdadeiro ? novasenha() : email(),
        if (carregando) telaCarregamento.telaCarrega(context)[0],
        if (carregando) telaCarregamento.telaCarrega(context)[1]
      ]),
    );
  }
}
