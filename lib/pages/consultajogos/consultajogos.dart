import 'dart:convert';

import 'package:appjogos/helper/httpHelper.dart';
import 'package:appjogos/models/jogo.dart';
import 'package:appjogos/models/usuario.dart';
import 'package:appjogos/shared/elementosLista/Itemlista.dart';
import 'package:appjogos/shared/navigation/barraNavegacao.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ConsultaJogos extends StatelessWidget {
  final TextEditingController _controllerText = TextEditingController();
  final Jogo jogo;

  ConsultaJogos({
    super.key,
    required this.jogo,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Voltar'),
        backgroundColor: Color.fromARGB(255, 0, 6, 87),
      ),
      body: Column(
        children: [
          Itemlista(jogo: this.jogo),
          Spacer(),
          Text(
            'Comentario',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Spacer(),
          Container(
            padding: EdgeInsets.all(20),
            color: Color.fromARGB(15, 0, 0, 0),
            child: Text(
              jogo.texto ?? 'Sem comentario',
              style: TextStyle(fontSize: 16),
            ),
          ),
          Spacer(flex: 10),
        ],
      ),
    );
  }
}
