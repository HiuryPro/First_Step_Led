// ignore_for_file: file_names

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../Auxiliadores/mensagens.dart';
import '../Auxiliadores/telacarregamento.dart';
import '../DadosDB/crud.dart';
import '../SendEmail/enviaemail.dart';

class CadastroR extends StatefulWidget {
  const CadastroR({super.key});

  @override
  State<CadastroR> createState() => CadastroRState();
}

class CadastroRState extends State<CadastroR> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  TextEditingController nomeController = TextEditingController();
  TextEditingController dataNascController = TextEditingController();
  TextEditingController dataController = TextEditingController();

  bool existe = false;
  bool carregando = false;
  late TelaCarregamento telaCarregamento;

  var dateMask = MaskTextInputFormatter(
      mask: '##/##/####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  CRUD crud = CRUD();

  String? erroemail;
  String? errosenha;
  String? dataNasc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      telaCarregamento = TelaCarregamento();
    });
  }

  Widget body() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(33, 150, 243, 1),
              Color.fromRGBO(13, 71, 161, 1),
            ],
          ),
        ),
        child: Padding(
            padding: const EdgeInsets.all(8),
            child: Center(
                child: ListView(
              shrinkWrap: true,
              children: [
                Image.asset(
                  'assets/images/Crianca_semfundo.png',
                  width: 300,
                  height: 300,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
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
                            height: 20,
                          ),
                          Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: TextFormField(
                                controller: nomeController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Campo está vazio';
                                  }

                                  return null;
                                },
                                decoration: InputDecoration(
                                  hintText: 'Nome',
                                  filled: true,
                                  fillColor:
                                      const Color.fromRGBO(33, 150, 243, 1),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: TextFormField(
                                controller: dataNascController,
                                onTap: () {
                                  showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(1980),
                                          lastDate: DateTime(3000))
                                      .then((date) {
                                    if (date != null) {
                                      dataNascController.text =
                                          DateFormat('dd/MM/yyyy').format(date);
                                      dataNasc =
                                          DateFormat('yyy-MM-dd').format(date);

                                      print(dataNasc);
                                    }
                                  });
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Campo está vazio';
                                  }

                                  return null;
                                },
                                decoration: InputDecoration(
                                  hintText: 'Data de Nascimento',
                                  filled: true,
                                  fillColor:
                                      const Color.fromRGBO(33, 150, 243, 1),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: TextFormField(
                                controller: emailController,
                                validator: (value) {
                                  RegExp emailRegex = RegExp(
                                      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

                                  if (value!.isEmpty) {
                                    return 'E-mail não pode ser vazio';
                                  } else {
                                    final bool emailValid =
                                        emailRegex.hasMatch(value);
                                    if (emailValid) {
                                      if (existe) {
                                        return 'Email já está em uso';
                                      } else {
                                        return null;
                                      }
                                    } else {
                                      return 'E-mail inválido';
                                    }
                                  }
                                },
                                decoration: InputDecoration(
                                  hintText: 'E-mail',
                                  filled: true,
                                  fillColor:
                                      const Color.fromRGBO(33, 150, 243, 1),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: TextFormField(
                                controller: senhaController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Campo está vazio';
                                  }

                                  if (value.length < 8) {
                                    return 'Senha deve ter no mínimo 8 caracteres';
                                  }

                                  return null;
                                },
                                obscureText: true,
                                decoration: InputDecoration(
                                  hintText: 'Senha',
                                  filled: true,
                                  fillColor:
                                      const Color.fromRGBO(33, 150, 243, 1),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Align(
                            child: ElevatedButton(
                              onPressed: () async {
                                var resposta = await crud.select(
                                    query:
                                        "Select * from usuario where EMAIL = '${emailController.text}'");
                                print(resposta);
                                if (resposta.isEmpty) {
                                  setState(() {
                                    existe = false;
                                  });
                                } else {
                                  setState(() {
                                    existe = true;
                                  });
                                }

                                if (_formKey.currentState!.validate()) {
                                  var enviaemail = EnviaEmail();
                                  var mensagem = Mensagem();
                                  String email = emailController.text;
                                  String nome = nomeController.text;
                                  String senha = senhaController.text;
                                  var random = Random();
                                  String codigo = '';
                                  for (int i = 0; i < 6; i++) {
                                    var randomNumber = random.nextInt(
                                        10); // gera um número aleatório entre 0 e 9
                                    codigo += randomNumber.toString();
                                  }
                                  setState(() {
                                    carregando = true;
                                  });

                                  await crud.insert(
                                      query:
                                          'Insert into usuario(NOME_USUARIO, DATA_NASC, EMAIL, SENHA, CODIGO, IS_ATIVO) values(?,?,?,?,?,0)',
                                      lista: [
                                        nome,
                                        dataNasc,
                                        email,
                                        senha,
                                        codigo
                                      ]);

                                  await enviaemail.enviaEmailConfirmacao(
                                      email, codigo);
                                  // ignore: use_build_context_synchronously
                                  await mensagem.mensagem(
                                      context,
                                      'Usuário criado com Sucesso!!',
                                      'Um email com codigo de acesso foi enviado para o seu email. Utilize-o ao fazer o primeiro login',
                                      '/loginr');
                                  setState(() {
                                    carregando = false;
                                  });
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
                                'Cadastrar',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ))),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pushNamed("/loginr");
              })),
      body: Stack(children: [
        body(),
        if (carregando) telaCarregamento.telaCarrega(context)[0],
        if (carregando) telaCarregamento.telaCarrega(context)[1]
      ]),
    );
  }
}
