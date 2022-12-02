import 'package:appjogos/models/jogo.dart';

class Usuario {
  final String? id;
  final String nomeUsuario;
  final String senha;
  final String? imagemAvatar;
  final List<dynamic> listaJogos;

  Usuario({
    this.imagemAvatar,
    this.id,
    required this.nomeUsuario,
    required this.senha,
    required this.listaJogos,
  });

  Usuario.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        nomeUsuario = json['nomeUsuario'],
        senha = json['senha'],
        listaJogos = json['listaJogos'],
        imagemAvatar = json['imagemAvatar'];

  Map<String, dynamic> toJson() {
    if (id == null) {
      return {
        'nomeUsuario': nomeUsuario,
        'senha': senha,
        'imagemAvatar': imagemAvatar,
        'listaJogos': listaJogos,
      };
    } else {
      return {
        'id': id,
        'nomeUsuario': nomeUsuario,
        'senha': senha,
        'imagemAvatar': imagemAvatar,
        'listaJogos': listaJogos,
      };
    }
  }
}
