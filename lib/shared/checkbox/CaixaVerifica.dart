import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LabeledCheckbox extends StatelessWidget {
  const LabeledCheckbox({
    super.key,
    required this.titulo,
    required this.padding,
    required this.value,
    required this.onChanged,
  });

  final String titulo;
  final EdgeInsets padding;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(!value);
      },
      child: Padding(
        padding: padding,
        child: Row(
          children: <Widget>[
            Expanded(
                child: Text(
              titulo,
              style: TextStyle(color: Colors.white),
            )),
            Checkbox(
              value: value,
              onChanged: (bool? newValue) {
                onChanged(newValue!);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CaixaVerifica extends StatefulWidget {
  final String titulo;
  const CaixaVerifica({super.key, required this.titulo});

  @override
  State<CaixaVerifica> createState() => _CaixaVerificaState();
}

class _CaixaVerificaState extends State<CaixaVerifica> {
  bool isSelected = true;

  @override
  void initState() {
    _verificaNaMemoria();
    super.initState();
  }

  Future salvarLogin(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    await prefs.setBool('salvarLogin', value).then((value) => print(
        'dentro de salvarLogin - O valor Salvo é : ${prefs.getBool('salvarLogin')} '));
  }

  Future<void> _verificaNaMemoria() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // talvez colocando await aqui funcione
    bool? valor = prefs.getBool('salvarLogin');
    if (valor == null) {
      setState(() {
        isSelected = true;
      });
      print(
          'dentro de _verificaNaMemoria era para ser true - O valor Salvo é : ${prefs.getBool('salvarLogin')} ');
    } else {
      setState(() {
        isSelected = valor;
      });
      print(
          'dentro de _verificaNaMemoria erapaser valor: $valor - O valor Salvo é : ${prefs.getBool('salvarLogin')} ');
    }
  }

  @override
  Widget build(BuildContext context) {
    return LabeledCheckbox(
      titulo: widget.titulo,
      padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
      value: isSelected,
      onChanged: (bool newValue) {
        salvarLogin(newValue).then(
          (value) => setState(
            () {
              isSelected = newValue;
            },
          ),
        );
      },
    );
  }
}
