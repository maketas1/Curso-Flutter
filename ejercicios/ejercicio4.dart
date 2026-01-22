import 'dart:io';

void mostrarTodos(List<String> tareas) {
  if(tareas.isEmpty == true) {
          print("No hay tareas");
        } else {
          for(int i = 0; i < tareas.length; i++) {
            print("Indice: $i\nTarea: ${tareas[i]}");
          }
        }
}

void ejercicio1() {
  List<String> tareas = [];
  bool continuar = true;
  
  while (continuar) {
    print('\n╔═══════════════════════════════════════╗');
    print('║     GESTOR DE TAREAS                  ║');
    print('╚═══════════════════════════════════════╝');
    print('1. ➕ Agregar tarea');
    print('2. ❌ Eliminar tarea por nombre');
    print('3. 🗑️  Eliminar tarea por posición');
    print('4. 🔍 Buscar tarea');
    print('5. 📋 Mostrar todas las tareas');
    print('6. 🧹 Limpiar todas las tareas');
    print('0. 🚪 Salir');
    
    stdout.write('\nSelecciona una opción: ');
    String? opcion = stdin.readLineSync();
    
    switch (opcion) {
      case '1':
        print("Indique la tarea que quiere añadir: ");
        String? tarea = stdin.readLineSync();
        if(tarea != null) {
          tareas.add(tarea);
          print("La tarea ha sido añadida con exito.");
        }
        break;
        
      case '2':
        mostrarTodos(tareas);
        print("Indique la tarea que quiere eliminar: ");
        String? tarea = stdin.readLineSync();
        if(tarea != null) {
          if(tareas.contains(tarea)) {
            tareas.remove(tarea);
            print("La tarea ha sido eliminada con exito");
          } else {
            print("La tarea no esta en la lista");
          }
        }
        break;
        
      case '3':
        mostrarTodos(tareas);
        print("Indique la posicion que quiere eliminar: ");
        String? posicion = stdin.readLineSync();
        if(posicion != null) {
          int pos = int.parse(posicion);
          if(pos >= 0 && pos < tareas.length) {
            tareas.removeAt(pos);
            print("La tarea ha sido eliminada");
          } else {
            print("Ese indice no esta en la lista");
          }
        }
        break;
        
      case '4':
        print("Indique la tarea que quiere buscar: ");
        String? tarea = stdin.readLineSync();
        if(tarea != null) {
          if(tareas.contains(tarea)) {
            print("La tarea esta en la lista con el indice: ${tareas.indexOf(tarea)}");
          }
        }
        break;
        
      case '5':
        mostrarTodos(tareas);
        break;
        
      case '6':
        tareas.clear();
        print("La lista ha sido limpiada");
        break;
        
      case '0':
        print('\n👋 ¡Hasta luego!');
        continuar = false;
        break;
        
      default:
        print('❌ Opción inválida');
    }
  }
}

void ejercicio2() {
  print('╔═══════════════════════════════════════╗');
  print('║  ANÁLISIS DE CALIFICACIONES           ║');
  print('╚═══════════════════════════════════════╝\n');
  
  List<double> calificaciones = [];
  
  
  for (int i = 1; i <= 10; i++) {
    stdout.write('Calificación $i (0-10): ');
    String? input = stdin.readLineSync();
    double? nota = double.tryParse(input ?? '0');
    
    if (nota == null || nota < 0 || nota > 10) {
      print('❌ Calificación inválida');
      i--;
      continue;
    }
    
    calificaciones.add(nota);
  }

  double promedio = calificaciones.isEmpty ? 0 : calificaciones.reduce((a, b) => a + b) / calificaciones.length;

  double notaMax = calificaciones.isEmpty ? 0 : calificaciones.reduce((a, b) => a < b ? b : a);
  double notaMin = calificaciones.isEmpty ? 0 : calificaciones.reduce((a, b) => a > b ? b : a);

  var aprobadas = calificaciones.where((nota) => nota >= 5);

  var sobresalientes = calificaciones.where((nota) => nota >= 9);

  var ordenadas = List<double>.from(calificaciones);
  ordenadas.sort();
  
  var descendente = List<double>.from(calificaciones);
  descendente.sort((a, b) => b.compareTo(a));

  print("=== Resultados ===");
  print('Calificaciones: $calificaciones');
  print('Promedio: ${promedio.toStringAsFixed(2)}');
  print('Máxima: $notaMax');
  print('Mínima: $notaMin');
  print('Aprobadas: ${aprobadas.length}');
  print('Sobresalientes: ${sobresalientes.length}');
  print('Ordenadas (↑): $ordenadas');
  print('Ordenadas (↓): $descendente');
}

void ejercicio3() {
  print('╔═══════════════════════════════════════╗');
  print('║  MANIPULADOR DE LISTAS                ║');
  print('╚═══════════════════════════════════════╝\n');
  
  var numeros = List<int>.generate(20, (index) => index + 1);
  print('Lista original: $numeros\n');

  print('═══ MAP (transformar) ═══');
  var duplicado = numeros.map((numero) => numero * 2).toList();
  print("Duplicados: $duplicado");

  var cuadrados = numeros.map((numero) => numero * numero).toList();
  print("Cuadrados: $cuadrados");

  var negativos = numeros.map((numero) => -numero).toList();
  print("Negativos: $negativos");

  print('\n═══ WHERE (filtrar) ═══');
  var pares = numeros.where((numero) => numero % 2 == 0).toList();
  print("Pares: $pares");

  var mayores10 = numeros.where((numero) => numero > 50).toList();
  print("Nº mayores que 50: $mayores10");

  var multiplos3 = numeros.map((numero) => numero % 3 == 0);
  print("Nº multiplos de 3: $multiplos3");

  print('\n═══ ANY y EVERY (verificar) ═══');
  
  bool mayores50 = numeros.any((numero) => numero > 50);
  print("¿Hay nº mayores que 50? $mayores50");

  bool menores100 = numeros.every((numero) => numero < 100);
  print("¿Hay nº menores que 100? $menores100");

  print('\n═══ EXPAND (expandir) ═══');
  var expandida = numeros.expand((numero) => [numero, numero]).toList();
  print("Lista expandida: $expandida");

}

void main() {
  print("Ejercicio 1");
  ejercicio1();

  print("Ejercicio 2");
  ejercicio2();

  print("Ejercicio 3");
  ejercicio3();
}