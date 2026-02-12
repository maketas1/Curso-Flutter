import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

class Paso1Vibracion extends StatefulWidget {
  const Paso1Vibracion({super.key});

  @override
  State<Paso1Vibracion> createState() => _Paso1VibracionState();
}

class _Paso1VibracionState extends State<Paso1Vibracion> {

  String _texto = "";

  void esta() {
    setState(() {
      _texto = "Tiene permitido la vibracion";
    });
  }

  void noEsta() {
    setState(() {
      _texto = "No tiene permitido la vibracion";
    });
  }

  Future<void> vibrar() async {
    if (await Vibration.hasVibrator()) {
      Vibration.vibrate(duration: 500);
      esta();
    } else {
      noEsta();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(_texto),
        FloatingActionButton(
          child: Text("Vibrar telefono"),
          onPressed: (){
            vibrar();
          },
        )
      ],
    );
  }
}