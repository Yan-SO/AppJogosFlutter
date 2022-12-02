import 'package:appjogos/helper/httpHelper.dart';
import 'package:appjogos/models/jogo.dart';
import 'package:appjogos/shared/elementosLista/ImagContenerLista.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class EditarJogo extends StatefulWidget {
  late String urlImagem = jogo.urlImagem;
  Jogo jogo;
  EditarJogo({super.key, required this.jogo});

  @override
  State<EditarJogo> createState() => _EditarJogoState();
}

class _EditarJogoState extends State<EditarJogo> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerNome = TextEditingController();
  final TextEditingController _controllerPlataforma = TextEditingController();
  final TextEditingController _controllerNota = TextEditingController();
  final TextEditingController _controllerTexto = TextEditingController();
  late String? _campanha = widget.jogo.statusCampanha;
  late String? _platina = widget.jogo.statusplatina;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 6, 87),
        title: Text('Edição do Jogo ${widget.jogo.nome}'),
      ),
      body: _listaDeItens(context),
    );
  }

  Widget _listaDeItens(BuildContext context) {
    _controllerNome.text = widget.jogo.nome;
    _controllerPlataforma.text = widget.jogo.plataforme;
    _controllerNota.text = '${widget.jogo.nota}';
    _platina = widget.jogo.statusplatina;
    _campanha = widget.jogo.statusCampanha;
    _controllerTexto.text = widget.jogo.texto ?? '';
    return Form(
      key: _formKey,
      child: ListView(
        children: [
          _campoImagem(context),
          ListTile(
            title: TextFormField(
              controller: _controllerNome,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Coloque o Nome';
                } else {
                  return null;
                }
              },
              decoration: _inputDecoration('Nome do Jogo', 'nome do jogo aqui'),
            ),
          ),
          ListTile(
            title: TextFormField(
              controller: _controllerPlataforma,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Coloque o Nome';
                } else {
                  return null;
                }
              },
              decoration: _inputDecoration(
                  'Plataforma usada para Jogar', 'playstation 4, Xbox, Switch'),
            ),
          ),
          ListTile(
            title: TextFormField(
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
              controller: _controllerNota,
              decoration: _inputDecoration('Nota de 0 a 10', '0 a 10'),
              keyboardType: TextInputType.number,
            ),
          ),
          ListTile(
            title: _compoDropDownPlatina(context,
                listaItens: [
                  'Não quero pegar',
                  'Quero pegar',
                  'Estou pegando',
                  'Pega'
                ],
                textoApresentacao: widget.jogo.statusplatina!),
          ),
          ListTile(
            title: _compoDropDownCampalha(context,
                listaItens: [
                  'Não comecei',
                  'No inicio',
                  'No meio',
                  'No fim',
                  'Terminada'
                ],
                textoApresentacao: widget.jogo.statusCampanha!),
          ),
          ListTile(
            title: TextFormField(
              maxLines: 7,
              controller: _controllerTexto,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Coloque o Texto';
                } else {
                  return null;
                }
              },
              decoration: _inputDecoration(
                  'Coloque o que você achou do jogo', 'Sua opinião'),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  final form = _formKey.currentState;
                  if (form!.validate()) {
                    final novaVercao = Jogo(
                        urlImagem: widget.urlImagem,
                        nome: _controllerNome.text,
                        nota: int.parse(_controllerNota.text),
                        plataforme: _controllerPlataforma.text,
                        statusCampanha: _campanha,
                        statusplatina: _platina,
                        texto: _controllerTexto.text);
                    //testar o atualizarJogo
                    final reposta = await HttpHelper()
                        .atualizarJogo(widget.jogo, novaVercao);
                    Navigator.pop(context, novaVercao);
                  }
                },
                child: Text('Salvar as Alterações'),
              ),
            ),
          )
        ],
      ),
    );
  }

  InputDecoration _inputDecoration(String label, String dica) {
    return InputDecoration(
      label: Text(label, style: TextStyle(fontSize: 24)),
      hintText: dica,
      floatingLabelStyle: TextStyle(color: Color.fromARGB(255, 0, 72, 167)),
    );
  }

// verificar se a imagem foi verificada
  Widget _campoImagem(BuildContext context) {
    final TextEditingController _controllerImagem = TextEditingController();
    _controllerImagem.text = widget.urlImagem;
    return Row(
      children: [
        ImagContenerLista(urlImagen: widget.urlImagem),
        Flexible(
          child: Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                TextFormField(
                    maxLines: 4,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Coloque a URL';
                      } else if (_controllerImagem.text != widget.urlImagem) {
                        return 'Verifique a Imagem';
                      } else {
                        return null;
                      }
                    },
                    controller: _controllerImagem,
                    decoration:
                        _inputDecoration('URL da Imagem', 'www.suaImagem.com')),
                Container(height: 50),
                ElevatedButton(
                  style: const ButtonStyle(
                      padding: MaterialStatePropertyAll<EdgeInsetsGeometry>(
                        EdgeInsets.all(18),
                      ),
                      backgroundColor: MaterialStatePropertyAll<Color>(
                          Color.fromARGB(255, 0, 72, 167))),
                  onPressed: () {
                    setState(() {
                      widget.urlImagem = _controllerImagem.text;
                    });
                  },
                  child: Text('Verificar Imagem'),
                ),
              ],
            ),
          ),
        ),
      ],
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
          _platina = itemEScolhido;
        });
      },
    );
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
          _campanha = itemEScolhido;
        });
      },
    );
  }
}
