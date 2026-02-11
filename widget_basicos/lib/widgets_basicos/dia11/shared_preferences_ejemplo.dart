import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// ════════════════════════════════════════════════════════════════════════════
/// SHARED PREFERENCES - EJEMPLO EDUCATIVO
/// ════════════════════════════════════════════════════════════════════════════
///
/// SharedPreferences es un almacenamiento KEY-VALUE simple y rápido en Flutter.
/// 
/// ✓ CARACTERÍSTICAS:
///   • Acceso sincrónico (instantáneo)
///   • Ideal para preferencias y tokens
///   • Máximo: ~1MB de datos
///   • No requiere instalación de BDD
///
/// ✓ CASOS DE USO:
///   • Guardar tema (dark/light)
///   • Guardar idioma
///   • Guardar token de autenticación
///   • Guardar preferencias booleanas (notificaciones, sonido)
///   • Primer acceso a la app
///
/// ✓ ALTERNATIVAS:
///   • Archivos (para datos grandes)
///   • Hive (para caché más complejo)
///   • SQLite (para datos relaciones)
/// ════════════════════════════════════════════════════════════════════════════

// ═══════════════════════════════════════════════════════════════════════════
// MODELO DE PREFERENCIAS
// ═══════════════════════════════════════════════════════════════════════════

/// Clase que representa las preferencias del usuario
class Preferencias {
  final String tema; // 'light' o 'dark'
  final String idioma; // 'es', 'en', 'fr'
  final String token; // Token de autenticación
  final bool notificacionesHabilitadas;
  final bool esPrimerAcceso;
  final DateTime fechaUltimaModificacion;

  const Preferencias({
    required this.tema,
    required this.idioma,
    required this.token,
    required this.notificacionesHabilitadas,
    required this.esPrimerAcceso,
    required this.fechaUltimaModificacion,
  });

  /// Convertir a formato JSON
  Map<String, dynamic> toJson() {
    return {
      'tema': tema,
      'idioma': idioma,
      'token': token,
      'notificacionesHabilitadas': notificacionesHabilitadas,
      'esPrimerAcceso': esPrimerAcceso,
      'fechaUltimaModificacion': fechaUltimaModificacion.toIso8601String(),
    };
  }

  /// Factory constructor para crear desde JSON
  factory Preferencias.fromJson(Map<String, dynamic> json) {
    return Preferencias(
      tema: json['tema'] ?? 'light',
      idioma: json['idioma'] ?? 'es',
      token: json['token'],
      notificacionesHabilitadas: json['notificacionesHabilitadas'] ?? true,
      esPrimerAcceso: json['esPrimerAcceso'] ?? true,
      fechaUltimaModificacion:
          DateTime.parse(json['fechaUltimaModificacion'] ?? DateTime.now().toIso8601String()),
    );
  }

  /// Valores por defecto
  factory Preferencias.defecto() {
    return Preferencias(
      tema: 'light',
      idioma: 'es',
      token: '',
      notificacionesHabilitadas: true,
      esPrimerAcceso: true,
      fechaUltimaModificacion: DateTime.now(),
    );
  }

  @override
  String toString() {
    return '''
    ═════════════════════════════════════════
    PREFERENCIAS DEL USUARIO
    ═════════════════════════════════════════
    Tema: $tema
    Idioma: $idioma
    Token: ${token.isEmpty ? 'No configurado' : 'Configurado'}
    Notificaciones: ${notificacionesHabilitadas ? 'Activas' : 'Desactivas'}
    ¿Primer acceso?: ${esPrimerAcceso ? 'Sí' : 'No'}
    Última modificación: ${fechaUltimaModificacion.toLocal()}
    ═════════════════════════════════════════
    ''';
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// SERVICIO DE ALMACENAMIENTO
// ═══════════════════════════════════════════════════════════════════════════

/// Servicio para gestionar preferencias con SharedPreferences
class AlmacenamientoPreferencias {
  // === CLAVES PARA SHARED PREFERENCES ===
  static const String _claveTema = 'tema';
  static const String _claveIdioma = 'idioma';
  static const String _claveToken = 'token';
  static const String _claveNotificaciones = 'notificacionesHabilitadas';
  static const String _clavePrimerAcceso = 'esPrimerAcceso';
  static const String _claveFechaModificacion = 'fechaUltimaModificacion';

  // ══════════════════════════════════════════════════════════════════════════
  // MÉTODOS PARA GUARDAR INDIVIDUAL
  // ══════════════════════════════════════════════════════════════════════════

  /// Guardar tema (light/dark)
  static Future<void> guardarTema(String tema) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_claveTema, tema);
    print('✓ Tema guardado: $tema');
  }

  /// Guardar idioma
  static Future<void> guardarIdioma(String idioma) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_claveIdioma, idioma);
    print('✓ Idioma guardado: $idioma');
  }

  /// Guardar token
  static Future<void> guardarToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_claveToken, token);
    print('✓ Token guardado');
  }

  /// Guardar notificaciones habilitadas
  static Future<void> guardarNotificaciones(bool habilitadas) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_claveNotificaciones, habilitadas);
    print('✓ Preferencia de notificaciones guardada: $habilitadas');
  }

  /// Guardar primer acceso
  static Future<void> guardarPrimerAcceso(bool es) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_clavePrimerAcceso, es);
    print('✓ Primer acceso actualizado: $es');
  }

  // ══════════════════════════════════════════════════════════════════════════
  // MÉTODOS PARA LEER INDIVIDUAL
  // ══════════════════════════════════════════════════════════════════════════

  /// Leer tema
  static Future<String> leerTema() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_claveTema) ?? 'light';
  }

  /// Leer idioma
  static Future<String> leerIdioma() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_claveIdioma) ?? 'es';
  }

  /// Leer token
  static Future<int> leerToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_claveToken) ?? 0;
  }

  /// Leer notificaciones
  static Future<bool> leerNotificaciones() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_claveNotificaciones) ?? true;
  }

  /// Leer primer acceso
  static Future<bool> leerPrimerAcceso() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_clavePrimerAcceso) ?? true;
  }

  // ══════════════════════════════════════════════════════════════════════════
  // MÉTODOS COMBINADOS
  // ══════════════════════════════════════════════════════════════════════════

  /// Leer todas las preferencias
  static Future<Preferencias> leerPreferencias() async {
    final prefs = await SharedPreferences.getInstance();

    return Preferencias(
      tema: prefs.getString(_claveTema) ?? 'light',
      idioma: prefs.getString(_claveIdioma) ?? 'es',
      token: prefs.getString(_claveToken) ?? '',
      notificacionesHabilitadas: prefs.getBool(_claveNotificaciones) ?? true,
      esPrimerAcceso: prefs.getBool(_clavePrimerAcceso) ?? true,
      fechaUltimaModificacion: DateTime.parse(
        prefs.getString(_claveFechaModificacion) ?? DateTime.now().toIso8601String(),
      ),
    );
  }

  /// Guardar todas las preferencias
  static Future<void> guardarPreferencias(Preferencias prefs) async {
    final preferences = await SharedPreferences.getInstance();

    await preferences.setString(_claveTema, prefs.tema);
    await preferences.setString(_claveIdioma, prefs.idioma);
    await preferences.setString(_claveToken, prefs.token);
    guardarNotificaciones(prefs.notificacionesHabilitadas);
    await preferences.setBool(_clavePrimerAcceso, prefs.esPrimerAcceso);
    await preferences.setString(
      _claveFechaModificacion,
      prefs.fechaUltimaModificacion.toIso8601String(),
    );

    print('✓ Todas las preferencias guardadas');
  }

  /// Limpiar todas las preferencias
  static Future<void> limpiarPreferencias() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    print('✓ Preferencias limpiadas');
  }

  /// Obtener resumen de almacenamiento
  static Future<void> mostrarResumen() async {
    final prefs = await SharedPreferences.getInstance();
    final preferencias = await leerPreferencias();

    print(preferencias.toString());
    print('\nClaves almacenadas: ${prefs.getKeys().toList()}');
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// INTERFAZ DE USUARIO
// ═══════════════════════════════════════════════════════════════════════════

class PantallaPreferencias extends StatefulWidget {
  const PantallaPreferencias({super.key});

  @override
  State<PantallaPreferencias> createState() => _PantallaPreferenciasState();
}

class _PantallaPreferenciasState extends State<PantallaPreferencias> {
  late Preferencias preferencias;
  bool cargando = true;

  @override
  void initState() {
    super.initState();
    cargarPreferencias();
  }

  /// Cargar preferencias desde SharedPreferences
  void cargarPreferencias() async {
    preferencias = await AlmacenamientoPreferencias.leerPreferencias();
    if (preferencias != null) {
      setState(() {
        cargando = false;
      });
    }
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
        title: const Text('SharedPreferences'),
        backgroundColor: Colors.blue[700],
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // ══════════════════════════════════════════════════════════════════
          // SECCIÓN: TEMA
          // ══════════════════════════════════════════════════════════════════
          _buildSectionTitle('🎨 Tema'),
          _buildCard(
            children: [
              ListTile(
                leading: const Icon(Icons.palette),
                title: const Text('Modo oscuro/claro'),
                subtitle: Text('Actual: ${preferencias.tema}'),
                trailing: Switch(
                  value: preferencias.tema == 'dark',
                  onChanged: (valor) {
                    final nuevoTema = valor ? 'dark' : 'light';
                    AlmacenamientoPreferencias.guardarTema(nuevoTema);

                    setState(() {
                      preferencias = preferencias.copyWith(tema: nuevoTema);
                    });

                    if (!mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Tema cambiado a $nuevoTema')),
                    );
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // ══════════════════════════════════════════════════════════════════
          // SECCIÓN: IDIOMA
          // ══════════════════════════════════════════════════════════════════
          _buildSectionTitle('🌍 Idioma'),
          _buildCard(
            children: [
              ListTile(
                leading: const Icon(Icons.language),
                title: const Text('Seleccionar idioma'),
                subtitle: Text('Actual: ${preferencias.idioma}'),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Wrap(
                  spacing: 8,
                  children: ['es', 'en', 'fr']
                      .map(
                        (idioma) => FilterChip(
                          label: Text(_getNombreIdioma(idioma)),
                          selected: preferencias.idioma == idioma,
                          onSelected: (seleccionado) async {
                            if (seleccionado) {
                              await AlmacenamientoPreferencias
                                  .guardarIdioma(idioma);

                              setState(() {
                                preferencias =
                                    preferencias.copyWith(idioma: idioma);
                              });

                              if (!mounted) return;
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Idioma: $idioma')),
                              );
                            }
                          },
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // ══════════════════════════════════════════════════════════════════
          // SECCIÓN: NOTIFICACIONES
          // ══════════════════════════════════════════════════════════════════
          _buildSectionTitle('🔔 Notificaciones'),
          _buildCard(
            children: [
              ListTile(
                leading: const Icon(Icons.notifications),
                title: const Text('Habilitar notificaciones'),
                subtitle: preferencias.notificacionesHabilitadas
                    ? const Text('Activas')
                    : const Text('Desactivas'),
                trailing: Switch(
                  value: preferencias.notificacionesHabilitadas,
                  onChanged: (valor) async {
                    await AlmacenamientoPreferencias.guardarNotificaciones(valor);

                    setState(() {
                      preferencias = preferencias
                          .copyWith(notificacionesHabilitadas: valor);
                    });

                    if (!mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Notificaciones ${valor ? 'activadas' : 'desactivadas'}',
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // ══════════════════════════════════════════════════════════════════
          // SECCIÓN: TOKEN
          // ══════════════════════════════════════════════════════════════════
          _buildSectionTitle('🔐 Autenticación'),
          _buildCard(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Token de autenticación',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        preferencias.token.isEmpty
                            ? 'No configurado'
                            : '${preferencias.token.substring(0, 10)}...',
                        style: const TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: () {
                        _mostrarDialogoToken();
                      },
                      icon: const Icon(Icons.edit),
                      label: const Text('Configurar token'),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // ══════════════════════════════════════════════════════════════════
          // SECCIÓN: INFORMACIÓN
          // ══════════════════════════════════════════════════════════════════
          _buildSectionTitle('ℹ️ Información'),
          _buildCard(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoRow(
                      'Primer acceso:',
                      preferencias.esPrimerAcceso ? 'Sí' : 'No',
                    ),
                    const SizedBox(height: 8),
                    _buildInfoRow(
                      'Última modificación:',
                      '${preferencias.fechaUltimaModificacion.day}/${preferencias.fechaUltimaModificacion.month}/${preferencias.fechaUltimaModificacion.year} ${preferencias.fechaUltimaModificacion.hour}:${preferencias.fechaUltimaModificacion.minute}',
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // ══════════════════════════════════════════════════════════════════
          // BOTONES DE ACCIÓN
          // ══════════════════════════════════════════════════════════════════
          ElevatedButton.icon(
            onPressed: () {
              AlmacenamientoPreferencias.mostrarResumen();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Resumen mostrado en consola'),
                ),
              );
            },
            icon: const Icon(Icons.info),
            label: const Text('Ver resumen'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
          const SizedBox(height: 12),

          ElevatedButton.icon(
            onPressed: () {
              _mostrarDialogoLimpiar();
            },
            icon: const Icon(Icons.delete),
            label: const Text('Limpiar preferencias'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  // ══════════════════════════════════════════════════════════════════════════
  // MÉTODOS AUXILIARES
  // ══════════════════════════════════════════════════════════════════════════

  Widget _buildSectionTitle(String titulo) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        titulo,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.blue,
        ),
      ),
    );
  }

  Widget _buildCard({required List<Widget> children}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: children,
      ),
    );
  }

  Widget _buildInfoRow(String label, String valor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.grey,
          ),
        ),
        Text(
          valor,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  String _getNombreIdioma(String codigo) {
    return {
      'es': '🇪🇸 Español',
      'en': '🇬🇧 English',
      'fr': '🇫🇷 Français',
    }[codigo]!;
  }

  void _mostrarDialogoToken() {
    final controlador = TextEditingController(text: preferencias.token);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Configurar token'),
          content: TextField(
            controller: controlador,
            decoration: const InputDecoration(
              hintText: 'Pegar token aquí...',
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
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
                await AlmacenamientoPreferencias.guardarToken(
                  controlador.text,
                );

                setState(() {
                  preferencias = preferencias.copyWith(token: controlador.text);
                });

                if (!mounted) return;
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Token guardado')),
                );
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  void _mostrarDialogoLimpiar() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('⚠️ Limpiar preferencias'),
          content: const Text(
            '¿Estás seguro de que deseas eliminar todas las preferencias?',
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
                await AlmacenamientoPreferencias.limpiarPreferencias();

                setState(() {
                  preferencias = Preferencias.defecto();
                });

                if (!mounted) return;
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Preferencias limpiadas')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text('Eliminar'),
            ),
          ],
        );
      },
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// EXTENSION PARA COPIAR OBJETOS
// ═══════════════════════════════════════════════════════════════════════════

extension CopyWithPreferencias on Preferencias {
  Preferencias copyWith({
    String? tema,
    String? idioma,
    String? token,
    bool? notificacionesHabilitadas,
    bool? esPrimerAcceso,
    DateTime? fechaUltimaModificacion,
  }) {
    return Preferencias(
      tema: tema ?? this.tema,
      idioma: idioma ?? this.idioma,
      token: token ?? this.token,
      notificacionesHabilitadas:
          notificacionesHabilitadas ?? this.notificacionesHabilitadas,
      esPrimerAcceso: esPrimerAcceso ?? this.esPrimerAcceso,
      fechaUltimaModificacion:
          fechaUltimaModificacion ?? this.fechaUltimaModificacion,
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// ENTRY POINT
// ═══════════════════════════════════════════════════════════════════════════

void main() {
  runApp(const MiApp());
}

class MiApp extends StatelessWidget {
  const MiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SharedPreferences',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const PantallaPreferencias(),
    );
  }
}
