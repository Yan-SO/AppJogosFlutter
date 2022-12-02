import 'dart:ui';

import 'package:appjogos/helper/httpHelper.dart';
import 'package:appjogos/models/usuario.dart';
import 'package:appjogos/pages/JogosCompartinhados/JogosCompartinhados.dart';
import 'package:appjogos/pages/cadastrajogo/cadastrajogos.dart';
import 'package:appjogos/pages/addtextoparajogo/addtextoparajogo.dart';
import 'package:appjogos/shared/clipper/myclipper.dart';
import 'package:flutter/material.dart';
import '../../pages/meusJogos/MeusJogos.dart';

class BarraNavegacao extends StatefulWidget {
  Usuario user;
  BarraNavegacao({super.key, required this.user});

  @override
  State<BarraNavegacao> createState() => _BarraNavegacaoState();
}

class _BarraNavegacaoState extends State<BarraNavegacao> {
  int _selectedIndex = 1;
  TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  // ignore: prefer_final_fields

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[
      CadastraJogos(
        user: widget.user,
      ),
      MeusJogos(user: widget.user),
      JogosGalera(),
    ];

    return Scaffold(
      drawer: Drawer(
        child: _menuUser(context),
      ),
      appBar: AppBar(
        title: const Text('Lista de Jogos'),
        backgroundColor: Color.fromARGB(255, 0, 6, 87),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.gamepad),
            label: 'Cadastrar Jogo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Meus Jogos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Jogos da Galera',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromARGB(255, 0, 6, 87),
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _menuUser(BuildContext context) {
    return Column(
      children: [
        _imagemAvatar(context, widget.user),
        ListTile(
          onTap: () => _trocarUserName(context),
          title: Container(
            margin: EdgeInsets.symmetric(vertical: 30),
            child: Text(
              widget.user.nomeUsuario,
              style: TextStyle(
                fontSize: 32,
              ),
            ),
          ),
        ),
        Spacer(),
        ListTile(
          onTap: () {
            Navigator.of(context).pushReplacementNamed('/login');
          },
          title: Container(
            child: Text(
              'Sair',
              style: TextStyle(
                color: Color.fromARGB(255, 163, 0, 0),
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              textDirection: TextDirection.rtl,
            ),
            margin: EdgeInsets.all(30),
          ),
        ),
      ],
    );
  }

  Future<void> _trocarImagen(BuildContext context) {
    final TextEditingController _controllerImage = TextEditingController();

    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('trocar a Imagem'),
          content: TextField(
            autofocus: true,
            autocorrect: false,
            controller: _controllerImage,
            decoration: InputDecoration(
                label: Text('Coloque a URL da imagem'),
                hintText: 'www.minhaimagem.com'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                final Map<String, String> atualiza = {
                  "imagemAvatar": _controllerImage.text
                };
                final resposta =
                    await HttpHelper().atualizarUser(widget.user, atualiza);
                print(resposta);
                final user = await HttpHelper().pegarUserPorId(widget.user.id!);
                setState(() {
                  widget.user = Usuario.fromJson(user);
                });
                Navigator.pop(context, 'Salvar');
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _trocarUserName(BuildContext context) {
    final TextEditingController _controllerNome = TextEditingController();

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('trocar o Nome'),
          content: TextField(
            autofocus: true,
            autocorrect: false,
            controller: _controllerNome,
            decoration: InputDecoration(
                label: Text('O novo nome'), hintText: 'coloque o nome aqui'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'Salvar'),
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  Widget _imagemAvatar(BuildContext context, Usuario user) {
    if (user.imagemAvatar != null) {
      return ListTile(
          onTap: () => _trocarImagen(context),
          title: Container(
            height: 250,
            padding: EdgeInsets.all(10),
            child: ClipOval(
              child: Image.network(
                user.imagemAvatar!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                      'images/pngtree-error-404-page-png-image_3811907.jpg');
                },
              ),
              clipper: MyClipper(),
            ),
          ));
    } else {
      return ListTile(
        onTap: () => _trocarImagen(context),
        title: Column(
          children: [
            Image.asset('images/useravatar.png'),
            Text(
              'Click para colocar uma Imagem',
              style: TextStyle(
                  color: Color.fromARGB(255, 161, 12, 1), fontSize: 18),
            ),
          ],
        ),
      );
    }
  }
}
