double calcularPrecioConIva(double precio, double iva) {
  double aumento = (precio * iva) / 100;
  double resultado = precio + aumento;
  return resultado;
}

void ejercicio1_1() {
  print("Ejercicio 1.1");
  String texto1 = '''
-------------------------------------
    ¡Bienvenido al Curso de Dart!
-------------------------------------
Este es in lenguaje versátil y moderno.
Prepárate para aprender programación''';

  print(texto1);
}

void ejercicio1_2 (List<String> arg) {
  print("Ejercicio 1.2");
  String texto2 = '''
Hola, mi nombre es ${arg.isNotEmpty ? arg[0] : "invitado"}
Tengo ${arg.isNotEmpty ? arg[1] : "desconocido "} años
Soy estudiante de Dart en el curso de Getafe
''';
  print(texto2);
}

void ejercicio3_3() {
  print("Ejercicio 1.3");
  String nombre = "Windows";
  double precio = 300;
  int cantidad = 10;
  bool disponible = true;

  print('Producto: $nombre');
  print('Precio: €$precio');
  print('Stock: $cantidad unidades');
  print('Disponible: $disponible');
}

void ejercicio1_4() {
  print("Ejercicio 1.4");
  var temperaturaActual = 25;
  //temperaturaActual = 25.5;
  
  dynamic lecturaTemperatura;
  lecturaTemperatura = 20;
  lecturaTemperatura = 22.7;
  lecturaTemperatura = 'Sin medidor';
  
  print('Temperatura actual: $temperaturaActual°C');
  print('Lectura flexible: $lecturaTemperatura');
}

void ejercicio2_1() {
  print("Ejercicio 2.1");
  double precioBase = 150;
  double iva = 21;
  print('Precio base: €$precioBase');
  print('IVA ($iva%): €${(precioBase * iva / 100).toStringAsFixed(2)}');
  print('Precio final: €${calcularPrecioConIva(precioBase, iva)}');
}

void ejercicio2_2() {
  print("Ejercicio 2.2");
  List<double> notas = [8.5, 7.2, 9.1, 6.8, 8.9];
  notas.add(8.3);
  print("Notas " + notas.toString());
  print("Nota en posición 2: " + notas[2].toString());
  int aprobados = 0;
  double sumaTotal = 0;
  for(int i = 0; i < notas.length; i++) {
    sumaTotal += notas[i];
    if(notas[i] >= 7.0) {
      aprobados++;
    }
  }
  print("Estudiantes que aprobaron: " + aprobados.toString());
  double media = sumaTotal / notas.length;
  print("Nota promedio: " + media.toString());
}

void ejercicio2_3() {
  print("Ejercicio 2.3");
  Map<String, double> libreria = {
    'Don Quijote': 15.99,
    'Cien años de soledad': 18.50,
    '1984': 12.99
  };
  libreria['Revelion en la granja'] = 19.99;
  double total = 0;
  for(double precio in libreria.values) {
    total += precio;
  }
  print('Libros: ${libreria.keys}');
  print('Precios: ${libreria.values}');
  print('Precio de Don Quijote: €${libreria['Don Quijote']}');
  print("Total de la libreria: " + total.toString() + "€");
}

void ejercicio2_4() {
  print("Ejercicio 2.4");
  Set<String> lenguajes = {"Java", "Dart", "Python", "C++"};
  lenguajes.add("Java");
  print('Lenguajes: $lenguajes');
  print('Total de lenguajes: ${lenguajes.length}');
  print("¿Dominas Dart?" + lenguajes.contains('Dart').toString());
  lenguajes.add("C#");
  lenguajes.add("C");
  print('Lenguajes: $lenguajes');
}

void ejercicio2_5() {
  print("Ejercicio 2.5");
  String proyectoDescripcion = '''
    ╔═════════════════════════════════════════════╗
    ║      GESTOR DE TAREAS - PROYECTO DART       ║
    ╚═════════════════════════════════════════════╝
    
    DESCRIPCIÓN:
    Aplicación de consola para gestionar tareas diarias
    
    OBJETIVOS:
    • Crear, eliminar y actualizar tareas
    • Marcar tareas como completadas
    • Generar reportes de productividad
    
    TECNOLOGÍA: Dart + Flutter
  ''';
  
  print(proyectoDescripcion);
}

void main(List<String> arg) {
  ejercicio1_1();
  ejercicio1_2(arg);
  ejercicio3_3();
  ejercicio1_4();
  ejercicio2_1();
  ejercicio2_2();
  ejercicio2_3();
  ejercicio2_4();
  ejercicio2_5();

}