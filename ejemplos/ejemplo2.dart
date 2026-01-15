import "dart:io";

void main() {
  int a = 10;
  int b = 3;

  print("Suma: ${a+b}");
  print("Resta: ${a-b}");
  print("Multiplicacion: ${a*b}");
  print("División: ${a/b}");
  print("División entera: ${a~/b}");
  print("Módulo: ${a%b}");

  //Operadores de asignacion

  double c = 5;
  int d = 10;
  print("Asignacion suma: ${c+=2}");
  print("Asignacion resta: ${c-=2}");
  print("Asignacion multiplicacion: ${c*=2}");
  print("Asignacion division: ${c/=2}");
  print("Asignacion division entera: ${d~/=3}");
  print("Asignacion modulo: ${d%=2}");

  //Asignacion si es null
  String? texto;
  texto ??= "Valor por defecto";
  print(texto);
  //texto ??= "Nuevo valor"; //No modifica el valor
  texto = "Nuevo valor";
  print(texto);

  //Incremento y decremento

  int num = 10;
  num++; 
  print("Incremento: $num");
  num--;
  print("Decremento: $num");

  int e = 5;
  int f = e++; //Post incremento
  print("El valor de f es $f, el valor de e es $e");
  int g = ++e; //Pre incremento
  print("El valor de g es $g, el valor de e es $e");

  //Operadores de comparacion
  int x = 10;
  int y = 20;
  print("Igualdad: ${x==y}");
  print("Distinto: ${x!=y}");
  print("Mayor que: ${x>y}");
  print("Menor que: ${x<y}");
  print("Mayor o igual que: ${x>=y}");
  print("Menor o igual que: ${x<=y}");

  //Operadores logicos
  bool p = true;
  bool q = false;

  print("AND lógico: ${p && q}");
  print("OR lógico: ${q || p}");
  print("NOT lógico: ${!p}");

  //Operador de cascada ..
  //Sin cascada
  Persona persona = Persona();
  persona.nombre = "Angel";
  persona.edad = 22;
  persona.mostrarInformacion();

  //Con cascada
  Persona persona1 = Persona()
  ..nombre = "Pepe"
  ..edad = 50
  ..mostrarInformacion();

  //Operador condicional (ternario)
  int edad = 22;
  String mensaje = (edad >= 18) ? "Adulto" : "Menor de edad";
  print("Mensaje: $mensaje");

  //Operador de acceso seguro ??
  String? nombre;
  //nombre = "Patito";
  String nombreFinal = nombre ?? "Invitado";
  print("Nombre final: $nombreFinal");

  //Operadores de tipo. is y is!
  var valor = 42;
  if(valor is int){
    print("Es un entero");
  } else {
    print("No es un entero");
  }

  if(valor is! String) {
    print("No es una cadena de caracteres");
  }

  //Como insertar datos por consola
  stdout.writeln("=== Entrada por consola ===");
  stdout.write("Ingrese su nombre: ");
  String? nombreUsuario = stdin.readLineSync() ?? "Invitado";
  print("Bienvenido: $nombreUsuario");

  //Ejemplo de consola que solicita dos numeros y devuelve la suma
  stdout.write("Inserte el primer numero: ");
  String? numero1 = stdin.readLineSync();

  stdout.write("Inserte el segundo numero: ");
  String? numero2 = stdin.readLineSync();

  double num1 = double.tryParse(numero1!) ?? 0.0;
  double num2 = double.tryParse(numero2!) ?? 0.0;
  //double num3 = double.parse(numero1);

  stdout.write('''
Diga que operacion quiere hacer: 
1. Suma
2. Resta
3. Multiplicacion
4. Division
''');
  String operador = stdin.readLineSync() ?? "";
  String operadorMinusculas = operador.toLowerCase();
  switch (operadorMinusculas) {
    case "suma":
      print("Suma: $numero1 + $numero2 = ${num1 + num2}");
      break;
    case "resta":
      print("Resta: $numero1 - $numero2 = ${num1 - num2}");
      break;
    case "multiplicacion":
      print("Resta: $numero1 X $numero2 = ${num1 * num2}");
      break;
    case "Division":
      print("Resta: $numero1 / $numero2 = ${num1 / num2}");
      break;
    default:
      print("Opcion no valida");
      break;
  }

  //Diferencia entre parsear y casting
  dynamic valor3 = 42;
  int numero3 = valor3 as int;
  print("numero3: $numero3");
}

class Persona {
  String nombre = "";
  int edad = 0;

  void mostrarInformacion() {
    print("Nombre: $nombre, Edad: $edad");
  }
}