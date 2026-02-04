import 'package:flutter/material.dart';

const int usuariosActivos = 1234;
const int ingresos = 45601;
const int tasaConversion = 78;

// Cambios
const int cambioUsuarios = 12;    // positivo = ↑ verde
const int cambioIngresos = -5;    // negativo = ↓ rojo
const int cambioConversion = 23;  // positivo = ↑ verde

// Gráfico
const List<int> datosGrafico = [65, 42, 78, 91, 55];
const List<String> diasSemana = ['Lun', 'Mar', 'Mié', 'Jue', 'Vie'];

// Transacciones
const List<Map<String, dynamic>> transacciones = [
  {'id': '#1001', 'monto': '125.50€', 'estado': 'Completado'},
  {'id': '#1002', 'monto': '89.99€', 'estado': 'Pendiente'},
  {'id': '#1003', 'monto': '234.75€', 'estado': 'Cancelado'},
  {'id': '#1004', 'monto': '456.00€', 'estado': 'Completado'},
  {'id': '#1005', 'monto': '178.25€', 'estado': 'Pendiente'},
];

class Ejercicio2 extends StatelessWidget {
  const Ejercicio2({super.key});

  @override
  Widget build(BuildContext context) {
    var alto = MediaQuery.of(context).size.height;
    double ancho = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        backgroundColor: const Color.fromARGB(255, 6, 186, 195),
      ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            width: ancho,
            height: alto,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text("Métricas principales"),
                SizedBox(
                  height: 10,
                ),
                container1(ancho),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

var icono1 = Icon(
                Icons.people,
                size: 40,
                color: Colors.blue
              );
var icono2 = Icon(
                Icons.euro,
                size: 40,
                color: Colors.green
              );
var icono3 = Icon(
                Icons.trending_up,
                size: 40,
                color: Colors.orange
              );

Container container1(double ancho) {
  return Container(
    height: 200,
    width: ancho,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        cards(icono1, usuariosActivos.toString(), "Usuarios activos", cambioUsuarios),
        cards(icono2, ingresos.toString(), "Ingresos", cambioIngresos),
        cards(icono3, '${tasaConversion.toString()}%', "Conversión", cambioConversion)
      ],
    ),
  );
}

Container cards(Icon icono, String cifra, String descripcion, int porcentaje) {
  return Container(
          width: 125,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(123),
                offset: Offset(2, 2),
                blurRadius: 5,
              ),
            ]
          ),
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              icono,
              Text(cifra),
              Text(descripcion),
              Text(
                '$porcentaje%',
                style: TextStyle(
                  color: porcentaje < 0 ? Colors.red : Colors.green,
                ),
              )
            ],
          ),
        );
}