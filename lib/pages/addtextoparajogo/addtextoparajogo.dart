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

class AddTextoParaJogo extends StatelessWidget {
  final TextEditingController _controllerText = TextEditingController();
  final Jogo jogo;
  final Usuario user;
  AddTextoParaJogo({super.key, required this.jogo, required this.user});

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Voltar'),
        backgroundColor: Color.fromARGB(255, 0, 6, 87),
      ),
      body: Column(
        children: [
          Itemlista(jogo: this.jogo),
          Container(
            padding: EdgeInsets.all(10),
            color: Color.fromARGB(15, 0, 0, 0),
            child: TextField(
              controller: _controllerText,
              autocorrect: true,
              autofocus: true,
              keyboardType: TextInputType.multiline,
              maxLines: 10,
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  jogo.setTexto(_controllerText.text);
                  final HttpHelper httpHelper = HttpHelper();
                  final retornoJogo = await httpHelper.cadastrarJogo(jogo);

                  final mansage = await httpHelper.addJogoNoUser(
                      Jogo.fronJson(jsonDecode(retornoJogo)), user);
                  //print(mansage);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BarraNavegacao(user: user),
                    ),
                  );
                },
                child: Text('Salvar'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
