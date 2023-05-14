import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../Auxiliadores/app_controller.dart';
import '../Auxiliadores/mensagens.dart';
import '../DadosDB/crud.dart';

class ConfirmarCadastro extends StatefulWidget {
  const ConfirmarCadastro({super.key});

  @override
  State<ConfirmarCadastro> createState() => _ConfirmarCadastroState();
}

class _ConfirmarCadastroState extends State<ConfirmarCadastro> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController condigoController = TextEditingController();
  bool codigoCorreto = true;

  CRUD crud = CRUD();
  Widget body() {
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
            child: Center(
              child: ListView(shrinkWrap: true, children: [
                Image.asset(
                  'assets/images/Crianca_semfundo.png',
                  width: 200,
                  height: 200,
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
                              const Center(
                                  child: Text(
                                      'Digite seu código de Acesso para ativar seu Usuário!!',
                                      style: TextStyle(
                                        color: Colors.black,
                                      ))),
                              const SizedBox(
                                height: 10,
                              ),
                              const Center(
                                child: Text(
                                    'Obs: Essa ação é necessaria apenas uma vez, depois disto você terá total acesso ao Atlas Veterinário',
                                    style: TextStyle(
                                      color: Colors.black,
                                    )),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 40),
                                child: TextFormField(
                                  controller: condigoController,
                                  textAlign: TextAlign.center,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  decoration: InputDecoration(
                                    hintText: 'Codigo',
                                    filled: true,
                                    fillColor:
                                        const Color.fromRGBO(33, 150, 243, 1),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Codigo não pode ser vazio';
                                    } else {
                                      if (codigoCorreto) {
                                        return null;
                                      } else {
                                        return 'Codigo incorreto';
                                      }
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Align(
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          const Color.fromRGBO(13, 71, 161, 1),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      minimumSize: const Size(
                                          200, 50), // Adicione esta linha
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 40),
                                    ),
                                    onPressed: () async {
                                      var mensagem = Mensagem();
                                      String email =
                                          AppController.instance.email;

                                      var resultado = await crud.select(
                                          query:
                                              "Select CODIGO from usuario where EMAIL = '$email'");
                                      if (resultado[0]['CODIGO'] ==
                                          condigoController.text) {
                                        setState(() {
                                          codigoCorreto = true;
                                        });
                                      } else {
                                        setState(() {
                                          codigoCorreto = false;
                                        });
                                      }

                                      if (_formKey.currentState!.validate()) {
                                        try {
                                          await crud.update(
                                              query:
                                                  'Update usuario set IS_ATIVO = 1, CODIGO = NULL where EMAIL = ? and SENHA = ? and CODIGO = ?',
                                              lista: [
                                                AppController.instance.email,
                                                AppController.instance.senha,
                                                condigoController.text
                                              ]);

                                          // ignore: use_build_context_synchronously
                                          await mensagem.mensagem(
                                              context,
                                              'Conta Ativada!!',
                                              'Agora você tem acesso ao Atlas Veterinário',
                                              '/home');
                                        } catch (e) {
                                          print(e);
                                        }
                                      }
                                    },
                                    child: const Text('Confirmar')),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                            ],
                          ))),
                )
              ]),
            ),
          ),
        ));
  }

  Widget alert() {
    return AlertDialog(
      title: const Text("Usuário Ativado com Sucesso!!"),
      content: const Text(
          'Seu Usuário foi ativado com sucesso!! Clique em Ok para continuar'),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed('/home');
            },
            child: const Text("Ok"))
      ],
    );
  }

  Future<dynamic> mensagem() async {
    return await showDialog(
      context: context,
      builder: (_) => alert(),
      barrierDismissible: true,
    );
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
        body: body());
  }
}
