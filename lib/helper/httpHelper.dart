import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:appjogos/models/jogo.dart';
import 'package:appjogos/models/usuario.dart';
import 'package:http/http.dart' as http;

class HttpHelper {
  final String domino = 'apirestappjogos.herokuapp.com';
  final String caminhoValidar = '/usuarios/validarlogin';
  final String caminhoCadastrarUsuario = '/usuarios';
  final String validarNomeUserPCadastro = '/usuarios/validarNomeUserPCadastro';

  // retornar o json
  Future<Map<String, dynamic>> validaLogin(
      {required String nome, required String senha}) async {
    Uri url =
        Uri.http(domino, caminhoValidar, {'nomeUsuario': nome, 'senha': senha});
    http.Response result = await http.get(url);
    final jsonResponse = json.decode(utf8.decode(result.bodyBytes));
    return jsonResponse;
  }

  Future<Map<String, dynamic>> pegarUserPorId(String id) async {
    Uri url = Uri.http(domino, '/usuarios/${id}');
    http.Response result = await http.get(url);
    final jsonReponse = json.decode(utf8.decode(result.bodyBytes));
    return jsonReponse;
  }

  Future<List<Jogo>> getJogos() async {
    final List<Jogo> lista = [];

    Uri url = Uri.http(domino, '/jogos');
    http.Response result = await http.get(url);

    if (result.statusCode == HttpStatus.ok) {
      final jsonReponse = json.decode(utf8.decode(result.bodyBytes));
      for (var response in jsonReponse) {
        var jogo = Jogo.fronJson(response);
        lista.add(jogo);
      }
    }

    return lista;
  }

  Future<String> cadastrarUsuario(Usuario usuario) async {
    String post = json.encode(usuario.toJson());
    print(post);
    Uri url = Uri.http(domino, caminhoCadastrarUsuario);
    http.Response resposta = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: post,
    );
    return resposta.body;
  }

  Future<String> cadastrarJogo(Jogo jogo) async {
    String post = json.encode(jogo.toJson());
    print(post);
    Uri url = Uri.http(domino, '/jogos');
    http.Response resposta = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: post,
    );
    return resposta.body;
  }

  Future<String> addJogoNoUser(Jogo jogo, Usuario user) async {
    String post = json.encode(jogo.toJsonId());
    print(post);
    Uri url = Uri.http(domino, '/usuarios/addjogo/${user.id}');
    print(url);
    http.Response resposta = await http.put(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: post,
    );
    return resposta.body;
  }

  Future<String> atualizarUser(
      Usuario user, Map<String, String> atualiza) async {
    String post = json.encode(atualiza);
    //print(post);
    Uri url = Uri.http(domino, '/usuarios/${user.id}');
    //print(url);
    http.Response resposta = await http.put(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: post,
    );
    return resposta.body;
  }

  Future<String> atualizarJogo(Jogo jogo, Jogo novaVercao) async {
    String post = json.encode(novaVercao);
    //print(post);
    Uri url = Uri.http(domino, '/jogos/${jogo.id}');
    //print(url);
    http.Response resposta = await http.put(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: post,
    );
    return resposta.body;
  }
}
