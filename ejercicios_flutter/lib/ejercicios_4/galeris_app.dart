import 'package:ejercicios_flutter/ejercicios_4/galeria_page.dart';
import 'package:flutter/material.dart';

class GaleriaApp extends StatelessWidget {
  const GaleriaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Galería de Imágenes",
      home: GaleriaPage(),
    );
  }
}