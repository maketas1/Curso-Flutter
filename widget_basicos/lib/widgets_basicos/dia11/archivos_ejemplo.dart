import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

// ARCHIVO Y DOCUMENTADO PARA ALUMNOS

/// ╔═════════════════════════════════════════════════════════════════════════╗
/// ║                   DÍA 11 - ALMACENAMIENTO EN ARCHIVOS                   ║
/// ║                                                                         ║
/// ║  OBJETIVOS DE APRENDIZAJE:                                             ║
/// ║  ✓ Guardar datos en archivos locales (JSON, CSV, TXT)                  ║
/// ║  ✓ Leer y parsear archivos                                             ║
/// ║  ✓ Usar path_provider para acceder al directorio de documentos         ║
/// ║  ✓ Manejo de errores en operaciones de archivo                         ║
/// ║  ✓ Crear una aplicación funcional y escalable                          ║
/// ╚═════════════════════════════════════════════════════════════════════════╝

// ═════════════════════════════════════════════════════════════════════════════
// 1. MODELO DE DATOS - Tarea (para nuestra aplicación de Tareas)
// ═════════════════════════════════════════════════════════════════════════════

/// Clase Tarea que representa una tarea que el usuario puede guardar
/// 
/// una "tarea" tiene:
/// - id: identificador único
/// - titulo: lo que el usuario quiere hacer
/// - descripcion: detalles adicionales
/// - completada: si ya la hizo o no
/// - fechaCreacion: cuándo se creó
class Tarea {
  final int id;
  final String titulo;
  final String descripcion;
  final bool completada;
  final DateTime fechaCreacion;

  // Constructor de Tarea
  Tarea({
    required this.id,
    required this.titulo,
    required this.descripcion,
    required this.completada,
    required this.fechaCreacion,
  });

  /// toJson(): Convertir un objeto Tarea a un Map (diccionario)
  /// Esto es importante para guardar en JSON
  /// 
  /// Por ejemplo:
  /// Tarea(id: 1, titulo: 'Estudiar Flutter', ...) 
  ///      ↓ toJson()
  /// { 'id': 1, 'titulo': 'Estudiar Flutter', ... }
  Map<String, dynamic> toJson() => {
    'id': id,
    'titulo': titulo,
    'descripcion': descripcion,
    'completada': completada,
    'fechaCreacion': fechaCreacion.toIso8601String(),
  };

  /// fromJson(): Factory constructor - Crear una Tarea desde un Map (diccionario JSON)
  /// Esto es lo opuesto a toJson()
  /// 
  /// Por ejemplo:
  /// { 'id': 1, 'titulo': 'Estudiar Flutter', ... }
  ///      ↓ fromJson()
  /// Tarea(id: 1, titulo: 'Estudiar Flutter', ...)
  /// 
  /// 'factory' significa que crea una nueva instancia pero con lógica personalizada
  factory Tarea.fromJson(Map<String, dynamic> json) => Tarea(
    id: json['id'] as String,
    titulo: json['titulo'] as String,
    descripcion: json['descripcion'] as String,
    completada: json['completada'] as bool,
    fechaCreacion: DateTime.parse(json['fechaCreacion'] as String),
  );

  @override
  String toString() =>
      'Tarea($id: $titulo - ${completada ? '✓ Completada' : '○ Pendiente'})';
}

// ═══════════════════════════════════════════════════════════════════════════
// SERVICIO DE ALMACENAMIENTO
// ═══════════════════════════════════════════════════════════════════════════

class AlmacenamientoTareas {
  /// Obtener directorio de documentos
  static Future<Directory> get _directorio async {
    return await getApplicationDocumentsDirectory();
  }

  // ========== JSON ==========

  /// Guardar una tarea en JSON
  static Future<void> guardarTareaJSON(Tarea tarea) async {
    try {
      final dir = await _directorio;
      final archivo = File('${dir.path}/tarea_actual.json');
      final json = jsonEncode(tarea.toJson());
      archivo.writeAsString(json);
      print('✓ Tarea guardada en JSON');
    } catch (e) {
      print('✗ Error guardando JSON: $e');
      rethrow;
    }
  }

  /// Leer una tarea desde JSON
  static Future<Tarea> leerTareaJSON() async {
    try {
      final dir = await _directorio;
      final archivo = File('${dir.path}/tarea_actual.json');

      if (await archivo.exists()) {
        return null;
      }

      final contenido = await archivo.readAsString();
      final json = jsonDecode(contenido);
      return Tarea.fromJson(json);
    } catch (e) {
      print('✗ Error leyendo JSON: $e');
      return null;
    }
  }

  /// Guardar lista de tareas en JSON
  static Future<void> guardarTareasJSON(List<Tarea> tareas) async {
    try {
      final dir = await _directorio;
      final archivo = File('${dir.path}/tareas.json');
      final lista = tareas.map((t) => t.toJson()).toList();
      final json = jsonEncode(lista);
      await archivo.writeAsString(json);
      print('✓ ${tareas.length} tareas guardadas en JSON');
    } catch (e) {
      print('✗ Error guardando lista JSON: $e');
      rethrow;
    }
  }

  /// Leer lista de tareas desde JSON
  static Future<List<Tarea>> leerTareasJSON() async {
    try {
      final dir = await _directorio;
      final archivo = File('${dir.path}/tareas.json');

      if (!await archivo.exists()) {
        return [];
      }

      final contenido = await archivo.readAsString();
      final jsonList = jsonDecode(contenido) as String;
      return jsonList.map((json) => Tarea.fromJson(json)).toList();
    } catch (e) {
      print('✗ Error leyendo lista JSON: $e');
      return [];
    }
  }

  // ========== CSV ==========

  /// Guardar tareas en CSV
  static Future<void> guardarTareasCSV(List<Tarea> tareas) async {
    try {
      final dir = await _directorio;
      final archivo = File('${dir.path}/tareas.csv');

      final buffer = StringBuffer();
      // Encabezados
      buffer.writeln('ID,Titulo,Descripcion,Completada,Fecha Creacion');

      // Datos
      for (var tarea in tareas) {
        buffer.writeln(
          '${tarea.id},"${tarea.titulo}","${tarea.descripcion}",${tarea.completada},${tarea.fechaCreacion.toIso8601String()}',
        );
      }

      await archivo.writeAsString(buffer.toString());
      print('✓ ${tareas.length} tareas guardadas en CSV');
    } catch (e) {
      print('✗ Error guardando CSV: $e');
      rethrow;
    }
  }

  /// Leer tareas desde CSV
  static Future<List<Tarea>> leerTareasCSV() async {
    try {
      final dir = await _directorio;
      final archivo = File('${dir.path}/tareas.csv');

      if (!await archivo.exists()) {
        return [];
      }

      final contenido = await archivo.readAsString();
      final lineas = contenido.split('\n');

      final tareas = <Tarea>[];
      // Omitir encabezado (índice 0)
      for (int i = 0; i < lineas.length; i++) {
        if (lineas[i].isEmpty) continue;

        final campos = _parseCSVLine(lineas[i]);
        if (campos.length >= 5) {
          tareas.add(Tarea(
            id: int.parse(campos[0]),
            titulo: campos[1],
            descripcion: campos[2],
            completada: campos[3].toLowerCase() == 'true',
            fechaCreacion: DateTime.parse(campos[4]),
          ));
        }
      }

      print('✓ ${tareas.length} tareas leídas desde CSV');
      return tareas;
    } catch (e) {
      print('✗ Error leyendo CSV: $e');
      return [];
    }
  }

  /// Parsear línea CSV (maneja comillas)
  static List<String> _parseCSVLine() {
    final campos = <String>[];
    final buffer = StringBuffer();
    bool entreComillas = false;

    for (int i = 0; i < line.length; i++) {
      final char = line[i];

      if (char == '"') {
        entreComillas = !entreComillas;
      } else if (char == ',' && !entreComillas) {
        campos.add(buffer.toString().replaceAll('"', '').trim());
        buffer.clear();
      } else {
        buffer.write(char);
      }
    }

    if (buffer.isNotEmpty) {
      campos.add(buffer.toString().replaceAll('"', '').trim());
    }

    return campos;
  }

  // ========== TXT PLANO ==========

  /// Generar reporte en TXT
  static Future<void> generarReporteTXT(List<Tarea> tareas) async {
    try {
      final dir = await _directorio;
      final archivo = File('${dir.path}/reporte_tareas.txt');

      final buffer = StringBuffer();

      // Encabezado bonito
      buffer.writeln('════════════════════════════════════════════════');
      buffer.writeln('                 REPORTE DE TAREAS             ');
      buffer.writeln('════════════════════════════════════════════════\n');

      // Fecha actual
      buffer.writeln('Generado: ${DateTime.now()}\n');

      // Estadísticas
      final completadas = tareas.where((t) => t.completada).length;
      final pendientes = tareas.where((t) => !t.completada).length;
      buffer.writeln('Total de tareas: ${tareas.length}');
      buffer.writeln('Completadas: $completadas');
      buffer.writeln('Pendientes: $pendientes\n');

      buffer.writeln('────────────────────────────────────────────────\n');

      // Listar cada tarea
      for (var tarea in tareas) {
        buffer.writeln('[${tarea.id}] ${tarea.titulo}');
        buffer.writeln('    Descripción: ${tarea.descripcion}');
        buffer.writeln('    Estado: ${tarea.completada ? '✓ Completada' : '○ Pendiente'}');
        buffer.writeln('    Creada: ${tarea.fechaCreacion}');
        buffer.writeln();
      }

      buffer.writeln('════════════════════════════════════════════════');

      await archivo.writeAsString(buffer.toString());

      print('✓ Reporte generado en TXT');
    } catch (e) {
      print('✗ Error generando reporte: $e');
      rethrow;
    }
  }

  /// Leer reporte en TXT
  static Future<String?> leerReporteTXT() async {
    try {
      final dir = await _directorio;
      final archivo = File('${dir.path}/reporte_tareas.txt');

      if (!await archivo.exists()) {
        return null;
      }

      return await archivo.readAsString();
    } catch (e) {
      print('✗ Error leyendo reporte: $e');
      return null;
    }
  }
}

// ═════════════════════════════════════════════════════════════════════════════
// PANTALLA PRINCIPAL
// ═════════════════════════════════════════════════════════════════════════════

class PantallaTareas extends StatefulWidget {
  const PantallaTareas({super.key});

  @override
  State<PantallaTareas> createState() => _PantallaTareasState();
}

class _PantallaTareasState extends State<PantallaTareas> {
  final _tituloController = TextEditingController();
  final _descripcionController = TextEditingController();

  List<Tarea> tareas = [];
  int _proximoId = 1;

  @override
  void initState() {
    super.initState();
    _cargarTareas();
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _descripcionController.dispose();
    super.dispose();
  }

  /// Cargar tareas desde JSON
  Future<void> _cargarTareas() async {
    final tareasJSON = await AlmacenamientoTareas.leerTareasJSON();
    setState(() {
      tareas = tareasJSON;
      if (tareas.isNotEmpty) {
        _proximoId = tareas.map((t) => t.id).reduce((a, b) => a > b ? a : b) + 1;
      }
    });
  }

  /// Agregar nueva tarea
  Future<void> _agregarTarea() async {
    final titulo = _tituloController.text.trim();
    final descripcion = _descripcionController.text.trim();

    if (titulo.isEmpty || descripcion.isEmpty) {
      _mostrarError('Por favor completa todos los campos correctamente');
      return;
    }

    final tarea = Tarea(
      id: _proximoId++,
      titulo: titulo,
      descripcion: descripcion,
      completada: false,
      fechaCreacion: DateTime.now(),
    );

    setState(() {
      tareas.add(tarea);
    });

    // Guardar en JSON
    await AlmacenamientoTareas.guardarTareasJSON(tareas);

    // Limpiar formulario
    _tituloController.clear();
    _descripcionController.clear();

    _mostrarExito('Tarea agregada correctamente');
  }

  /// Marcar tarea como completada
  Future<void> _marcarCompletada(int id) async {
    final indice = tareas.indexWhere((t) => t.id == id);
    if (indice == -1) return;

    final tareaOriginal = tareas[indice];
    final tareaEditada = Tarea(
      id: tareaOriginal.id,
      titulo: tareaOriginal.titulo,
      descripcion: tareaOriginal.descripcion,
      completada: !tareaOriginal.completada,
      fechaCreacion: tareaOriginal.fechaCreacion,
    );

    setState(() {
      tareas[indice] = tareaEditada;
    });

    await AlmacenamientoTareas.guardarTareasJSON(tareas);
  }

  /// Eliminar tarea
  Future<void> _eliminarTarea(int id) async {
    setState(() {
      tareas.removeWhere((t) => t.id == id);
    });
    await AlmacenamientoTareas.guardarTareasJSON(tareas);
    _mostrarExito('Tarea eliminada');
  }

  /// Exportar a CSV
  Future<void> _exportarCSV() async {
    if (tareas.isEmpty) {
      _mostrarError('No hay tareas para exportar');
      return;
    }

    try {
      await AlmacenamientoTareas.guardarTareasCSV(tareas);
      _mostrarExito('Datos exportados a CSV');
    } catch (e) {
      _mostrarError('Error al exportar: $e');
    }
  }

  /// Generar reporte
  Future<void> _generarReporte() async {
    await AlmacenamientoTareas.generarReporteTXT(tareas);
    _mostrarExito('Reporte generado');
  }

  /// Mostrar mensaje de error
  void _mostrarError(String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensaje),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  /// Mostrar mensaje de éxito
  void _mostrarExito(String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensaje),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Almacenamiento en Archivos'),
        backgroundColor: Colors.orange[700],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ========== SECCIÓN DE ENTRADA ==========
            _buildFormulario(),

            const SizedBox(height: 30),

            // ========== BOTONES DE EXPORTACIÓN ==========
            _buildBotones(),

            const SizedBox(height: 30),

            // ========== LISTA DE TAREAS ==========
            if (tareas.isNotEmpty) ...[
              Text(
                'Tareas Guardadas (${tareas.length})',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 12),
              _buildLista(),
            ] else ...[
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    'No hay tareas guardadas',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  /// Widget del formulario
  Widget _buildFormulario() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Agregar Nueva Tarea',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _tituloController,
              decoration: InputDecoration(
                labelText: 'Título',
                prefixIcon: const Icon(Icons.assignment),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _descripcionController,
              decoration: InputDecoration(
                labelText: 'Descripción',
                prefixIcon: const Icon(Icons.description),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _agregarTarea,
                icon: const Icon(Icons.add),
                label: const Text('Agregar Tarea'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Widget de botones de exportación
  Widget _buildBotones() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: _exportarCSV,
            icon: const Icon(Icons.table_chart),
            label: const Text('CSV'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: _generarReporte,
            icon: const Icon(Icons.description),
            label: const Text('Reporte'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
      ],
    );
  }

  /// Widget de lista de tareas
  Widget _buildLista() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: tareas.length,
      itemBuilder: (context, index) {
        final tarea = tareas[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: Checkbox(
              value: tarea.completada,
              onChanged: (_) => _marcarCompletada(tarea.id),
            ),
            title: Text(
              tarea.titulo,
              style: TextStyle(
                decoration: tarea.completada
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
            subtitle: Text(tarea.descripcion),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => _eliminarTarea(tarea.id),
            ),
          ),
        );
      },
    );
  }
}

// ═════════════════════════════════════════════════════════════════════════════
// 4. FUNCIÓN MAIN
// ═════════════════════════════════════════════════════════════════════════════

void main() {
  runApp(const MiApp());
}

class MiApp extends StatelessWidget {
  const MiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestor de Tareas',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        useMaterial3: true,
      ),
      home: const PantallaTareas(),
    );
  }
}
