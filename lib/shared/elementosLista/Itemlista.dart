import 'package:appjogos/models/jogo.dart';
import 'package:appjogos/shared/elementosLista/ImagContenerLista.dart';
import 'package:appjogos/shared/elementosLista/TabelaItemLista.dart';
import 'package:flutter/cupertino.dart';

class Itemlista extends StatelessWidget {
  final Jogo jogo;

  const Itemlista({super.key, required this.jogo});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        //item da lista
        children: [
          ImagContenerLista(urlImagen: jogo.urlImagem),
          TabelaItemLista(
            nome: jogo.nome,
            statusCampanha: jogo.statusCampanha,
            statusplatina: jogo.statusplatina,
            nota: jogo.nota,
            plataforme: jogo.plataforme,
          )
        ],
      ),
    );
  }
}
