import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImagContenerLista extends StatelessWidget {
  final String urlImagen;

  const ImagContenerLista({super.key, required this.urlImagen});

  // errorBuilder não funciona
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      width: 120,
      height: 200,
      child: Image.network(
        fit: BoxFit.cover,
        urlImagen,
        errorBuilder:
            (BuildContext context, Object exception, StackTrace? stackTrace) {
          return Image.asset(
              'images/pngtree-error-404-page-png-image_3811907.jpg');
        },
      ),
    );
  }
}
