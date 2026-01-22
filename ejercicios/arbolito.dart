import 'dart:io';
import 'dart:math';

void pintar(var producto, var cantidad) {
  print("Producto: ${producto.key}");
  print("Precio unitario: ${producto.value}");
  print("Subtotal ${producto.value * cantidad.value}");
  print("-------------------------------------------");
}

void ejericicio1() {
  Map<String, double> productos = {'Manzana': 1.5, 'Pan': 2.0, 'Leche': 3.5, 'Huevos': 4.0, 'Queso': 5.5};
  List<String> lista = ['Manzana', 'Pan', 'Manzana', 'Leche', 'Queso'];

  int manzanas = 0;
  int pan = 0;
  int leche = 0;
  int huevos = 0;
  int queso = 0;

  for(String articulo in lista) {
    switch(articulo.toLowerCase()) {
      case "manzana":
        manzanas++;
        break;
      case "pan":
        pan++;
        break;
      case "leche":
        leche++;
        break;
      case "huevos":
        huevos++;
        break;
      case "queso":
        queso++;
        break;
      default:
        print("Producto no disponible $articulo");
        break;
    }
  }
  print("🛒 CARRITO DE COMPRAS:");
  Map<String, int> cantidades = {'Manzana': manzanas, 'Pan': pan, 'Leche': leche, 'Huevos': huevos, 'Queso': queso};
  double total = 0;
  for(var producto in productos.entries) {
    for(var cantidad in cantidades.entries) {
      if(producto.key == cantidad.key && cantidad.value != 0) {
        total += (producto.value * cantidad.value);
        pintar(producto, cantidad);
      }
    }
  }

  double descuento = 0;
  var porcentajes = (10, 15, 20);
  print("💰 RESUMEN:");
  print("Total sin descuento: €$total");
  switch(total) {
    case double t when t >= 10:
      descuento = (total * porcentajes.$1)/100;
      print("Descuento aplicado: ${porcentajes.$1}% (-$descuento)");
      break;
    case double t when t >= 15:
      descuento = (total * porcentajes.$2)/100;
      print("Descuento aplicado: ${porcentajes.$2}% (-$descuento)");
      break;
    case double t when t >= 20:
      descuento = (total * porcentajes.$3)/100;
      print("Descuento aplicado: ${porcentajes.$3}% (-$descuento)");
      break;
  }
  print("-------------------------------------------");
  print("💵 TOTAL A PAGAR: €${total - descuento}");
}

void ejercicio2() {
  //String texto ="Tu madre tiene una polla que ya la quisiera yo. Me dio pena por tu padre el dia que se entero";
  String texto = "Dart es un lenguaje de programacion moderno y versatil";

  List<String> palabras = texto.split(" ");
  List<String> caracteres = texto.split("");
  
  int a = 0;
  int e = 0;
  int i = 0;
  int o = 0;
  int u = 0;
  int vocales = 0;
  int consonantes = 0;
  for(String caracter in caracteres) {
    switch(caracter.toLowerCase()){
      case "a":
        a++; vocales++; break;
      case "e":
        e++; vocales++; break;
      case "i":
        i++; vocales++; break;
      case "o":
        o++; vocales++; break;
      case "u":
        u++; vocales++; break;
      case " ":
        break;
      default:
        consonantes++; break;
    }
  }

  print("📝 Texto: $texto");
  print("📊 ESTADÍSTICAS GENERALES:");
  print("✓ Total de caracteres: ${caracteres.length}");
  print("✓ Total de palabras: ${palabras.length}");
  print("✓ Total de vocales: $vocales");
  print("✓ Total de consonantes: $consonantes");
  String palabraMasLarga = "";
  String palabraMasCorta = "";
  int max = 0;
  int min = 100;
  for(String palabra in palabras) {
    List<String> cadena = palabra.split("");
    if(cadena.length < min) {
      min = cadena.length;
      palabraMasCorta = palabra;
    } else if(cadena.length > max) {
      max = cadena.length;
      palabraMasLarga = palabra;
    }
  }

  print("📏 ANÁLISIS DE PALABRAS:");
  print("✓ Palabra más larga: $palabraMasLarga ($max letras)");
  print("✓ Palabra más corta: $palabraMasCorta ($min letras)");

  print("🔤 CONTEO DE VOCALES:");
  print('''
a: $a veces
e: $e veces
i: $i veces
o: $o veces
u: $u veces
''');
}

void pistas(int opcion) {
  switch(opcion){
    case 1:
      print("💡 Pista: El número es más alto");
      break;
    case 2:
      print("💡 Pista: El número es más bajo");
      break;
    default:
      break;
  }
}

void adivinado(int intentos) {
  if(intentos == 1 || intentos == 2) {
    print("🏆 ¡Excelente!");
  } else if(intentos == 3 || intentos == 4) {
    print("🥈 ¡Muy bien!");
  } else if(intentos >= 5 && intentos <= 7) {
    print("🥉 ¡Lo lograste!");
  }
  print("Número de intentos: $intentos/7");
}

void ejercicio3() {
  int numAleatorio = Random().nextInt(50) + 1;
  print(numAleatorio);
  print("Juego de adivinanza");
  print("🎯 Tienes 7 intentos");
  int intentos = 0;
  externo:
  for(int i = 1; i <= 7; i++) {
    intentos++;
    print("Intento #$i: ");
    String? entradaStr = stdin.readLineSync();
    int? entrada = int.tryParse(entradaStr ?? '0');
    if(entrada == numAleatorio) {
      adivinado(intentos);
      break externo;
    }

    if(entrada! < numAleatorio) {
      pistas(1);
    } else if(entrada > numAleatorio) {
      pistas(2);
    }
  }

  if(intentos == 7) {
    print("--------------------");
    print("❌ ¡Se acabaron los intentos!");
    print("El número secreto era: $numAleatorio");
  }
}

void main() {
  print("Ejercicio 1");
  ejericicio1();
  print("Ejercicio 2");
  ejercicio2();
  print("Ejercicio 3");
  ejercicio3();
}