import 'dart:io';
import 'dart:math';

void ejercicio1() {
  Set<int> carton = {};
  while(carton.length <= 14) {
    carton.add(Random().nextInt(60) + 1);
  }
  
  print("Carton: $carton");

  Set<int> sorteados = {};
  while(sorteados.length <= 59) {
    sorteados.add(Random().nextInt(60) + 1);
  }
  Set<int> duplicado = Set.from(carton);
  Set<int> duplicado1 = Set.from(sorteados);
  int contador = 0;
  externo:
  for(int sorteo in sorteados) {
    if(duplicado.length == 0) {
      break externo;
    }
    print("Bola nº: $sorteo");
    if(duplicado.contains(sorteo)) {
      print("Se encuentra en tu carton");
      duplicado.remove(sorteo);
      print("Numeros restantes de tu carton: $duplicado");
    } else {
      print("No se encuentra en tu carton");
    }
    duplicado1.remove(sorteo);
    contador++;
  }
  print("Se han hacertado todos los numeros en la bola nº $contador");
  print("Numeros restantes para terminar el bombo: $duplicado1");
}

void ejercicio2() {
  Map<String, String> contactos = {};
  bool exit = false;
  while(exit == false) {
    print('''
=======Menú=======
1. Añadir contacto
2. Buscar contacto
3. Modificar contaco
4. Eliminar contacto
5. Exit''');
    String? opcionStr = stdin.readLineSync();
    int? opcion = int.tryParse(opcionStr ?? '0');
    switch(opcion) {
      case 1:
        String nombre = redundancia();
        String telefono = redundancia1();
        if(formato(telefono) == false) {
          print("No se ha podido insertar");
          print("Formato del telefono incorrecto");
          break;
        }
        contactos.putIfAbsent(nombre, () => telefono);
        print(contactos);
        break;
      case 2: 
        String nombre = redundancia();
        bool existe = false;
        for(var key in contactos.keys) {
          if(key == nombre) {
            print("El telefono del contacto es: ${contactos[key]}");
            existe = true;
          }
        }
        if(existe == false) {
          print("El contacto indicado no existe");
        }
        break;
      case 3:
        String nombre = redundancia();
        String telefono = redundancia1();
        if(formato(telefono) == false) {
          print("No se ha podido insertar");
          print("Formato del telefono incorrecto");
          break;
        }
        contactos.update(nombre, (_) => telefono);
        print("Contacto actualizado");
        break;
      case 4:
        print(contactos);
        String nombre = redundancia();
        contactos.remove(nombre);
        print("Contacto eliminado");
        break;
      case 5:
        exit = true;
        break;
      default:
        print("Opcion no valida");
        break;
    }
  }
}

String redundancia() {
  print("Escriba el nombre del contacto");
  String nombre = stdin.readLineSync()?.trim() ?? "";
  return nombre;
}

String redundancia1() {
  print("Escriba el nº de telefono");
  String telefono = stdin.readLineSync()?.trim() ?? "";
  return telefono;
}

bool formato(String telefono) {
  RegExp regExp = RegExp("r\d{3}-\d{2}-\d{2}-\d{2}");
  bool formato = regExp.hasMatch(telefono);
  return formato;
}

void main() {
  print("Ejercicio 1");
  ejercicio1();

  print("Ejercicio 2");
  ejercicio2();
}