import 'package:flutter/material.dart';
import 'package:widget_basicos/widgets_basicos/my_col_row_stack.dart';
import 'package:widget_basicos/widgets_basicos/my_container.dart';
import 'package:widget_basicos/widgets_basicos/my_text.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: MyText(),
      // home: MyContainer(titulo: "Mi container"),
      home: MyColRowStack(),
    );
  }
}
/*
      Scaffold(
        appBar: AppBar(title: Text(titulo ?? "Sin título")),
        body: Center(
          child: Container(
            //alignment: AlignmentGeometry.center,
            width: double.maxFinite,
            height: 200,
            // width: null, por defecto. Se adapta al contenido
            // height: null, por defecto. Se adapta al contenido
            decoration: BoxDecoration(color: Colors.blue, 
            border: Border.all(
              color:Colors.orange, width: 15, //Seguir aquí
            )),
            // color: Colors.yellow,
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.only(left: 20, right: 40),
            child: Text(
              "Hola mundo, lorem ipsum dsfasdfafadsfasdfdsafdsffasdf",
              textAlign: TextAlign.left, //Centrado del texto
              textDirection: TextDirection.ltr,
              textScaler: TextScaler.linear(0.5), //Escalar
              semanticsLabel: "Texto para lectores de pantalla", //Accesibilidad
              locale: Locale('es', 'ES'),
              //maxLines: 1, //Cantida máxima de líneas
              //Desbordamiento
              //overflow: TextOverflow.ellipsis, //Añade ...
              //overflow: TextOverflow.clip, //Corta el texto
              overflow: TextOverflow.fade,
              //style: miEstilo2,
              /*style: TextStyle(
                fontSize: 30,
              )*/
              style: estilo,
            ),
          ),
        ),
      ),
    );
  }
}

TextStyle miEstilo = TextStyle(
  fontSize: 30,
  fontWeight: FontWeight.w900,
  color: // Color(0xFF00FF00),
  Color.fromARGB(
    255,
    64,
    132,
    206,
  ),
  //Colors.orange.shade50,
  fontStyle: FontStyle.italic,
  decoration: TextDecoration.underline, //Situación de la línea
  decorationColor: Colors.red, //Color de la línea
  decorationStyle: TextDecorationStyle.wavy, //Tipo de línea
  decorationThickness: 3, //Grosor
  letterSpacing: 2, //Espacio entre letras
  wordSpacing: 10,
  height: 1.5, //Multiplicador de altura
  shadows: [
    Shadow(
      offset: Offset(4, 4), // x e y
      blurRadius: 4, //Desenfoque
      color: const Color.fromARGB(125, 236, 157, 157),
    ),
  ],
);

*/