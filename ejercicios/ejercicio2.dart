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
    
    switch(servicio) {
      case "excelente":
        ejercicio1_1(20, cuenta);
        break;
      case "bueno":
        ejercicio1_1(15, cuenta);
        break;
      case "regular":
        ejercicio1_1(10, cuenta);
        break;
      default:
        print("Valor no permitido");
        break;
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

void ejercicio3() {
  
}

void main() {
  ejercicio1();
  ejercicio2();
}