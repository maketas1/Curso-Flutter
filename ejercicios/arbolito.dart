import 'dart:io';

void pintarLinea(int mitad, int primo) {
  String hojas = "*";
  String espacios = " ";
  String cadena = "";
  for(int i = mitad; i > 0; i--) {
    cadena = "$cadena$espacios";
  }
  for(int i = 0; i < primo; i++) {
    cadena = "$cadena$hojas";
  }
  print(cadena);
}

void arbolito() {
  print("Indique la altura del arbol");
  String? alturaStr = stdin.readLineSync();
  int? altura = int.tryParse(alturaStr ?? '0');

  if (altura == null || altura <= 0) {
    print('❌ Cantidad inválida');
    return;
  }
  List<int> cantidad = [1];
  int contador = 1;
  while(contador < altura) {
    cantidad.add(cantidad[contador-1] + 2);
    contador++;
  }

  double mitadDoecimal = cantidad[cantidad.length-1]/2;
  int mitadEntera = mitadDoecimal.toInt();
  int reducida = mitadEntera;
  String maceta = "";
  for(int i = mitadEntera -1; i > 0; i--) {
    maceta = "$maceta ";
  }
  maceta = "$maceta|||";
  for(int i = 0; i < altura; i++){
    pintarLinea(reducida, cantidad[i]);
    reducida--;
  }
  print(maceta);
}

void flechaIxquierda() {
  print("Indique la longitud de la flecha");
  String? alturaStr = stdin.readLineSync();
  int? altura = int.tryParse(alturaStr ?? '0');

  if (altura == null || altura <= 0) {
    print('❌ Cantidad inválida');
    return;
  }
  List<int> cantidad = [1];
  int contador = 1;
  while(contador < altura) {
    cantidad.add(cantidad[contador-1] + 1);
    contador++;
  }

  double mitadDoecimal = cantidad[cantidad.length-1]/2;
  int mitadEntera = mitadDoecimal.toInt();
  int reducida = mitadEntera;
  String maceta = "";
  for(int i = mitadEntera -1; i > 0; i--) {
    maceta = "$maceta ";
  }
  maceta = "$maceta|||";
  for(int i = 0; i < altura; i++){
    pintarLinea(reducida+1, cantidad[i]);
    reducida--;
  }
  print(maceta);
}

void main() {
  arbolito();
}