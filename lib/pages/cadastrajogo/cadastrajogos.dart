import 'dart:ffi';

import 'package:appjogos/models/jogo.dart';
import 'package:appjogos/models/usuario.dart';
import 'package:appjogos/pages/addtextoparajogo/addtextoparajogo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CadastraJogos extends StatefulWidget {
  final Usuario user;
  const CadastraJogos({super.key, required this.user});

  @override
  State<CadastraJogos> createState() => _CadastraJogosState();
}

class _CadastraJogosState extends State<CadastraJogos> {
  final _formKey = GlobalKey<FormState>();
  String? _valorStatusPlatina;
  String? _valorStatusCampalha;

  final TextEditingController _controladorNome = TextEditingController();

  final TextEditingController _controladorPlataforma = TextEditingController();
  final TextEditingController _controladorNota = TextEditingController();
  final TextEditingController _controladorImagem = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
          margin: EdgeInsets.all(5),
          child: Column(
            children: [
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor coloque o nome do Jogo';
                  } else {
                    return null;
                  }
                },
                decoration: _inputDecoration(
                    descricao: 'Nome do Jogo', dica: 'Nome do Jogo'),
                controller: _controladorNome,
                keyboardType: TextInputType.name,
              ),
              Spacer(),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor indique a plataforma';
                  } else {
                    return null;
                  }
                },
                controller: _controladorPlataforma,
                decoration: _inputDecoration(
                    descricao: 'Plataforma usada para jogar',
                    dica: 'playstation 4, Xbox, Switch'),
              ),
              Spacer(),
              _compoDropDownCampalha(context,
                  listaItens: [
                    'Não comecei',
                    'No inicio',
                    'No meio',
                    'No fim',
                    'Terminada'
                  ],
                  textoApresentacao: 'Status da Campanha'),
              Spacer(),
              _compoDropDownPlatina(context,
                  listaItens: [
                    'Não quero pegar',
                    'Quero pegar',
                    'Estou pegando',
                    'Pega'
                  ],
                  textoApresentacao: 'Status da Platina'),
              Spacer(),
              Row(
                children: [
                  Spacer(),
                  Container(
                    width: 157,
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor indique uma nota';
                        } else if (int.tryParse(value) == null) {
                          return 'coloque um numero inteiro';
                        } else if (int.parse(value) > 10) {
                          return 'valor maior que 10';
                        } else if (int.parse(value) < 0) {
                          return 'valor menor que 0';
                        } else {
                          return null;
                        }
                      },
                      controller: _controladorNota,
                      decoration: _inputDecoration(
                          descricao: 'Nota de 0 a 10', dica: '0 a 10'),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Spacer(),
                  Container(
                    width: 168,
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor indique uma URL';
                        } else {
                          return null;
                        }
                      },
                      controller: _controladorImagem,
                      decoration: _inputDecoration(
                          descricao: 'ULR da imagem',
                          dica: 'www.suaimagem.com'),
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  Spacer(),
                ],
              ),
              Spacer(),
              _botao(context, texto: 'Continuar'),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  // coloco a funcao do onPressed como parametro?
  Widget _botao(BuildContext context, {required String texto}) {
    return Container(
      margin: EdgeInsets.all(10),
      child: SizedBox(
        height: 50,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            final form = _formKey.currentState;
            if (form!.validate()) {
              final jogo = Jogo(
                  urlImagem: _controladorImagem.text,
                  nome: _controladorNome.text,
                  nota: int.parse(_controladorNota.text),
                  plataforme: _controladorPlataforma.text,
                  statusplatina: _valorStatusPlatina ?? 'não informado',
                  statusCampanha: _valorStatusCampalha ?? 'não informado');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      AddTextoParaJogo(jogo: jogo, user: widget.user),
                ),
              );
            }
          },
          child: Text(texto),
        ),
      ),
    );
  }

  // como eu acesso o metodo fora da classe?
  Widget _campoTexto(
    BuildContext context, {
    required TextEditingController controlador,
    required String descricao,
    required String dica,
    required TextInputType textInputType,
  }) {
    return TextFormField(
      //como pegar a funcao por parametro
      validator: (value) {},
      controller: controlador,
      keyboardType: textInputType,
      decoration: _inputDecoration(descricao: descricao, dica: dica),
    );
  }

  InputDecoration _inputDecoration({
    required String descricao,
    required String dica,
  }) {
    return InputDecoration(
        labelText: descricao,
        hintText: dica,
        labelStyle: TextStyle(fontSize: 24));
  }

  Widget _compoDropDownCampalha(BuildContext context,
      {required List<String> listaItens, required String textoApresentacao}) {
    return DropdownButtonFormField(
      hint: Text(textoApresentacao),
      items: listaItens.map(
        (item) {
          return DropdownMenuItem(
            child: Text(item),
            value: item,
          );
        },
      ).toList(),
      onChanged: (String? itemEScolhido) {
        setState(() {
          _valorStatusCampalha = itemEScolhido;
          print(_valorStatusCampalha);
        });
      },
    );
  }

  Widget _compoDropDownPlatina(BuildContext context,
      {required List<String> listaItens, required String textoApresentacao}) {
    return DropdownButtonFormField(
      hint: Text(textoApresentacao),
      items: listaItens.map(
        (item) {
          return DropdownMenuItem(
            child: Text(item),
            value: item,
          );
        },
      ).toList(),
      onChanged: (String? itemEScolhido) {
        setState(() {
          _valorStatusPlatina = itemEScolhido;
          print(_valorStatusPlatina);
        });
      },
    );
  }
}
