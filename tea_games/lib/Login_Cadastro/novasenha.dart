import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  final _formKey = GlobalKey<FormState>();
  TextEditingController codigoController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  TextEditingController confirmaSenhaController = TextEditingController();

  CRUD crud = CRUD();
  bool emailCorreto = true;

  String? emailError;
  String? senhaError;
  late TelaCarregamento telaCarregamento;
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight]);
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
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(33, 150, 243, 1),
                Color.fromRGBO(13, 71, 161, 1)
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(shrinkWrap: true, children: [
              Image.asset(
                'assets/images/Crianca_semfundo.png',
                width: 200,
                height: 200,
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Container(
                  decoration: const BoxDecoration(
                      border: Border(
                          top: BorderSide(
                              color: Color.fromRGBO(13, 71, 161, 1), width: 5),
                          bottom: BorderSide(
                              color: Color.fromRGBO(13, 71, 161, 1), width: 5),
                          left: BorderSide(
                              color: Color.fromRGBO(13, 71, 161, 1), width: 5),
                          right: BorderSide(
                              color: Color.fromRGBO(13, 71, 161, 1), width: 5)),
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        const Center(
                          child: Text(
                            'Digite seu email para que seja enviado um codigo para alterar sua senha.',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: TextFormField(
                            controller: emailController,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              hintText: 'E-mail',
                              filled: true,
                              fillColor: const Color.fromRGBO(33, 150, 243, 1),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            validator: (value) {
                              RegExp emailRegex = RegExp(
                                  r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

                              if (value!.isEmpty) {
                                return 'E-mail não pode ser vazio';
                              } else {
                                final bool emailValid =
                                    emailRegex.hasMatch(value);
                                if (emailValid) {
                                  if (emailCorreto) {
                                    return null;
                                  } else {
                                    return 'Email ou senha incorretos';
                                  }
                                } else {
                                  return 'E-mail inválido';
                                }
                              }
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Align(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromRGBO(13, 71, 161, 1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                minimumSize:
                                    const Size(200, 50), // Adicione esta linha
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 40),
                              ),
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
                                      emailCorreto = false;
                                    });
                                    // ignore: use_build_context_synchronously
                                    await mensagem.mensagem(
                                        context,
                                        'Erro de Email',
                                        'Email incorreto ou Usúario inexistente',
                                        null);
                                  } else {
                                    setState(() {
                                      emailCorreto = true;
                                    });
                                  }
                                  if (_formKey.currentState!.validate()) {
                                    var random = Random();
                                    String codigo = '';
                                    for (int i = 0; i < 6; i++) {
                                      var randomNumber = random.nextInt(
                                          10); // gera um número aleatório entre 0 e 9
                                      codigo += randomNumber.toString();
                                    }
                                    await crud.update(
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
                                  await mensagem.mensagem(
                                      context,
                                      'Erro de Email',
                                      'Email incorreto ou Usúario inexistente',
                                      null);
                                  setState(() {
                                    emailError =
                                        'Email incorreto ou Usúario inexistente';
                                    carregando = false;
                                  });
                                }
                              },
                              child: const Text('Confirmar')),
                        ),
                        const SizedBox(
                          height: 30,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ));
  }

  Widget novasenha() {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(33, 150, 243, 1),
                Color.fromRGBO(13, 71, 161, 1)
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(shrinkWrap: true, children: [
              Image.asset(
                'assets/images/Crianca_semfundo.png',
                width: 200,
                height: 200,
              ),
              const SizedBox(
                height: 20,
              ),
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
                        await crud.update(
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
          ),
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
            Navigator.of(context).pushNamed('/loginr');
          },
        ),
      ),
      body: Stack(children: [
        isEmailVerdadeiro ? novasenha() : email(),
        if (carregando) telaCarregamento.telaCarrega(context)[0],
        if (carregando) telaCarregamento.telaCarrega(context)[1]
      ]),
    );
  }
}
