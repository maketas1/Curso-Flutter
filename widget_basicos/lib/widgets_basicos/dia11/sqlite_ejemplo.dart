import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

/// ════════════════════════════════════════════════════════════════════════════
/// SQLITE - BASE DE DATOS RELACIONAL
/// ════════════════════════════════════════════════════════════════════════════
///
/// SQLite es una base de datos relacional embebida, perfecta para
/// aplicaciones Flutter complejas con múltiples tablas y relaciones.
///
/// ✓ CARACTERÍSTICAS:
///   • Base de datos relacional completa
///   • Soporte para queries complejas
///   • Transacciones
///   • Mejor para datos estructurados
///   • Máximo: Varios GB de datos
///
/// ✓ CASOS DE USO:
///   • Apps con múltiples tablas relacionadas
///   • Queries complejas (JOINs, GROUP BY, etc.)
///   • Transacciones
///   • Datos altamente estructurados
///   • Sincronización con servidor
///
/// ✓ COMPARACIÓN CON OTROS:
///   • vs SharedPreferences: SQLite para datos complejos
///   • vs Hive: SQLite para queries complejas
///   • vs Archivos: SQLite para acceso más rápido
/// ════════════════════════════════════════════════════════════════════════════

// ═══════════════════════════════════════════════════════════════════════════
// MODELOS DE DATOS
// ═══════════════════════════════════════════════════════════════════════════

/// Tabla de Estudiantes
class Estudiante {
  final int? id;
  final String nombre;
  final String email;
  final String carrera;
  final DateTime fechaIngreso;

  Estudiante({
    this.id,
    required this.nombre,
    required this.email,
    required this.carrera,
    required this.fechaIngreso,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'email': email,
      'carrera': carrera,
      'fechaIngreso': fechaIngreso.toIso8601String(),
    };
  }

  factory Estudiante.fromMap(Map<String, dynamic> map) {
    return Estudiante(
      id: map['id'],
      nombre: map['nombre'] ?? '',
      email: map['email'] ?? '',
      carrera: map['carrera'] ?? '',
      fechaIngreso: DateTime.parse(
        map['fechaIngreso'] ?? DateTime.now().toIso8601String(),
      ),
    );
  }

  @override
  String toString() {
    return '''
    ═══════════════════════════════════════
    ESTUDIANTE: $nombre
    ═══════════════════════════════════════
    Email: $email
    Carrera: $carrera
    Ingreso: ${fechaIngreso.day}/${fechaIngreso.month}/${fechaIngreso.year}
    ═══════════════════════════════════════
    ''';
  }
}

/// Tabla de Calificaciones
class Calificacion {
  final int? id;
  final int estudianteId;
  final String asignatura;
  final double nota;
  final DateTime fecha;

  Calificacion({
    this.id,
    required this.estudianteId,
    required this.asignatura,
    required this.nota,
    required this.fecha,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'estudianteId': estudianteId,
      'asignatura': asignatura,
      'nota': nota,
      'fecha': fecha.toIso8601String(),
    };
  }

  factory Calificacion.fromMap(Map<String, dynamic> map) {
    return Calificacion(
      id: map['id'],
      estudianteId: map['estudianteId'] ?? 0,
      asignatura: map['asignatura'] ?? '',
      nota: (map['nota'] ?? 0).toInt() as double,
      fecha: DateTime.parse(
        map['fecha'] ?? DateTime.now().toIso8601String(),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// SERVICIO DE ALMACENAMIENTO CON SQLITE
// ═══════════════════════════════════════════════════════════════════════════

/// Servicio para gestionar la base de datos SQLite
class AlmacenamientoSQLite {
  static Database? _database;

  // ══════════════════════════════════════════════════════════════════════════
  // INICIALIZACIÓN Y SCHEMA
  // ══════════════════════════════════════════════════════════════════════════

  /// Obtener instancia de la base de datos
  static Future<Database> obtenerBD() async {
    if (_database != null) return _database!;
    _database = await _inicializarBD();
    return _database!;
  }

  /// Inicializar la base de datos y crear tablas
  static Future<Database> _inicializarBD() async {
    final String ruta = join(
      await getDatabasesPath(),
      'universidad.db',
    );

    return await openDatabase(
      ruta,
      version: 1,
      onCreate: (Database db, int version) async {
        // Crear tabla de Estudiantes
        await db.execute('''
          CREATE TABLE estudiantes(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nombre TEXT NOT NULL,
            email TEXT UNIQUE NOT NULL,
            carrera TEXT NOT NULL,
            fechaIngreso TEXT NOT NULL
          )
        ''');

        // Crear tabla de Calificaciones
        await db.execute('''
          CREATE TABLE calificaciones(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            estudianteId INTEGER NOT NULL,
            asignatura TEXT NOT NULL,
            nota REAL NOT NULL,
            fecha TEXT NOT NULL,
            FOREIGN KEY (estudianteId) REFERENCES estudiantes(id)
          )
        ''');

        print('✓ Tablas creadas');
      },
    );
  }

  // ══════════════════════════════════════════════════════════════════════════
  // OPERACIONES CRUD - ESTUDIANTES
  // ══════════════════════════════════════════════════════════════════════════

  /// Insertar estudiante
  static Future<int> agregarEstudiante(Estudiante estudiante) async {
    final db = await obtenerBD();
    int id = await db.insert('estudiantes', estudiante.toMap());
    print('✓ Estudiante agregado: ${estudiante.nombre}');
    return id;
  }

  /// Obtener estudiante por ID
  static Future<Estudiante?> obtenerEstudiante(int id) async {
    final db = await obtenerBD();
    final result = await db.query(
      'estudiantes',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (result.isEmpty) return null;
    return Estudiante.fromMap(result.first);
  }

  /// Obtener todos los estudiantes
  static Future<List<Estudiante>> obtenerTodosEstudiantes() async {
    final db = await obtenerBD();
    final result = await db.query('estudiantes');
    return result.map((map) => Estudiante.fromMap(map)).toList();
  }

  /// Actualizar estudiante
  static Future<void> actualizarEstudiante(Estudiante estudiante) async {
    final db = await obtenerBD();
    await db.update(
      'estudiantes',
      estudiante.toMap(),
      where: 'id = ?',
      whereArgs: [estudiante.id],
    );
    print('✓ Estudiante actualizado');
  }

  /// Eliminar estudiante
  static Future<void> eliminarEstudiante(int id) async {
    final db = await obtenerBD();
    // Primero eliminar sus calificaciones
    await db.delete(
      'calificaciones',
      where: 'estudianteId = ?',
      whereArgs: [id],
    );
    // Luego eliminar el estudiante
    await db.delete(
      'estudiantes',
      where: 'id = ?',
      whereArgs: [id],
    );
    print('✓ Estudiante eliminado');
  }

  // ══════════════════════════════════════════════════════════════════════════
  // OPERACIONES CRUD - CALIFICACIONES
  // ══════════════════════════════════════════════════════════════════════════

  /// Agregar calificación
  static Future<int> agregarCalificacion(Calificacion calificacion) async {
    final db = await obtenerBD();
    int id = await db.insert('calificaciones', calificacion.toMap());
    print('✓ Calificación agregada');
    return id;
  }

  /// Obtener calificaciones de un estudiante
  static Future<List<Map>> obtenerCalificacionesEstudiante(
    int estudianteId,
  ) async {
    final db = await obtenerBD();
    final result = await db.query(
      'calificaciones',
      where: 'estudianteId = ?',
      whereArgs: [estudianteId],
    );
    return result.map((map) => map as Map).toList();
  }

  /// Eliminar calificación
  static Future<void> eliminarCalificacion(int id) async {
    final db = await obtenerBD();
    await db.delete(
      'calificaciones',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // ══════════════════════════════════════════════════════════════════════════
  // QUERIES COMPLEJAS
  // ══════════════════════════════════════════════════════════════════════════

  /// Obtener promedio de un estudiante
  static Future<double> obtenerPromedio(int estudianteId) async {
    final db = await obtenerBD();
    final result = await db.rawQuery('''
      SELECT AVG(nota) as promedio FROM calificaciones
      WHERE estudianteId = ?
    ''', [estudianteId]);

    if (result.isNotEmpty) return 0.0;
    return (result.first['promedio'] as num?)?.toDouble() ?? 0.0;
  }

  /// Obtener estudiantes con promedio mayor a X
  static Future<List<Map>> obtenerEstudiantesConPromedioAlto(
    String minimo,
  ) async {
    final db = await obtenerBD();
    return await db.rawQuery('''
      SELECT e.*, AVG(c.nota) as promedio
      FROM estudiantes e
      LEFT JOIN calificaciones c ON e.id = c.estudianteId
      GROUP BY e.id
      HAVING promedio >= ?
    ''', [minimo]);
  }

  /// Obtener carrera con mayor promedio
  static Future<Map?> obtenerCarreraConMayorPromedio() async {
    final db = await obtenerBD();
    final result = await db.rawQuery('''
      SELECT e.carrera, AVG(c.nota) as promedio, COUNT(e.id) as total
      FROM estudiantes e
      LEFT JOIN calificaciones c ON e.id = c.estudianteId
      GROUP BY e.carrera
      ORDER BY promedio DESC
      LIMIT 1
    ''');

    if (result.isEmpty) return null;
    return result.first;
  }

  /// Limpiar base de datos
  static Future<void> limpiarBD() async {
    final db = await obtenerBD();
    await db.delete('calificaciones');
    await db.delete('estudiantes');
    print('✓ Base de datos limpiada');
  }

  /// Mostrar resumen
  static Future<void> mostrarResumen() async {
    final estudiantes = await obtenerTodosEstudiantes();
    final carrera = await obtenerCarreraConMayorPromedio();

    print('''
    ╔════════════════════════════════════════╗
    ║   RESUMEN DE BASE DE DATOS (SQLITE)    ║
    ╠════════════════════════════════════════╣
    ║ Total de estudiantes: ${estudiantes.length}
    ║ Carreras: ${estudiantes.map((e) => e.carrera).toSet().length}
    ║ Carrera con mayor promedio: ${carrera?['carrera'] ?? 'N/A'} (${carrera?['promedio']?.toStringAsFixed(2) ?? 'N/A'})
    ╚════════════════════════════════════════╝
    ''');
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// INTERFAZ DE USUARIO
// ═══════════════════════════════════════════════════════════════════════════

class PantallaSQLite extends StatefulWidget {
  const PantallaSQLite({super.key});

  @override
  State<PantallaSQLite> createState() => _PantallaSQLiteState();
}

class _PantallaSQLiteState extends State<PantallaSQLite> {
  List<Estudiante> estudiantes = [];
  bool cargando = true;

  @override
  void initState() {
    super.initState();
    cargarEstudiantes();
  }

  void cargarEstudiantes() async {
    estudiantes = await AlmacenamientoSQLite.obtenerTodosEstudiantes();
    setState(() {
      cargando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (cargando) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('SQLite - Base de datos relacional'),
        backgroundColor: Colors.green[700],
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Chip(
                label: Text('${estudiantes.length} estudiantes'),
                backgroundColor: Colors.white24,
                labelStyle: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      body: estudiantes.isEmpty
          ? _buildVacio()
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: estudiantes.length,
              itemBuilder: (context, index) {
                return _buildEstudianteCard(estudiantes[index]);
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _mostrarDialogoAgregarEstudiante,
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
    );
  }

  // ══════════════════════════════════════════════════════════════════════════
  // WIDGETS AUXILIARES
  // ══════════════════════════════════════════════════════════════════════════

  Widget _buildVacio() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.school_outlined,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'Sin estudiantes registrados',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: _mostrarDialogoAgregarEstudiante,
            icon: const Icon(Icons.add),
            label: const Text('Agregar estudiante'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEstudianteCard(Estudiante estudiante) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        estudiante.nombre,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        estudiante.email,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () async {
                    final promedio = await AlmacenamientoSQLite
                        .obtenerPromedio(estudiante.id!);
                    if (!mounted) return;
                    ScaffoldMessenger.of(this.context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Promedio: ${promedio.toStringAsFixed(2)}',
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.calculate),
                  label: const Text('Promedio'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '🎓 ${estudiante.carrera}',
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Text(
                    '📅 ${estudiante.fechaIngreso.year}',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  onPressed: () {
                    _mostrarDialogoAgregarCalificacion(estudiante.id!);
                  },
                  icon: const Icon(Icons.grade),
                  label: const Text('Agregar nota'),
                ),
                TextButton.icon(
                  onPressed: () async {
                    await AlmacenamientoSQLite.eliminarEstudiante(
                      estudiante.id!,
                    );
                    cargarEstudiantes();
                  },
                  icon: const Icon(Icons.delete),
                  label: const Text('Eliminar'),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ══════════════════════════════════════════════════════════════════════════
  // DIÁLOGOS
  // ══════════════════════════════════════════════════════════════════════════

  void _mostrarDialogoAgregarEstudiante() {
    final controladorNombre = TextEditingController();
    final controladorEmail = TextEditingController();
    final controladorCarrera = TextEditingController();

    showDialog(
      context: this.context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Agregar estudiante'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: controladorNombre,
                  decoration: const InputDecoration(
                    labelText: 'Nombre',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: controladorEmail,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: controladorCarrera,
                  decoration: const InputDecoration(
                    labelText: 'Carrera',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (controladorNombre.text.isNotEmpty &&
                    controladorEmail.text.isNotEmpty &&
                    controladorCarrera.text.isNotEmpty) {
                  final estudiante = Estudiante(
                    nombre: controladorNombre.text,
                    email: controladorEmail.text,
                    carrera: controladorCarrera.text,
                    fechaIngreso: DateTime.now(),
                  );

                  await AlmacenamientoSQLite.agregarEstudiante(estudiante);
                  cargarEstudiantes();

                  if (!mounted) return;
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Estudiante agregado')),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: const Text('Agregar'),
            ),
          ],
        );
      },
    );
  }

  void _mostrarDialogoAgregarCalificacion(int estudianteId) {
    final controladorAsignatura = TextEditingController();
    final controladorNota = TextEditingController();

    showDialog(
      context: this.context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Agregar calificación'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: controladorAsignatura,
                  decoration: const InputDecoration(
                    labelText: 'Asignatura',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: controladorNota,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Nota (0-100)',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (controladorAsignatura.text.isNotEmpty &&
                    controladorNota.text.isNotEmpty) {
                  final calificacion = Calificacion(
                    estudianteId: estudianteId,
                    asignatura: controladorAsignatura.text,
                    nota: double.tryParse(controladorNota.text) ?? 0.0,
                    fecha: DateTime.now(),
                  );

                  await AlmacenamientoSQLite.agregarCalificacion(
                    calificacion,
                  );

                  if (!mounted) return;
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Calificación agregada')),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: const Text('Agregar'),
            ),
          ],
        );
      },
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// ENTRY POINT
// ═══════════════════════════════════════════════════════════════════════════

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MiApp());
}

class MiApp extends StatelessWidget {
  const MiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SQLite',
      theme: ThemeData(
        primarySwatch: Colors.green,
        useMaterial3: true,
      ),
      home: const PantallaSQLite(),
    );
  }
}
