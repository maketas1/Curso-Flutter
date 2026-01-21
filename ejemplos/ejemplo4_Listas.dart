import 'dart:math';

void main() {
  //Listas pueden ser de longitud fijas o dinamicas
  var listaFija = List<int>.filled(3, 0, growable: true); //por defecto es falso, si se pone en true la lista puede crecer
  var asientos = List<String>.filled(40, "L");
  print(listaFija);
  listaFija[0] = 15;
  listaFija[2] = 17;
  listaFija.add(45);
  print(asientos);

  print(listaFija.first);
  print(listaFija.last);

  //Listas dinamicas
  var listaDinamica = <String>["Lunes", "Martes"];
  List<int> listaDinamica1 = [];
  List lista3 = [];
  var lista4 = [4, 7.0, "", null];
  print(listaDinamica);
  print(listaDinamica1);
  print("Lista3 es de tipo ${lista3.runtimeType}");
  print("Lista4 es de tipo ${lista4.runtimeType}");
  lista4.add(DateTime.april);

  //Metodos de consultas de listas
  var numeros = [1, 2, 3, 4, 5, 3];
  //isEmpty - verifica si esta vacia o no
  print("¿Esta vacia? ${numeros.isEmpty}");
  print("¿Tiene elementos? ${numeros.isNotEmpty}");

  //Contains() comprueba si un elemento existe
  print("¿contiene el numero 13? ${numeros.contains(13)}");

  //indexOf me devuelve el indice del primer elemento que encuentra
  print("Indice del primer numero 3? ${numeros.indexOf(3)}");
  print("Indice del ultimo numero 3? ${numeros.lastIndexOf(3)}"); //            posicion desde la que empieza a contar
  print("Indice del segundo numero 3? ${numeros.indexWhere((item) => item == 3, 3)}");

  //Matodo de modificacion
  var lista10 = <int>[10, 20, 30, 40];
  lista10.add(50);
  //Añadir varios elementos
  lista10.addAll([60, 70]);
  print(lista10);
  //insertar en una posicion especifica
  lista10.insert(2, 15);
  print(lista10);
  //insertar varios elementos en una posicion especifica
  lista10.insertAll(1, [11, 12,10,  13, 30, 40, 50]);
  print(lista10);

  //eliminar el primer elemento. remove
  lista10.remove(10);
  lista10.removeAt(10);
  print(lista10);

  //Eliminar el ultimo elemento
  var ultimo = lista10.removeLast();
  print("Ultimo elemento eliminado de la lista $ultimo");
  print(lista10);

  //Eliminar un rango. El ultimo indice no esta incluido
  lista10.removeRange(1, 3); //Elimina los datos del indice 1 y 2
  print(lista10);

  //Metodos de transformacion
  //map() devuelve una lista, trasformando cada uno de los elementos
  var valores = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  var duplicados = valores.map((x) => x * 2).toList();
  print("Originales: $valores");
  print("Duplicados $duplicados");

  //where() devuelve un iterable con un filtro
  var pares = valores.where((x) => x % 2 == 0).toList();
  print("Pares: $pares");

  //forEach(). iterar sobre elementos
  List<int> duplicados2 = [];
  List<int> pares2 = [];
  valores.forEach((item){
    duplicados2.add(item * 2);
    if(item % 2 == 0) {
      pares2.add(item);
    }
  });
  print("Duplicados2: $duplicados2");
  print("Pares2: $pares2");

  //Join(). convierte a un string con separador
  var texto = pares2.join('-');
  print("Pares separados por un -: $texto");

  //sort() ordena una lista de forma ascendente
  var desordenado = [3, 1, 5, 4, 1, 9, -20];
  // var ordenada = desordenado.sort();
  // print(ordenada);
  print(desordenado..add(-40)..sort()); //Realizando acciones en cascada ..

  //Reverse. invertir el orden. Devuelve un iterable con los elementos invertidos
  var invertida = [1, 2, 3];
  print(invertida);
  var invertida1 = invertida.reversed.toList();
  print(invertida1);

  //subList() - Obtiene una sublista
  valores = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  var subLista = valores.sublist(5).toList(); //Desde el indice 5 (valor 6) al final
  print(subLista);
  var subLista2 = valores.sublist(1, 4); //Ultimo no incluido
  print(subLista2);

  //Eliminar duplicados en una lista
  var conDuplicados = [1, 2, 2, 3, 3, 4, 5];
  print("Con duplicados: $conDuplicados");
  var sinDuplicados = conDuplicados.toSet().toList();
  print("Sin duplicados: $sinDuplicados");

  //Expand(), Expande cada elemento
  valores = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

  var expandida1 = valores.expand((x) => [x, x]).toList();
  var expandida2 = valores.expand((x) => [x, x*2]).toList();
  var expandida3 = valores.expand((x) => [x, '$x']).toList();
  print("Expandida: $expandida1, Tipo: ${expandida1.runtimeType}");
  print("Expandida2: $expandida2, Tipo: ${expandida2.runtimeType}");
  print("Expandida3: $expandida3, Tipo: ${expandida3.runtimeType}");

  //Lista de listas (array bidimensional)
  List<List<String>> asientos1 = [
    ["L", "L", "O", "L", "L", "L", "O", "L"],
    ["L", "L", "L", "L", "L", "L", "L", "L"],
    ["O", "O", "L", "L", "L", "L", "L", "L"],
    ["L", "L", "L", "O", "O", "L", "L", "L"],
    ["L", "L", "L", "L", "L", "L", "L", "L"],
  ];
  print(asientos1);
  print(asientos1.expand((item) => item).toList());//Aplana el array bidimensional en uno simple

  //reduce(), nos devuelve un valor recorriendo una listacon una funcion
  valores = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

  int sumaTotal = valores.reduce((acumulador, item){
    return acumulador + item;
  });
  int numerosPares = [0, ...valores].reduce((acumulador, item){
    if(item % 2 == 0) {
      acumulador++;
    }
    return acumulador;
  });
  int numerosPares1 = valores.fold(0, (acumulador, item){
    if(item % 2 == 0) {
      acumulador++;
    }
    return acumulador;
  });
  print("La suma total es: $sumaTotal");
  print("Suma numeros pares: $numerosPares");
  print("Suma numeros pares 0: $numerosPares1");

  //Metodos de busqueda
  valores = [1, 2, 3, 4, 5, 6, 7, 8, -9, 10];

  //Primer elemento que cumple que una condicion firstWhere()
  int primeraMayor = valores.firstWhere((x) => x<5);
  print(primeraMayor);

  //ultimo elemento que cumple con la condicion
  int ultimoMayor = valores.lastWhere((x) => x<5);
  print(ultimoMayor);

  //Algun elemento cumple la condicion
  var hayMayor = valores.any((x)=> x<15);
  print(hayMayor);

  //Todos los elementos cumplen la condicion
  var cumplenLaCondicion = valores.every((x) => x >= 0);
  print(cumplenLaCondicion);

  //Formas de crear listas

  //Lista fija en la cantidad de item
  var list1 = List.filled(10, 1);
  print(list1);

  //Generar lista con una funcion
  //Crea una lista de 20 elementos aleatorios del 1 al 100
  var list2 = List<int>.generate(20, (i)=> i = Random().nextInt(100)+1, growable: false);
  print(list2);

  //Listas con el operador spread (...)
  var list3a = [1, 2, 3];
  var list3b = [0, ...list3a, 4, 5];
  var list3c = [0, list3a, 4, 5];
  print("Lista3b: $list3b, Tipo:, ${list3b.runtimeType}");
  print("Lista3c: $list3c, Tipo:, ${list3c.runtimeType}");

  //Listas con spread operador condicional
  bool incluir = true;
  var list4 = [1, 2, if(incluir) 3, 4];

  print(list4);

  //Usar extensiones en Listas
  List<String> lenguajes = ["Python", "Dart", "go", "C++"];
  print("La lista contiene Go? ${lenguajes.contains("Go")}");
  print("La lista contiene Go? ${lenguajes.containsIgnoreCase("Go")}");

  valores = [1, 2, 3, 4, 5, 18, -9, 10, 5, 12, 14];
  print("Where + reduce ${valores.where((x) => x%2 ==0).reduce((x,y)=>x+1)}");
}

extension StringListExtension on List<String> {
  bool containsIgnoreCase(String value) {
    return any((objeto) => objeto.toLowerCase() == value.toLowerCase());
  }
}