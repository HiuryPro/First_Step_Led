// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../Auxiliadores/app_controller.dart';
import '../DadosDB/crud.dart';

class LoginR extends StatefulWidget {
  const LoginR({Key? key}) : super(key: key);

  @override
  LoginRState createState() => LoginRState();
}

class LoginRState extends State<LoginR> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  CRUD crud = CRUD();

  bool emailCorreto = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
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
          child: Center(
            child: ListView(
              children: [
                Image.asset(
                  'assets/images/Crianca_semfundo.png',
                  width: 300,
                  height: 300,
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100),
                  child: Container(
                    decoration: const BoxDecoration(
                        border: Border(
                            top: BorderSide(
                                color: Color.fromRGBO(13, 71, 161, 1),
                                width: 5),
                            bottom: BorderSide(
                                color: Color.fromRGBO(13, 71, 161, 1),
                                width: 5),
                            left: BorderSide(
                                color: Color.fromRGBO(13, 71, 161, 1),
                                width: 5),
                            right: BorderSide(
                                color: Color.fromRGBO(13, 71, 161, 1),
                                width: 5)),
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
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: TextFormField(
                              controller: _emailController,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                hintText: 'E-mail',
                                filled: true,
                                fillColor:
                                    const Color.fromRGBO(33, 150, 243, 1),
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
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: TextFormField(
                              controller: _passwordController,
                              obscureText: true,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                hintText: 'Senha',
                                filled: true,
                                fillColor:
                                    const Color.fromRGBO(33, 150, 243, 1),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Senha não pode ser vazia';
                                }
                                if (value.length < 8) {
                                  return 'Senha deve ter no mínimo 8 caracteres';
                                }

                                if (!emailCorreto) {
                                  return 'Email ou senha incorretos';
                                }
                                return null;
                              },
                            ),
                          ),
                          Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.of(context).pushNamed('/novasenha');
                                },
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 40),
                                  child: Text('Esqueceu a senha?'),
                                ),
                              )),
                          const SizedBox(height: 20),
                          Align(
                            child: ElevatedButton(
                              onPressed: () async {
                                var resposta = await crud.select(
                                    query:
                                        "Select * from usuario where EMAIL = '${_emailController.text}' and SENHA = '${_passwordController.text}'");
                                print(resposta);
                                if (resposta.isEmpty) {
                                  setState(() {
                                    emailCorreto = false;
                                  });
                                } else {
                                  setState(() {
                                    emailCorreto = true;
                                  });
                                }
                                if (_formKey.currentState!.validate()) {
                                  AppController.instance.idUsuario =
                                      resposta[0]['ID_USUARIO'];
                                  AppController.instance.email =
                                      _emailController.text;
                                  AppController.instance.senha =
                                      _passwordController.text;
                                  AppController.instance.nome =
                                      resposta[0]['NOME_USUARIO'];

                                  if (resposta[0]['IS_ATIVO'] == 1) {
                                    Navigator.of(context).pushNamed('/home');
                                  } else {
                                    Navigator.of(context)
                                        .pushNamed('/confirmarCadastro');
                                  }
                                }
                              },
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
                              child: const Text(
                                'Entrar',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Align(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed("/cadastror");
                              },
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
                              child: const Text(
                                'Cadastro',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
