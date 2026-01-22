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
        // TODO: Eliminar por nombre
        // - Lee el nombre de la tarea
        // - Usa contains() para verificar si existe
        // - Usa remove() para eliminarla
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

void main() {
  print("Ejercicio 1");
  ejercicio1();
}