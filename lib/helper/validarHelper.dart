import 'package:appjogos/helper/httpHelper.dart';

class ValidarHelper {
  final String nome;
  final String senha;

  ValidarHelper(this.nome, this.senha);

  Future<bool> existeUser() async {
    final json = await HttpHelper().validaLogin(nome: nome, senha: senha);

    return json['user'];
  }

  Future<bool> validarSenha() async {
    final json = await HttpHelper().validaLogin(nome: nome, senha: senha);

    return json['senha'];
  }
}
