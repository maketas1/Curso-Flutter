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

Text titulos(String texto) {
  return Text(
    texto,
    style: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  );
}

SizedBox espaciados = SizedBox(
  height: 30,
);

class Ejercicio2 extends StatelessWidget {
  const Ejercicio2({super.key});

  @override
  Widget build(BuildContext context) {
    double alto = 1200;
    double ancho = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Dashboard")),
        backgroundColor: const Color.fromARGB(255, 3, 139, 146),
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
                titulos("Métricas principales"),
                espaciados,
                container1(ancho),
                espaciados,
                titulos("Desempeño semanal"),
                espaciados,
                container2(ancho),
                espaciados,
                titulos("Últimas transacciones"),
                espaciados,
                container3(ancho),
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
    height: 170,
    width: ancho,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        cards1(icono1, usuariosActivos.toString(), "Usuarios activos", cambioUsuarios),
        cards1(icono2, ingresos.toString(), "Ingresos", cambioIngresos),
        cards1(icono3, '${tasaConversion.toString()}%', "Conversión", cambioConversion)
      ],
    ),
  );
}

Container cards1(Icon icono, String cifra, String descripcion, int porcentaje) {
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
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        icono,
        Text(
          cifra,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
          ),
        Text(
          descripcion,
          style: TextStyle(
            color: Colors.grey
          ),
        ),
        Row(
          children: [
            Icon(
              porcentaje < 0 ? Icons.download : Icons.upload,
              color: porcentaje < 0 ? Colors.red : Colors.green,
            ),
            Text(
              '$porcentaje%',
              style: TextStyle(
                color: porcentaje < 0 ? Colors.red : Colors.green,
              ),
            ),
          ],
        )
      ],
    ),
  );
}

Container container2(double ancho){
  return Container(
    height: 320,
    width: ancho,
    color: const Color.fromARGB(255, 241, 241, 241),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: () {
        List<Widget> lista = [];
        for(int i = 0; i < diasSemana.length; i++) {
          lista.add(cards2(datosGrafico[i], diasSemana[i]));
        }
        return lista;
      }.call(),
    ),
  );
}

SizedBox espacio = SizedBox(
  height: 5,
);

Container cards2(int dato, String dia) {
  int altura = 320;
  int ancho = 50;
  double radio = 5;
  return Container(
    width: ancho.toDouble(),
    height: altura.toDouble(),
    // color: Colors.red,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: () {
        List<Widget> lista = [];
        Text texto1 = Text(
          "$dato%",
          style: TextStyle(
            color: dia == "Lun" ? Colors.blue : dia == "Mar" ? Colors.green : dia == "Mié" ? Colors.orange : dia == "Jue" ? Colors.red : Colors.purple,
          ),
        );
        Container rectangulo = Container(
          width: ancho.toDouble(),
          height: ((altura * dato ) / 100).toDouble() - 60,
          decoration: BoxDecoration(
            color: dia == "Lun" ? Colors.blue : dia == "Mar" ? Colors.green : dia == "Mié" ? Colors.orange : dia == "Jue" ? Colors.red : Colors.purple,
            borderRadius: BorderRadiusDirectional.only(topStart: Radius.circular(radio), topEnd: Radius.circular(radio))
          ),
        );
        Text texto2 = Text(
          dia
        );
        lista.add(texto1);
        lista.add(espacio);
        lista.add(rectangulo);
        lista.add(espacio);
        lista.add(texto2);
        lista.add(espacio);
        return lista;
      }.call(),
    )
  );
}

Text texto(String texto) {
  return Text(
    texto,
    style: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.white
    ),
  );
}

Text id(String id) {
  return Text(
    id,
    style: TextStyle(
      fontSize: 20,
    ),
  );
}

Text cantidad(String cantidad) {
  return Text(
    cantidad,
    style: TextStyle(
      fontSize: 20,
    ),
  );
}

Row estado(String estado) {
  return Row(
    children: [
      Text(
        estado,
        style: TextStyle(
          fontSize: 20,
        ),
      )
    ],
  );
}

Container container3(double ancho) {
  double alto = 50;
  return Container(
    height: 400,
    width: ancho,
    margin: EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white,
      // borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(123),
          offset: Offset(2, 2),
          blurRadius: 5,
        ),
      ]
    ),
    child: Column(
      children: [
        Container(
          height: alto,
          width: ancho,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 3, 139, 146),
          ),
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: texto("ID")
              ),
              Expanded(
                flex: 2,
                child: texto("Cantidad")
              ),
              Flexible(
                flex: 2,
                child: texto("Estado")
              )
            ],
          ),
        )
      ],
    ),
  );
}