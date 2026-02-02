import 'package:flutter/material.dart';
import 'package:widget_basicos/widgets_basicos/utils.dart';

class MyContainer extends StatelessWidget {
  MyContainer({super.key, required this.titulo});

  String titulo = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("Mi container"),),
      appBar: AppBar(title: Text(titulo),),
      body: Center(
        /*child: ListView( //Permite el escroleo
          children: [
            columna(20, Colors.red, 40, 40),
          ],
        ),*/
        //child: columna(5, Colors.red, 40, 40),
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            miContenedor1,
            /*SizedBox(
              height: 20,
            ),*/
            Transform.translate(
              offset: Offset(-20, -200),
              child: Transform.scale(
                scale: 0.7,
                child: Container(
                  width: 200,
                  height: MediaQuery.of(context).size.height * 0.5, //mitad de pantalla
                  color: Colors.orange,
                  //Transformacion (rotacion, escala, translacion)
                  //transform: Matrix4.identity()..rotateZ(1), //en radianes
                  //transform: Matrix4.identity()..scale(0.5),
                ),
              ),
            ),
          ],
        )
      ),
    );
  }

var miContenedor1 = Container(
  height: 200,
  width: 200,
  //width: double.maxFinite, //Coge el ancho completo de la pantalla
  alignment: Alignment.topCenter,
  //color: Colors.yellow, //Si se declara el decoration te obliga a quitarlo por redundancia
  decoration: BoxDecoration(
    color: Color.fromARGB(255, 0, 255, 0),
    border: BoxBorder.all(
      color: Colors.red,
      width: 5,
    ),
    // borderRadius: BorderRadius.circular(100)
    //Te permite hacer aberraciones :)
    borderRadius: BorderRadius.only(topRight: Radius.circular(50), topLeft: Radius.circular(100), bottomLeft: Radius.circular(1000), bottomRight: Radius.circular(500)),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withAlpha(123), //color
        offset: Offset(10, 10), //tamaño
        blurRadius: 10, //Difuminado
      ),
    ]
  ),
  // padding: EdgeInsets.all(50),
  // padding: EdgeInsets.only(left: 20, top: 100),
  padding: EdgeInsets.symmetric(
    vertical: 50, //Padding top y bottom
    horizontal: 30, //Padding left y right
  ),
  margin: EdgeInsets.only(bottom: 20),
  child: Center(
    child: Text("Contenedor de contenedores")
  ),
);
}