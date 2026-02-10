import 'package:flutter/material.dart';
import 'package:widget_basicos/widgets_basicos/dia9/my_lesson_header.dart';
import 'package:widget_basicos/widgets_basicos/dia9/my_navigation_button.dart';
import 'package:widget_basicos/widgets_basicos/my_col_row_stack.dart';

class Dia92 extends StatelessWidget {
  const Dia92({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mas widgets"),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyLessonHeader(fecha: "Lunes, 9 de febrero", titulo:"Enrutamiento, snackbar, imagenes, listview, scafold", color: Colors.blue,
            icono: Icons.abc,),
            SizedBox(
              height: 20,
            ),
            ElevatedButton.icon(onPressed: (){
              Navigator.push(
                context,MaterialPageRoute(builder: (context)=> MyColRowStack())
              );
            }, label: Text("Ejemplo básico (Navigation.push)", style: TextStyle(color: Colors.white),), style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12)
            )),
            SizedBox(
              height: 20,
            ),
            ElevatedButton.icon(onPressed: (){
              Navigator.pushNamed(context, '/snackbar');
            }, label: Text("Snackbar", style: TextStyle(color: Colors.white),), style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12)
            )),
            SizedBox(
              height: 20,
            ),
            MyNavigationButton(icon: Icons.view_quilt, title: "Scaffold", description: "Exploracion widget Scaffold", color: Colors.blueAccent, routeName: '/scaffold', context: context),
            SizedBox(
              height: 20,
            ),
            MyNavigationButton(icon: Icons.view_quilt, title: "Imagenes", description: "Imagenes", color: Colors.blueAccent, routeName: '/images', context: context),
            SizedBox(
              height: 20,
            ),
            MyNavigationButton(icon: Icons.view_quilt, title: "Imagenes1", description: "Imagenes1", color: Colors.blueAccent, routeName: '/images1', context: context),
            SizedBox(
              height: 20,
            ),
            MyNavigationButton(icon: Icons.view_quilt, title: "ListView", description: "ListView", color: Colors.blueAccent, routeName: '/listview', context: context),
          ],
        ),
      ),
    );
  }
}