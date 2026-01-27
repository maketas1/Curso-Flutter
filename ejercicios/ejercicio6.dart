import '../ejemplos/ejemplo7Funciones.dart';

Function aumentar = (Map<String, dynamic> contador) {
  return () { 
    contador["n"] += 1;
    int suma = contador["n"];
    return suma;
  };
};

Function decremento = (Map<String, dynamic> contador) {
  return () { 
    contador["n"] -= 1;
    int resta = contador["n"];
    return resta;
  };
};

Function obtenerValor = (Map<String, dynamic> contador) {
  return () { 
    return contador["n"];
  };
};

Function reiniciar = (Map<String, dynamic> contador) {
  return () { 
    contador["n"] = 0;
    return contador["n"];
  };
};

Function sumar = (Map<String, dynamic> contador) {
  return (int n) { 
    contador["n"] += n;
    var suma = contador["n"];
    return suma;
  };
};

Map<String, dynamic> crearContador () {
  Map<String, dynamic> contador = {};
  contador["n"] = 0;
  contador["aumentar"] = aumentar(contador);
  contador["decremento"] = decremento(contador);
  contador["obtenerValor"] = obtenerValor(contador);
  contador["reiniciar"] = reiniciar(contador);
  contador["sumar"] = sumar(contador);
  return contador;
}

Map<String, Function> crearContardor1() {
  int contador = 0;
  return {
    "incrementar" : () => ++contador,
    "decrementar" : () => --contador,
    "obtenerValor" : () => contador,
    "reiniciar" : () {
      contador = 0;
      print("Contador reiniciado a 0");
    },
    "sumar" : (int n) => contador+=n,
    "restar" : (int n) => contador-=n
  };
}

void ejercicio1() {
  var map = crearContador();
  print(map["aumentar"]());
  print(map["aumentar"]());
  print(map["decremento"]());
  print(map["reiniciar"]());
  print(map["sumar"](5));
}

//Funciones auxiliares
bool esPar(int n) => n% 2 == 0;
int duplicar(int n) => n * 2;
int sumarTodos(int a, int b) => a + b;
int alCuadrado(int n) => n * n;
bool esMultiplo(int n, int d) => n % d == 0;

List<int> aplicarOperacion(List<int> lista, int Function(int) operacion) {
  // List resultado = [];
  // for(var elemento in lista) {
  //   resultado.add(operacion(elemento));
  // }
  // return resultado;
  return lista.map(operacion).toList();
}

List<int> filtrarPor(List<int> lista, bool Function(int) condicion) {
  List<int> resultado = [];
  for(var elemento in lista) {
    if(condicion(elemento)) resultado.add(elemento);
  }
  //return resultado;
  return lista.where(condicion).toList();
}

void ejercicio2() {
  var numeros = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ];
  print(numeros);
  print("Duplicados: ${aplicarOperacion(numeros, duplicar)}");
  print("Cuadrados: ${aplicarOperacion(numeros, cuadrado)}");
  print("Par: ${filtrarPor(numeros, esPar)}");
}

void main() {
  print("Ejercicio 1");
  ejercicio1();

  print("Ejercicio 2");
  ejercicio2();
}