import 'package:ejercicios_flutter/ejercicios_1/ejercicio1_1.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      // home: MyText(),
      home: ejercicio1_1(),
    );
  }
}
