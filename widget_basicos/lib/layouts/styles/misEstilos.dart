import 'package:flutter/material.dart';

/// Estilo principal usado en MainApp
TextStyle miEstilo1 = const TextStyle(
  fontSize: 30,
  fontWeight: FontWeight.w900,
  color: Color.fromARGB(255, 64, 132, 206),
  fontStyle: FontStyle.italic,
  decoration: TextDecoration.underline,
  decorationColor: Colors.red,
  decorationStyle: TextDecorationStyle.wavy,
  decorationThickness: 3,
  letterSpacing: 2,
  wordSpacing: 10,
  height: 1.5,
  shadows: [
    Shadow(
      offset: Offset(4, 4),
      blurRadius: 4,
      color: Color.fromARGB(125, 236, 157, 157),
    ),
  ],
);

/// (Opcional) Otro estilo por si quieres reutilizarlo
TextStyle miEstilo2 = const TextStyle(
  fontSize: 20,
  color: Colors.orange,
);