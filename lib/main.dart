import 'package:appjogos/models/usuario.dart';
import 'package:appjogos/pages/cadastro/cadastro.dart';
import 'package:appjogos/pages/addtextoparajogo/addtextoparajogo.dart';
import 'package:appjogos/pages/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'pages/meusJogos/MeusJogos.dart';
import 'pages/JogosCompartinhados/JogosCompartinhados.dart';
import 'shared/navigation/barraNavegacao.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Login(),
      routes: {
        '/login': (context) => Login(),
        '/cadastro': (context) => Cadastro(),
      },
    );
  }
}

// SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);