class Persona {
  String nombre;
  int edad;

  Persona(this.nombre, this.edad);

  void saludar() {
    print("Hola, me llamo $nombre y tengo $edad años");
  }

  String presentacion() {
    return "$nombre ($edad años)";
  }
}

//Clase sin constructor
class alumno{
  String? nombre;
  String? apellidos;

  void saludar() {
    print("Hola, me llamo $nombre $apellidos");
  }
}

//Constructores con parametros opcionales
class Estudiante{
  String nombre;
  int edad;
  String? especialidad;
  double? promedio;

  Estudiante(this.nombre, this.edad, [this.especialidad, this.promedio = 0]);
  String info() {
    String esp = especialidad ?? "No definida";
    return "$nombre - Edad: $edad - Especialidad: $esp - Promedio: $promedio";
  }

  //Metodo toString()
  // @override // no es obligatorio
  String toString() {
    return "$nombre, $edad, $especialidad, $promedio";
  }
}

//inicializacion y valores por defecto
class Producto{
  String nombre;
  double precio;
  int stock = 0;
  bool disponoble = false;
  List<String> categorias = [];

  Producto(this.nombre, this.precio);

  void agregarStock(int cantidad) {
    stock += cantidad;
    if(stock > 0) disponoble = true;
  }

  void reducirStock(int stock) {
    this.stock -= stock;
    if(this.stock <= 0) disponoble = true;
  }

  String toString() {
    return "$nombre, $precio, $stock, $disponoble, $categorias";
  }
}

//Composicion de objetos
class Motor {
  String tipo;
  double cilindrada;
  int potencia;

  Motor(this.tipo, this.cilindrada, this.potencia);

  String info() => '$tipo - $cilindrada cc - $potencia';
}

class Conductor {
  String nombre;
  int edad;
  String licencia;

  Conductor(this.nombre, this.edad, this.licencia);

  String info() => "$nombre, $edad, $licencia";
}

class Auto {
  String marca;
  String modelo;
  Motor motor;
  Conductor? conductor;

  Auto(this.marca, this.modelo, this.motor, [this.conductor]);

  void mostrarDetalles() {
    print("Auto: $marca, $modelo");
    print("Motor: ${motor.info()}");
    if(conductor != null) {
      print("Conductor: ${conductor!.info()}");
    }
  }

  void asignarConductor(Conductor c) {
    conductor = c;
    print("Conductor asignado ${c.nombre}");
  }
} 

void main() {
  var persona1 = Persona("Ángel", 22);
  print("${persona1.presentacion()}");

  var estudiante1 = Estudiante("Ángel", 22);
  print(estudiante1.info());

  Producto producto1 = Producto("Telefono", 50.0);
  producto1.agregarStock(20);
  print(producto1.toString());
}