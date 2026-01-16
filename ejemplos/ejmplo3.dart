void main() {
  //if simple
  int edad = 22;
  if(edad >= 18) {
    print("Es mayor de edad");
  } else {
    print("No es mayor de edad");
  }

  //if - else - if
  int nota = 8;

  if(nota >= 9) {
    print("sobresaliente");
  } else if(nota >= 7) {
    print("Notable");
  } else if(nota >= 5) {
    print("Notable");
  } else {
    print("Suspenso");
  }


  //For basico
  for(int i = 0; i < 5; i++) {
    print("Souy el nº $i");
  }

  for(int i = 0, j=0; i<=10; i++, j+=7) print(j);

  //while
  int contador = 1;
  while(contador <=10) {
    print(contador);
    ++contador;
  }

  //do while
  int num = 1;
  do {
    print(num);
    num--;
  } while(num > -5);

  //Imprimir pares del -20 al 20
  int valor = -20;
  while(true) {
    // if (valor%2 == 0) {
    //   print(valor);
    // }
    // valor++;
    if(valor > 20) {
      break;
    }
    if(valor %2 != 0) {valor++; continue;}
    print(valor);
  }

  int diasSemana = 1;

  if (diasSemana <= 0 && diasSemana >= 8) {
    print("Dian invalido");
  } else if(diasSemana <= 5) {
    print("Laborable");
  } else {
    print("Fin de semana");
  }

  String diaSemana = "Lunes";
  switch(diaSemana.toLowerCase()) {
    case "lunes" || "martes" || "miercoles" || "jueves" || "viernes":
      print("Dia laboral");
      break;
    case "sabado" ||"domingo":
      print("Dia no laboral");
      break;
    default:
    print("Valor no permitido");
    break;
  }
}