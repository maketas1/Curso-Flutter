import 'package:flutter/material.dart';

Column columna(int cantidad, Color color, double ancho, double alto ){

  List<Widget> lista = [];

  for(int x = 0; x < cantidad; x++) {
    lista.add(Container(
      width: ancho,
      height: alto,
      color: color,
      margin: EdgeInsets.all(10),
    ));
  }
  return Column(
    children: lista,
  );
}