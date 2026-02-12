import 'package:flutter/material.dart';

/// 📚 CONCEPTOS TEÓRICOS - Para explicar a los estudiantes
/// Este archivo contiene ejemplos visuales de los conceptos

class ConceptosFutureYAsincronia {
  // =========================================================================
  // 1️⃣ ¿QUÉ ES UN FUTURE?
  // =========================================================================
  
  // Un Future es una "promesa" de que algo sucederá en el futuro
  // Típicamente toma TIEMPO (descargar, procesar, esperar, etc)
  
  static void ejemplo1_FutureBasico() {
    // SIN FUTURE (BLOQUEANTE - malo):
    // print("Inicio");
    // Thread.sleep(5000);  // Espera 5 segundos ❌ CONGELA LA APP
    // print("Fin");
    
    // CON FUTURE (NO BLOQUEANTE - bueno):
    print("Inicio");
    
    Future.delayed(Duration(seconds: 5)).then((_) {
      print("Fin");  // Esto ejecuta después del delay, pero la app no se congela ✅
    });
  }
  
  // =========================================================================
  // 2️⃣ ASYNC / AWAIT - Syntax sugar para Futures
  // =========================================================================
  
  static Future<String> descargarArchivo() async {
    // async = "esta función puede esperar cosas"
    // await = "espera hasta que se complete"
    
    print("Empezando descarga...");
    
    // Simula 3 segundos de descarga
    await Future.delayed(const Duration(seconds: 3));
    
    print("Descarga completada");
    return "archivo.pdf";  // Devuelve el resultado
  }
  
  // =========================================================================
  // 3️⃣ THEN - La forma antigua (sin async/await)
  // =========================================================================
  
  static void ejemplo3_Then() {
    descargarArchivo().then((archivo) {
      print("Recibí: $archivo");
    }).catchError((error) {
      print("Error: $error");
    });
  }
  
  // =========================================================================
  // 4️⃣ SECUENCIAL vs PARALELO
  // =========================================================================
  
  static Future<void> descargarDos_Secuencial() async {
    // SECUENCIAL: Espera a que uno termine, luego el otro
    // Tiempo total: 5 + 3 = 8 segundos ⏱️
    
    print("Descargando archivo 1...");
    await Future.delayed(const Duration(seconds: 5));
    print("✓ Archivo 1 completo");
    
    print("Descargando archivo 2...");
    await Future.delayed(const Duration(seconds: 3));
    print("✓ Archivo 2 completo");
  }
  
  static Future<void> descargarDos_Paralelo() async {
    // PARALELO: Ambos descargan AL MISMO TIEMPO
    // Tiempo total: MAX(5, 3) = 5 segundos ⏱️ (¡3 segundos más rápido!)
    
    print("Descargando ambos...");
    await Future.wait([
      Future.delayed(const Duration(seconds: 5)).then((_) => print("✓ Archivo 1")),
      Future.delayed(const Duration(seconds: 3)).then((_) => print("✓ Archivo 2")),
    ]);
    print("Ambos completos");
  }
  
  // =========================================================================
  // 5️⃣ MANEJO DE ERRORES
  // =========================================================================
  
  static Future<void> operacionQuePuedeFallar(bool debefallar) async {
    try {
      if (debefallar) {
        throw Exception("Simulé un error");
      }
      await Future.delayed(const Duration(seconds: 2));
      print("Éxito");
    } catch (e) {
      print("Capturé error: $e");
    }
  }
  
  // =========================================================================
  // 6️⃣ STREAM - Para datos que llegan continuamente
  // =========================================================================
  
  static Stream<int> contarHasta10() async* {
    // async* = genera un Stream
    // yield = emite un valor al Stream
    
    for (int i = 1; i <= 10; i++) {
      await Future.delayed(const Duration(seconds: 1));
      yield i;  // Emite el número
    }
  }
  
  // ¿Cómo usarlo?
  static void usarStream() {
    contarHasta10().listen((numero) {
      print("Recibí: $numero");  // Se ejecuta cada segundo
    });
  }
}

// =========================================================================
// 🎨 WIDGET EDUCATIVO PARA MOSTRAR VISUALMENTE
// =========================================================================

class VisualizadorConceptos extends StatefulWidget {
  const VisualizadorConceptos({Key? key}) : super(key: key);

  @override
  State<VisualizadorConceptos> createState() => _VisualizadorConceptosState();
}

class _VisualizadorConceptosState extends State<VisualizadorConceptos> {
  String log = "Esperando acciones...\n";
  
  void agregarLog(String texto) {
    setState(() {
      log += "→ $texto\n";
    });
  }
  
  void limpiarLog() {
    setState(() {
      log = "Esperando acciones...\n";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Comprende Futures y Async"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Botones para experimentar
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElevatedButton(
                  onPressed: () {
                    limpiarLog();
                    agregarLog("Iniciando tarea (2 segundos)...");
                    Future.delayed(const Duration(seconds: 2)).then((_) {
                      agregarLog("✓ ¡Completada! (la app NO se congeló)");
                    });
                  },
                  child: const Text("Future Simple"),
                ),
                ElevatedButton(
                  onPressed: () {
                    limpiarLog();
                    agregarLog("Descarga 1 (3 seg)");
                    agregarLog("Descarga 2 (2 seg)");
                    agregarLog("SECUENCIAL = 5 segundos");
                    
                    Future.delayed(const Duration(seconds: 3)).then((_) {
                      agregarLog("✓ Descarga 1 completa");
                      return Future.delayed(const Duration(seconds: 2));
                    }).then((_) {
                      agregarLog("✓ Descarga 2 completa (5 seg total)");
                    });
                  },
                  child: const Text("Modo Secuencial"),
                ),
                ElevatedButton(
                  onPressed: () {
                    limpiarLog();
                    agregarLog("Descarga 1 (3 seg) ⬇️");
                    agregarLog("Descarga 2 (2 seg) ⬇️");
                    agregarLog("PARALELO = 3 segundos");
                    
                    Future.wait([
                      Future.delayed(const Duration(seconds: 3)).then((_) {
                        agregarLog("✓ Descarga 1 completa");
                      }),
                      Future.delayed(const Duration(seconds: 2)).then((_) {
                        agregarLog("✓ Descarga 2 completa");
                      }),
                    ]).then((_) {
                      agregarLog("✓ TODO completo (solo 3 seg)");
                    });
                  },
                  child: const Text("Modo Paralelo"),
                ),
                ElevatedButton(
                  onPressed: () {
                    limpiarLog();
                    agregarLog("Abriendo diálogo de error...");
                    Future.delayed(const Duration(seconds: 1)).then((_) {
                      throw Exception("Error simulado");
                    }).catchError((error) {
                      agregarLog("✓ Capturé el error: $error");
                    });
                  },
                  child: const Text("Manejo Errores"),
                ),
                ElevatedButton(
                  onPressed: () {
                    limpiarLog();
                    agregarLog("Emitiendo un Stream (5 valores)...");
                    
                    Stream.periodic(const Duration(seconds: 1), (int count) => count + 1)
                        .take(5)
                        .listen((value) {
                      agregarLog("📤 Stream emitió: $value");
                    }).onDone(() {
                      agregarLog("✓ Stream completado");
                    });
                  },
                  child: const Text("Stream Periódico"),
                ),
              ],
            ),
            
            const SizedBox(height: 20),
            
            // Área de log
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey[900],
                ),
                child: SingleChildScrollView(
                  child: Text(
                    log,
                    style: const TextStyle(
                      color: Colors.green,
                      fontFamily: 'Courier',
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 10),
            
            ElevatedButton.icon(
              onPressed: limpiarLog,
              icon: const Icon(Icons.clear),
              label: const Text("Limpiar Log"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
