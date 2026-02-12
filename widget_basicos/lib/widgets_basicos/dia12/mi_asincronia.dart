import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:async';

/// ════════════════════════════════════════════════════════════════════════════
/// GUÍA EDUCATIVA: ASINCRONÍA EN DART/FLUTTER
/// ════════════════════════════════════════════════════════════════════════════
/// 
/// CONCEPTOS CLAVE:
/// 📌 Future    → Una promesa de un valor que llegará en el futuro
/// 📌 Stream    → Un flujo continuo de eventos/datos a lo largo del tiempo
/// 📌 async/await → Sintaxis para trabajar con operaciones asincrónicas
/// 📌 Relación  → Los Streams son como múltiples Futures encadenados
///
/// ════════════════════════════════════════════════════════════════════════════

void main() {
  runApp(const MiAplicacionAsincronia());
}

class MiAplicacionAsincronia extends StatelessWidget {
  const MiAplicacionAsincronia({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Asincronía en Dart',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const PantallaAsincroniaEducativa(),
    );
  }
}

class PantallaAsincroniaEducativa extends StatefulWidget {
  const PantallaAsincroniaEducativa({super.key});

  @override
  State<PantallaAsincroniaEducativa> createState() =>
      _PantallaAsincroniaEducativaState();
}

class _PantallaAsincroniaEducativaState
    extends State<PantallaAsincroniaEducativa> {
  String mensajeActual = '👋 Selecciona un ejemplo arriba';
  bool cargando = false;
  int contadorStream = 0;
  StreamSubscription<int>? suscripcionStream;

  @override
  void dispose() {
    suscripcionStream?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🚀 Asincronía: Future vs Stream'),
        backgroundColor: Colors.blue[700],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SECCIÓN 1: FUTURE
              _construirSeccionFuture(),
              const SizedBox(height: 24),

              // SECCIÓN 2: STREAM
              _construirSeccionStream(),
              const SizedBox(height: 24),

              // SECCIÓN 3: ASYNC/AWAIT
              _construirSeccionAsyncAwait(),
              const SizedBox(height: 24),

              // SECCIÓN 4: RESULTADO
              _construirSectionResultado(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _construirSeccionFuture() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '📌 #1 - FUTURE: Una promesa de un valor futuro',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 12),
            _construirCodigoEjemplo(
              titulo: '¿QUÉ ES UN FUTURE?',
              explicacion:
                  'Un Future es como una promesa: "Te daré un resultado cuando esté listo".\n\n'
                  'Es UNA SOLA entrega de datos en el futuro.\n\n'
                  'ANALOGÍA: El profesor te dice "tu examen estará listo mañana"',
              codigo: '''Future<String> descargarDatos() {
  return Future.delayed(Duration(seconds: 2), () {
    return "✅ Datos descargados!";
  });
}''',
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: _ejemploFutureBasico,
              icon: const Icon(Icons.cloud_download),
              label: const Text('Ejecutar: Descargar 1 dato'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.withAlpha(50),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _construirSeccionStream() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '📌 #2 - STREAM: Un flujo continuo de datos',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 12),
            _construirCodigoEjemplo(
              titulo: '¿QUÉ ES UN STREAM?',
              explicacion:
                  'Un Stream es como un río: MÚLTIPLES datos fluyen continuamente.\n\n'
                  'Es VARIOS datos a lo largo del tiempo.\n\n'
                  'ANALOGÍA: Tu teléfono recibiendo mensajes de WhatsApp uno tras otro.\n'
                  'No esperas un mensaje, esperas muchos.',
              codigo: '''Stream<int> contar() async* {
  for (int i = 1; i <= 5; i++) {
    await Future.delayed(Duration(seconds: 1));
    yield i;  // Emite un valor al stream
  }
}''',
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: _ejemploStreamBasico,
              icon: const Icon(Icons.waves),
              label: const Text('Ejecutar: Recibir 5 datos (Stream)'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.withAlpha(50),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _construirSeccionAsyncAwait() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '📌 #3 - ASYNC/AWAIT: Sintaxis clara para la asincronía',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            ),
            const SizedBox(height: 12),
            _construirCodigoEjemplo(
              titulo: '¿QUÉ ES ASYNC/AWAIT?',
              explicacion:
                  '• async: Marca una función como asincrónica\n'
                  '• await: Espera a que un Future se complete\n\n'
                  'VENTAJA: El código se lee como si fuera sincrónico\n'
                  '(de arriba a abajo), pero funciona de forma asincrónica.',
              codigo: '''Future<void> procesarDatos() async {
  print("Esperando...");
  String resultado = await descargarDatos();
  print(resultado);  // Se ejecuta después de 2 segundos
}''',
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: _ejemploAsyncAwait,
              icon: const Icon(Icons.schedule),
              label: const Text('Ejecutar: Await con Future'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple.withAlpha(50),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _construirSectionResultado() {
    return Card(
      color: Colors.grey[100],
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '📊 RESULTADO:',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Center(
              child: cargando
                  ? const CircularProgressIndicator()
                  : Text(
                      mensajeActual,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
            ),
            const SizedBox(height: 16),
            _construirTablaNombreclatura(),
          ],
        ),
      ),
    );
  }

  Widget _construirCodigoEjemplo({
    required String titulo,
    required String explicacion,
    required String codigo,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titulo,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          explicacion,
          style: const TextStyle(
            fontSize: 13,
            height: 1.6,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey[700]!),
          ),
          child: Text(
            codigo,
            style: const TextStyle(
              fontFamily: 'Courier',
              fontSize: 11,
              color: Colors.greenAccent,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }

  Widget _construirTablaNombreclatura() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '🎯 CUADRO COMPARATIVO:',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Table(
          border: TableBorder.all(color: Colors.grey[400]!),
          children: [
            TableRow(
              decoration: BoxDecoration(color: Colors.blue[100]),
              children: const [
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'CONCEPTO',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'ENTREGA DATOS',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'USE CUANDO...',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            _construirFilaTabla(
              'Future',
              'UNA VEZ',
              'Descargas, consultas BD',
            ),
            _construirFilaTabla(
              'Stream',
              'MÚLTIPLES',
              'Chat, sensores, eventos',
            ),
            _construirFilaTabla(
              'async/await',
              'Sintaxis',
              'Readable + Futures',
            ),
          ],
        ),
      ],
    );
  }

  TableRow _construirFilaTabla(String concepto, String entrega, String cuando) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            concepto,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text(entrega),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text(cuando, style: const TextStyle(fontSize: 12)),
        ),
      ],
    );
  }

  // ════════════════════════════════════════════════════════════════════════
  // IMPLEMENTACIÓN DE EJEMPLOS
  // ════════════════════════════════════════════════════════════════════════

  /// EJEMPLO 1: FUTURE BÁSICO
  /// Un Future es una promesa que se completa UNA SOLA VEZ
  Future<void> _ejemploFutureBasico() async {
    setState(() {
      cargando = true;
      mensajeActual = '⏳ Descargando datos (espera 2 segundos)...';
    });
    print(mensajeActual);

    // Simular descarga que tarda 2 segundos
    final resultado = await Future.delayed(
      const Duration(seconds: 2),
      () => '✅ Datos recibidos: Juan (20 años) - Carrera de Informática',
    );

    setState(() {
      cargando = false;
      mensajeActual = resultado;
    });
    print(mensajeActual);
  }

  /// EJEMPLO 2: STREAM BÁSICO
  /// Un Stream emite MÚLTIPLES valores a lo largo del tiempo
  Future<void> _ejemploStreamBasico() async {
    // Cancelar suscripción anterior si existe
    await suscripcionStream?.cancel();

    setState(() {
      cargando = true;
      contadorStream = 0;
      mensajeActual = '📡 Iniciando Stream (recibiremos 5 valores)...';
    });

    // Crear un Stream que emite números del 1 al 5
    final stream = _crearStreamNumeros();

    // Suscribirse al Stream
    suscripcionStream = stream.listen(
      (numero) {
        // Se ejecuta cada vez que el Stream emite un valor
        setState(() {
          contadorStream = numero;
          mensajeActual = '📊 Stream emitió: ${numero}\n'
              'El Stream sigue enviando datos...';
        });
      },
      onDone: () {
        // Se ejecuta cuando el Stream termina
        setState(() {
          cargando = false;
          mensajeActual = '✅ Stream completado!\n'
              'Recibi un total de $contadorStream valores';
        });
      },
      onError: (error) {
        setState(() {
          cargando = false;
          mensajeActual = '❌ Error en Stream: $error';
        });
      },
    );
  }

  /// EJEMPLO 3: ASYNC/AWAIT
  /// Hace que el código asincrónico se vea y se comporte de forma sincrónica
  Future<void> _ejemploAsyncAwait() async {
    setState(() {
      cargando = true;
      mensajeActual = '📋 Paso 1: Obteniendo usuario...';
    });

    print(mensajeActual);

    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      mensajeActual = '📋 Paso 2: Obteniendo calificaciones...';
    });

    print(mensajeActual);
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      mensajeActual = '📋 Paso 3: Calculando promedio...';
    });

    print(mensajeActual);
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      cargando = false;
      mensajeActual = '✅ PROCESO COMPLETADO\n\n'
          'Usuario: María García\n'
          'Calificaciones: 9.5, 8.2, 9.8\n'
          'Promedio: 9.17\n\n'
          '⚡ Nota: Vimos 3 pasos secuenciales gracias a await!';
    });
    print(mensajeActual);
  }

  /// FUNCIÓN QUE CREA UN STREAM
  /// async* indica que es una función generadora que crea un Stream
  Stream<int> _crearStreamNumeros() async* {
    for (int i = 1; i <= 5; i++) {
      // Esperar 1 segundo entre emisiones
      await Future.delayed(const Duration(seconds: 1));

      // yield emite un valor al Stream
      yield i;

      print('Stream emitió: $i');
    }
    print('Stream completado');
  }
}

// ════════════════════════════════════════════════════════════════════════════
// EJEMPLOS AVANZADOS PARA REFERENCIA
// ════════════════════════════════════════════════════════════════════════════

/// EJEMPLO: LA RELACIÓN ENTRE FUTURE Y STREAM
/// 
/// Un Stream es como muchos Futures encadenados:
/// 
/// Future:  [        Datos        ]
/// 
/// Stream:  [Dato][Dato][Dato][Dato]...
/// 
/// CÓDIGO EDUCATIVO:

class EjemplosAvanzados {
  /// FUTURE: Esperar un evento
  static Future<String> obtenerUsuario() async {
    await Future.delayed(const Duration(seconds: 2));
    log("Mensaje desde log()");
    return 'Juan (20 años)';
  }

  /// STREAM: Múltiples eventos a lo largo del tiempo
  /// Uso: Chat, ubicación GPS, sensor de acelerómetro
  static Stream<String> recibirMensajes() async* {
    final mensajes = ['Hola!', '¿Qué tal?', 'Vamos al cine?'];

    for (String mensaje in mensajes) {
      yield '${DateTime.now().hour}:${DateTime.now().minute} - $mensaje';
      await Future.delayed(const Duration(seconds: 2));
    }
  }

  /// ASYNC/AWAIT: Código limpio y legible
  static void procesarMultiplesFutures() async {
    print('Inicio');

    // await hace que espere el resultado del Future
    String usuario = await obtenerUsuario();
    print('Usuario obtenido: $usuario');

    print('Fin');
  }

  /// SUBSCRIBIRSE A UN STREAM
  static void escucharMensajes() {
    final stream = recibirMensajes();

    // listen() se suscribe al Stream
    stream.listen(
      (mensaje) => print(mensaje), // Cada vez que emite
      onDone: () => print('Chat cerrado'), // Cuando termina
      onError: (error) => print('Error: $error'), // Si hay error
    );
  }
}

/// ════════════════════════════════════════════════════════════════════════════
/// CASOS DE USO REALES
/// ════════════════════════════════════════════════════════════════════════════
///
/// 🎯 USA FUTURE CUANDO:
/// ✓ Descargar datos de internet (1 sola vez)
/// ✓ Consultar base de datos
/// ✓ Esperar autenticación
/// ✓ Leer un archivo
///
/// 🎯 USA STREAM CUANDO:
/// ✓ Chat en tiempo real (múltiples mensajes)
/// ✓ Ubicación GPS (actualizar posición constantemente)
/// ✓ Sensor de micrófono (recibir datos continuamente)
/// ✓ Notificaciones push (llegan múltiples)
/// ✓ Stock market (precios que cambian constantemente)
///
/// 🎯 USA ASYNC/AWAIT CUANDO:
/// ✓ Trabajas con Futures
/// ✓ Necesitas código legible y limpio
/// ✓ Necesitas ejecutar operaciones secuencialmente
///
