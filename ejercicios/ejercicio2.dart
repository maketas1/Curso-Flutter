import 'dart:io';

void ejercicio1() {
  stdout.write('Ingresa el total de la cuenta (€): ');
  String? cuentaStr = stdin.readLineSync();
  double? cuenta = double.tryParse(cuentaStr ?? '0');
  
  if (cuenta == null || cuenta <= 0) {
    print('❌ Cantidad inválida');
    return;
  }
  stdout.write('Calidad del servicio (excelente/bueno/regular): ');
  String? servicio = stdin.readLineSync()?.toLowerCase();
    
  int porcentaje = (servicio=="excelente") ? 20 : (servicio=="bueno") ? 15 : (servicio=="regular") ? 10 : 0;

  if(porcentaje == 0) {
    print("Valor no permitido");
  } else {
    ejercicio1_1(porcentaje, cuenta);
  }
}

void ejercicio1_1(int porcentaje, double cuenta) {
  double total = 0;
  double propina = 0;
  propina = cuenta * (porcentaje / 100);
  total = cuenta + propina;
  print("=== DESGLOSE ===");
  print("Subtotal: €$cuenta");
  print("Propina ($porcentaje%): €$propina");
  print("Total: €$total");
}

void ejercicio2() {
  stdout.write('Ingresa un año: ');
  String? anioStr = stdin.readLineSync();
  int? anio = int.tryParse(anioStr ?? '0');
  
  if (anio == null || anio <= 0) {
    print('❌ Año inválido');
    return;
  }

  bool esBisiesto = false;

  if(anio%4 == 0 && anio%100 != 0) {
    esBisiesto = true;
  } else if(anio%400 != 0 && anio%100 == 0) {
    esBisiesto = false;
  } else if(anio%400 == 0) {
    esBisiesto = true;
  }

  if(esBisiesto == true) {
    print("El año: $anio es bisiesto");
  } else {
    print("El año: $anio no es bisiesto");
  }
}

class Tarea {
  String titulo = '';
  String descripcion = '';
  int prioridad = 1; // 1-5
  bool completada = false;
  
  void marcarCompletada() {
    completada = true;
    prioridad = 0;
    print('✅ Tarea "$titulo" marcada como completada');
  }
  
  void mostrarInfo() {
    String estado = completada ? '✅ Completada' : '⏳ Pendiente';
    String nivelPrioridad = (prioridad >= 4) ? '🔴 Alta' :
                            (prioridad >= 2) ? '🟡 Media' : '🟢 Baja';
    
    print('\n╔════════════════════════════════════════╗');
    print('  📌 $titulo');
    print('  📄 $descripcion');
    print('  🎯 Prioridad: $nivelPrioridad ($prioridad)');
    print('  📊 Estado: $estado');
    print('╚════════════════════════════════════════╝');
  }
}

void ejercicio3() {
  Tarea tarea1 = Tarea()
    ..titulo = 'Estudiar Dart'
    ..descripcion = 'Completar ejercicios del curso'
    ..prioridad = 5
    ..mostrarInfo();

  Tarea tarea2 = Tarea()
    ..titulo = 'Estudiar Flutter'
    ..descripcion = 'Completar ejercicios del curso'
    ..prioridad = 5
    ..mostrarInfo();

  Tarea tarea3 = Tarea()
    ..titulo = 'Estudiar C#'
    ..descripcion = 'Aprender por mi cuenta'
    ..prioridad = 2
    ..mostrarInfo();

  Tarea tarea4 = Tarea()
  ..titulo = "prueba de tarea"
  ..descripcion = "prueba de tarea"
  ..prioridad = 5
  ..mostrarInfo();

  List<Tarea> tareas = [];
  tareas.add(tarea1);
  tareas.add(tarea2);
  tareas.add(tarea3);
  tareas.add(tarea4);

  tareas[3].marcarCompletada();
  tareas[3].mostrarInfo();
}

void main() {
  ejercicio1();
  ejercicio2();
  ejercicio3();
}