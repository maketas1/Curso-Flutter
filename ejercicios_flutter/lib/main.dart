import 'package:ejercicios_flutter/Ejercicios_2/ejercicio2.dart';
import 'package:ejercicios_flutter/ejercicios_1/ejercicio1.dart';
import 'package:ejercicios_flutter/ejercicios_3/my_exercise_stateful.dart';
import 'package:ejercicios_flutter/ejercicios_4/galeris_app.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: MyText(),
      // home: ejercicio1(),
      // home: EjercicioCarrito(),
      home: GaleriaApp(),
    );
  }
}
