// TabelaItemLista pode extends jogo??
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TabelaItemLista extends StatelessWidget {
  final String nome;
  final String? statusCampanha;
  final String? statusplatina;
  final int nota;
  final String? texto;
  final String plataforme;

  const TabelaItemLista(
      {super.key,
      required this.nome,
      this.statusCampanha,
      this.statusplatina,
      required this.nota,
      required this.plataforme,
      this.texto});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.all(10),
            child: Text(nome, textScaleFactor: 1.5),
          ),
          Table(
            columnWidths: const <int, TableColumnWidth>{
              0: FixedColumnWidth(140),
              1: FixedColumnWidth(140),
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.top,
            children: <TableRow>[
              TableRow(
                children: <Widget>[
                  //tratamento de erro aqui ↓↓
                  Text('Status da Campanha', textScaleFactor: 1.1),
                  Text('   ${this.statusCampanha}', textScaleFactor: 1.1),
                ],
              ),
              TableRow(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(29, 0, 9, 138),
                ),
                children: <Widget>[
                  //tratamento de erro aqui ↓↓
                  Text('Status da Platina', textScaleFactor: 1.1),
                  Text('   ${this.statusplatina}', textScaleFactor: 1.1),
                ],
              ),
              TableRow(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(0, 18, 1, 150),
                ),
                children: <Widget>[
                  //tratamento de erro aqui ↓↓
                  Text('Plataforma', textScaleFactor: 1.1),
                  Text(
                    '   ${this.plataforme}',
                    textScaleFactor: 1.1,
                  ),
                ],
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Row(
              children: [
                Container(
                  child: Text('Nota  ${this.nota}', textScaleFactor: 2),
                ),
                //colocar border radius
                //colocar if para tirar esse conteiner se quiser
                Container(
                  margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  height: 40,
                  width: 90,
                  color: Color.fromARGB(255, 228, 228, 228),
                  // colocar onTap com GestureDetector ou com InkWell(melhor)
                  child: Container(
                    child: Text('toque aqui para Mais.',
                        textAlign: TextAlign.center),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
