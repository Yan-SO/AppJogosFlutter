import 'dart:convert';

import 'package:appjogos/helper/httpHelper.dart';
import 'package:appjogos/models/jogo.dart';
import 'package:appjogos/pages/consultajogos/consultajogos.dart';
import 'package:appjogos/shared/elementosLista/Itemlista.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class JogosGalera extends StatelessWidget {
  List<Jogo> _listDeJogos = [];

  @override
  Widget build(BuildContext context) {
    final jogos = HttpHelper().getJogos();
    jogos.then((value) {
      _listDeJogos = value;
    });

    return Scaffold(
      body: FutureBuilder(
        future: jogos,
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return _listView(context, _listDeJogos);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }),
      ),
    );
  }

  ListView _listView(BuildContext context, List<Jogo> _listDeJogos) {
    return ListView.builder(
      itemCount: _listDeJogos.length,
      itemBuilder: (context, indice) {
        final listaJogos = _listDeJogos[indice];
        //print(listaJogos);
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ConsultaJogos(jogo: _listDeJogos[indice]),
                ));
          },
          child: Itemlista(jogo: listaJogos),
        );
      },
    );
  }
}
