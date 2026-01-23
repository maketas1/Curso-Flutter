void main() {
  String texto1 = "hola mundo 2026-123-32 Á";
  RegExp regExp1 = RegExp(r"\d+");
  bool contieneNumero = regExp1.hasMatch(texto1);
  print("Contiene numero? $contieneNumero");
  RegExp regExp2 = RegExp(r"\d{3,}");
  Iterable<Match> coincidencias = regExp2.allMatches(texto1);
  print("Cantidad de numeros ${coincidencias.length}");
  for(var match in coincidencias) {
    print(match.group(0));
  }
  String texto3 = "Correo: manolito@gafotas.com";
  String oculto = texto3.replaceAll(RegExp(r"\w+@\w+\.\w+"), "[oculto]");
  print(oculto);
  String email = "pepe.manolito@gafotas.com";
  RegExp regExpEmail = RegExp(r"^[\w\.-]+@[\w\.-]+\.\w+$");
  if(regExpEmail.hasMatch(email)) {
    print("Email valido");
  } else {
    print("Email no valido");
  }
  String texto4 = texto1.replaceAll(RegExp(r"[^a-zA-Z0-9ñÑáéíóúÁÉÍÓÚ]"), " ");
  print(texto4);
}