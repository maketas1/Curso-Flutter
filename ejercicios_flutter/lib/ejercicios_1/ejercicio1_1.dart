import 'package:flutter/material.dart';

class ejercicio1_1 extends StatelessWidget {
  const ejercicio1_1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // child: ejercicio1,
        child: Column(
          children: [
            ejercicio1,
            ejercicio2
          ],
        ),
      ),
    );
  }
}

Text ejercicio1 = Text(
  "¡Bienvenido a Flutter!",
  style: TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 24,
    color: Colors.blue
  )
);

Container ejercicio2 = Container(
  height: 200,
  width: 200,
  color: Colors.red,
  child: Center(
    child: Text("Caja roja"),
  ),
);