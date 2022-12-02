import 'package:appjogos/helper/httpHelper.dart';
import 'package:appjogos/models/jogo.dart';
import 'package:appjogos/models/usuario.dart';
import 'package:appjogos/pages/editarjogo/editarjogo.dart';
import 'package:appjogos/shared/elementosLista/Itemlista.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MeusJogos extends StatefulWidget {
  final Usuario user;

  MeusJogos({super.key, required this.user});

  @override
  State<MeusJogos> createState() => _MeusJogosState();
}

class _MeusJogosState extends State<MeusJogos> {
  List<Jogo> _listDeJogos = [];

  @override
  Widget build(BuildContext context) {
    Usuario userAtual;

    final jogos = HttpHelper().pegarUserPorId(widget.user.id!);
    jogos.then((value) {
      _listDeJogos = [];
      userAtual = Usuario.fromJson(value);
      userAtual.listaJogos.forEach(
        (element) {
          _listDeJogos.add(Jogo.fronJson(element));
        },
      );
    });

    // FutureBuilder não esta funcionando
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
        return GestureDetector(
            onTap: () async {
              final jogo = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditarJogo(jogo: _listDeJogos[indice]),
                ),
              );
              if (jogo != null) {
                setState(() {});
              }
            },
            child: Itemlista(jogo: listaJogos));
      },
    );
  }
}
