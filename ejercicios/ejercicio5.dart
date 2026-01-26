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
void main() {
  print("Ejercicio 1");
  ejercicio1();
}