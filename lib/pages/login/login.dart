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

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  bool validoUser = false;
  bool validoSenha = false;
  final TextEditingController controllerUser = TextEditingController();
  final TextEditingController controllerSenha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color.fromARGB(255, 0, 46, 116),
      child: Form(
        key: _formKey,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover, image: AssetImage('images/wallparer.webp')),
          ),
          child: Container(
            child: Column(
              children: [
                Spacer(),
                Spacer(),
                Container(
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.all(5),
                  color: Color.fromARGB(96, 0, 0, 0),
                  height: 228,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Por favor, insira o nome de usuario";
                          } else if (!this.validoUser) {
                            return 'Usuario $value não existe';
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
                            descricao: 'Nome de usuario',
                            dica: 'Digite o seu nome de usuario'),
                      ),
                      Spacer(),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Por favor, insira a Senha";
                          } else if (!this.validoUser) {
                            return null;
                          } else if (!this.validoSenha) {
                            return 'A senha $value esta esta errada';
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
                            descricao: 'Senha', dica: 'Digite o sua Senha'),
                      ),
                      // como usar um metodo get dentro dele??????
                      CaixaVerifica(titulo: 'Lembrar Login'),
                    ],
                  ),
                ),
                Spacer(),
                Spacer(),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 40),
                  child: SizedBox(
                    height: 45,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (controllerUser.text.isNotEmpty &&
                            controllerSenha.text.isNotEmpty) {
                          final login = ValidarHelper(
                              controllerUser.text, controllerSenha.text);
                          this.validoUser = await login.existeUser();
                          this.validoSenha = await login.validarSenha();
                        }
                        final form = _formKey.currentState;
                        if (form!.validate()) {
                          //  pegar user do banco
                          final id = await HttpHelper().validaLogin(
                              nome: controllerUser.text,
                              senha: controllerSenha.text);
                          final userJson =
                              await HttpHelper().pegarUserPorId(id['id']);

                          final Usuario user = Usuario.fromJson(userJson);
                          _lembrarLogin().then(
                            (value) => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    BarraNavegacao(user: user),
                              ),
                            ),
                          );
                        }
                      },
                      child: Text('Entrar'),
                    ),
                  ),
                ),
                Spacer(),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 70),
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
                  child: SizedBox(
                    height: 30,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed('/cadastro');
                      },
                      child: Text('Cadastrar'),
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

  @override
  void initState() {
    _carregarInformacoes();
    super.initState();
  }

  Future _carregarInformacoes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      controllerUser.text = prefs.getString('usuarioLembrada') ?? '';
      controllerSenha.text = prefs.getString('senhaLembrada') ?? '';
    });
  }

  Future<void> _lembrarLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool? lembrar = await prefs.getBool('salvarLogin');

    if (lembrar == null) {
      print('dentro de _lembrarLogin');
      print('O valor Salvo é : ${prefs.getBool('salvarLogin')} ');
    } else {
      if (lembrar) {
        await prefs.setString('usuarioLembrada', controllerUser.text).then(
              (value) => print('User: ${prefs.getString('usuarioLembrada')}'),
            );
        await prefs.setString('senhaLembrada', controllerSenha.text).then(
              (value) => print('Senha: ${prefs.getString('senhaLembrada')}'),
            );
      } else {
        //bool caixaLembrar = prefs.get(key)

        // escolher qual apagar
        await prefs.setString('usuarioLembrada', '');
        await prefs.setString('senhaLembrada', '');
        print('A memoria foi apagada');
      }
    }
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
}
