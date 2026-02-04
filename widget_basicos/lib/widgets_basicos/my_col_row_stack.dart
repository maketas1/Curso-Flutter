import 'package:flutter/material.dart';

class MyColRowStack extends StatelessWidget {
  const MyColRowStack({super.key});

  @override
  Widget build(BuildContext context) {

    Container columna1 = Container(
      color: Colors.amberAccent,
      height: 80,
      child: DefaultTextStyle(
        style: TextStyle(
          color: Colors.black
        ),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,  //Por defecto, alinea en la parte superior.
          // mainAxisAlignment: MainAxisAlignment.center,  //Alinea en el centro
          // mainAxisAlignment: MainAxisAlignment.spaceBetween, //Espacios entre elementos
          // mainAxisAlignment: MainAxisAlignment.spaceAround, //Espacio alrededor de los elementos
          mainAxisAlignment: MainAxisAlignment.spaceEvenly, //Espacio uniforme
          // crossAxisAlignment: CrossAxisAlignment.center, //Por defecto. centrados horizontalmente
          // crossAxisAlignment: CrossAxisAlignment.start, //Alinea a la izquierda
          // crossAxisAlignment: CrossAxisAlignment.end, //Alinea a la derecha
          crossAxisAlignment: CrossAxisAlignment.stretch, //Se expande al ancho disponible
          // crossAxisAlignment: CrossAxisAlignment.baseline, //Alinea a linea base
          // mainAxisSize: MainAxisSize.max, //Ocupa el maximo espacio disponible en el eje principal
          mainAxisSize: MainAxisSize.min, //Ocupa el minimo espacio disponible en el eje principal
          children: [
            Text(
              "Col: Disposicion vertical",
              textAlign: TextAlign.right,
            ),
            SizedBox(
              height: 2,
            ),
            Text("Horganiza elementos de forma vertical"),
            SizedBox(
              height: 2,
            ),
            Text("Otro elemento")
          ],
        ),
      ),
    );

    //Flexible vs expanded
    Container columna2 = Container(
      color: Colors.red,
      height: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch, //Se expande al ancho disponible
        children: [
          Flexible(
            flex: 2,
            fit: FlexFit.loose, //Se ajusta al contenido
            // fit: FlexFit.tight, //Se expande
            child: Container(
              color: Colors.brown,
              child: Text(
                "Utilizando flexible",
              ),
            ),
          ),
          Flexible(
            flex: 8,
            fit: FlexFit.tight,
            child: Container(
              color: Colors.lightBlue,
              child: Text("Horganiza elementos de forma vertical")
              ),
          ),
          Flexible(
            flex: 2,
            fit: FlexFit.tight,
            child: Container(
              color: Colors.yellow,
              child: Text("Otro elemento")
              ),
          ),
          Text("Final de la columna")
        ],
      ),
    );

    Container columna3 = Container(
      color: Colors.purpleAccent,
      height: 150,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: Colors.green,
            width: 30,
            child: Text(
              "1",
              style: TextStyle(
                fontSize: 23
              ),
            ),
          ),
          VerticalDivider(),
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.lightBlue,
              width: 30,
              child: Text(
                "2",
                style: TextStyle(
                  fontSize: 23
                ),
              ),
              ),
          ),
          SizedBox(
            width: 15,
          ),
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.yellow,
              width: 30,
              child: Text(
                "3",
                style: TextStyle(
                  fontSize: 23
                ),
              ),
              ),
          ),
        ],
      ),
    );

    double ancho = MediaQuery.of(context).size.width;
    Container stack1 = Container(
      color: Colors.grey,
      width: ancho / 2,
      height: 250,
      alignment: Alignment.center,
      child: Stack(
        alignment: AlignmentGeometry.center,
        children: [
          Container(
            width: 300,
            height: 200,
            color: Colors.orange,
            child: Center(
              child: Text(
                "Fondo del stack"
                ),
            ),
          ),
          Positioned(
            top: 25,
            right: 25,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle
              ),
            ),
          ),
          Positioned(
            width: 150,
            height: 25,
            bottom: 25,
            
            child: Container(
              width: 90,
              height: 30,
              color: Colors.yellowAccent,
              child: Center(
                child: Text(
                  "Etiqueta"
                  ),
              ),
            ),
          ),
        ],
      ),
    );

    Wrap wrap1 = Wrap(
      children: [
        Chip(label: Text("hola")),
        Chip(label: Text("hola")),
        Chip(label: Text("hola")),
        Chip(label: Text("hola")),
        Chip(label: Text("hola")),
        Chip(label: Text("hola")),
        Chip(label: Text("hola")),
        Chip(label: Text("hola")),
        Chip(label: Text("hola")),
        Chip(label: Text("hola")),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Column, Row & Stack"),
        backgroundColor: Colors.orange,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Container(
            margin: EdgeInsets.all(10),
            width: double.maxFinite,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.blue,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 7,
                ),
                Text("Ejemplo de columnas"),
                Divider(
                  color: Colors.blue,
                  thickness: 10,
                  height: 30,
                  indent: 15,
                  endIndent: 15,
                ),
                Text("Primer hijo"),
                Divider(),
                Text("Segundo hijo"),
                Divider(),
                columna1,
                Divider(),
                columna2,
                Divider(),
                columna3,
                Divider(),
                stack1,
                Divider(),
                wrap1,
              ],
            ),
          ),
        ),
      ),
    );
  }
}