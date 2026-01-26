//Funcion con retorno dinamico
import 'dart:math';

dartSludar() {
  print("Hola desde una funcion");
  print("Soy ${dartSludar.runtimeType}");
}

//funcion con parametros sin retorno
void mostrarSuma(num a, num b) {
  print("La suma de $a y $b es: ${a+b}");
}

//Funciones con retorno
double areaCirculo(double radio) {
  return pi * (radio * radio);
}

//Funciones con parametros opcionales posicionales []
void saludar([String nombre = "amigo"]) {
  print("Hola $nombre");
}

void dibujarRectangulo(int ancho, [int alto = 10, String color = "Azul"]) {
  print("Rectangulo: $ancho * $alto, color $color");
}

//Funciones con parametros nombrados
void mostrarDatos({required String nombre, int edad = 0,required String apellidos, String ciudad = "Desconocido"}) {
  print("Nombre: $nombre, apellidos: $apellidos, edad: $edad, ciudad: $ciudad");
}

//Funcion flecha sintaxis corta para una sola operacion
int cuadrado(int x) => x * x; 

//Funcion anonima o lambda para mas de una expresion
Function triple = (int numero){
  return numero * 3;
};

int triple2(int numero) {
  return numero * 3;
}

//Funcion como parametro de otra funcion
void aplicarFuncion(int valor, int Function(int) funcion) {
  print("Resultado: ${funcion(valor)}");
}

//Funcion que devuelve otra funcion (closure)

void main() {
  dartSludar();
  mostrarSuma(5, 7);
  print("El area de un circulo con radio 20 es: ${areaCirculo(20.0).toStringAsFixed(3)}");
  saludar();
  saludar("Ángel");
  dibujarRectangulo(5);
  dibujarRectangulo(20, 30);
  dibujarRectangulo(30, 50, "Verde");
  mostrarDatos(nombre: "Ángel", apellidos: "Gallardo");
  mostrarDatos(edad: 22, apellidos: "Gallardo", nombre: "Ángel");
  mostrarDatos(apellidos: "Gallardo", ciudad: "Pinto", nombre: "Ángel");
  mostrarDatos(ciudad: "Pinto", nombre: "Ángel", apellidos: "Gallardo", edad: 22);
  print("Cuadrado de 10: ${cuadrado(10)}");
  print("Triple de 288: ${triple(288)}");
  aplicarFuncion(15, cuadrado);
  aplicarFuncion(1000, triple2);
}