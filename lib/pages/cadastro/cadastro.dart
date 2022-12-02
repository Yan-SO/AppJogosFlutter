import 'dart:convert';

import 'package:appjogos/helper/httpHelper.dart';
import 'package:appjogos/helper/validarHelper.dart';
import 'package:appjogos/models/usuario.dart';
import 'package:appjogos/pages/cadastrajogo/cadastrajogos.dart';
import 'package:appjogos/shared/checkbox/CaixaVerifica.dart';
import 'package:appjogos/shared/navigation/barraNavegacao.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  bool validarUse = false;
  final _formKeyC = GlobalKey<FormState>();
  final TextEditingController controllerUser = TextEditingController();
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerSenha = TextEditingController();
  final TextEditingController controllerConfSenha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKeyC,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover, image: AssetImage('images/wallparer.webp')),
          ),
          child: Container(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(5),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed('/login');
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Container(
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.all(5),
                  color: Color.fromARGB(96, 0, 0, 0),
                  height: 350,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Por favor, insira o nome de usuario";
                          } else if (this.validarUse) {
                            return 'o nome de Usuario ja existe';
                          } else {
                            return null;
                          }
                        },
                        controller: controllerUser,
                        keyboardType: TextInputType.text,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 255, 222, 122),
                        ),
                        decoration: _inputDecoration(
                            descricao: ' Nome de usuario',
                            dica: 'Digite o seu nome de usuario'),
                      ),
                      Spacer(),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Por favor, insira o seu de E-mail";
                          } else {
                            return null;
                          }
                        },
                        controller: controllerEmail,
                        keyboardType: TextInputType.emailAddress,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 255, 222, 122),
                        ),
                        decoration: _inputDecoration(
                            descricao: ' E-mail', dica: 'Digite o seu E-mail'),
                      ),
                      Spacer(),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Por favor, insira a Senha";
                          } else {
                            return null;
                          }
                        },
                        controller: controllerSenha,
                        keyboardType: TextInputType.text,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 255, 222, 122),
                        ),
                        decoration: _inputDecoration(
                            descricao: ' Senha', dica: 'Digite o sua Senha'),
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Por favor, insira a confermação da Senha";
                          } else if (value != controllerSenha.text) {
                            return 'As senhas estão diferentes';
                          } else {
                            return null;
                          }
                        },
                        controller: controllerConfSenha,
                        keyboardType: TextInputType.text,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 255, 222, 122),
                        ),
                        decoration: _inputDecoration(
                            descricao: ' Confirmação da Senha',
                            dica: 'Digite a confirmação Senha'),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 40),
                  child: SizedBox(
                    height: 45,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        final validarHelper =
                            ValidarHelper(controllerUser.text, 'senha');
                        this.validarUse = await validarHelper.existeUser();
                        final form = _formKeyC.currentState;
                        if (form!.validate()) {
                          final Usuario dadosNovoUser = Usuario(
                            nomeUsuario: controllerUser.text,
                            senha: controllerConfSenha.text,
                            listaJogos: [],
                          );
                          final resposta = await HttpHelper()
                              .cadastrarUsuario(dadosNovoUser);

                          final Usuario usuario =
                              Usuario.fromJson(jsonDecode(resposta));
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  BarraNavegacao(user: usuario),
                            ),
                          );
                        }
                      },
                      child: Text('Cadastrar'),
                    ),
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(
      {required String descricao, required String dica}) {
    return InputDecoration(
      labelText: descricao,
      labelStyle: TextStyle(
        fontSize: 24,
        color: Colors.white,
      ),
      hintText: dica,
      hintStyle: TextStyle(
        color: Color.fromARGB(255, 109, 109, 109),
      ),
    );
  }
  //como pegar a funcao por parametro
}
