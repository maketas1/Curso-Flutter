import 'package:flutter/material.dart';
import 'package:widget_basicos/widgets_basicos/dia11/hive_ejemplo.dart';
import 'package:widget_basicos/widgets_basicos/dia11/sqlite_ejemplo.dart';
import 'package:widget_basicos/widgets_basicos/dia9/my_lesson_header.dart';
import 'shared_preferences_ejemplo.dart';

/// DÍA 11 - PERSISTENCIA LOCAL EN FLUTTER
///
/// Este archivo enseña cómo guardar y recuperar datos localmente
/// en una aplicación Flutter usando diferentes métodos.
///
/// CONCEPTOS PRINCIPALES:
///
/// 1. ARCHIVOS LOCALES (JSON/CSV/TXT)
///    - Usar path_provider para obtener directorio de documentos
///    - Leer y escribir archivos con dart:io
///    - Parsear JSON y CSV manualmente
///
/// 2. SHARED PREFERENCES
///    - Almacenamiento clave-valor simple
///    - Ideal para preferencias y tokens
///    - Acceso rápido y sincrónico
///
/// 3. HIVE
///    - Base de datos key-value embebida
///    - Muy rápida y eficiente
///    - Soporte para objetos complejos
///
/// 4. SQLITE
///    - Base de datos relacional
///    - Queries complejas
///    - Mejor para aplicaciones grandes
///

/*    // INICIO: Ruta que se muestra primero
      // home: const Dia11Persistencia(),
      
      // RUTAS NOMBRADAS: Definir todos los caminos disponibles
      routes: {
        // Ruta principal
        '/': (context) => const Dia11Persistencia(),

        // Ruta a Archivos
        '/archivos': (context) => Placeholder(),
        
        // Ruta a SharedPreferences
        '/shared_prefs': (context) => Placeholder(),
        
        // Ruta a Hive
        '/hive': (context) => const Placeholder(),
        
        // Ruta a SQLite
        '/sqlite': (context) => const Placeholder(),
      },
*/

/// Pantalla de inicio con botones para navegar a diferentes métodos de persistencia
class Dia11Persistencia extends StatelessWidget {
  const Dia11Persistencia({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Persistencia Local'),
        backgroundColor: Colors.teal[700],
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// HEADER: Título y descripción
              MyLessonHeader(
                fecha: 'Miércoles, 11 de febrero 2026',
                titulo: 'Persistencia local de datos en Flutter',
                color: Colors.teal,
                icono: Icons.storage,
              ),

              const SizedBox(height: 50),

              /// BOTÓN 1: SharedPreferences (ahora es el primero)
              _buildNavigationButton(
                context,
                icon: Icons.settings,
                title: 'SharedPreferences',
                description: 'Preferencias y datos pequeños',
                color: Colors.blue,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PantallaPreferencias(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 20),

              /// BOTÓN 2: Hive
              _buildNavigationButton(
                context,
                icon: Icons.key,
                title: 'Hive',
                description: 'Base de datos key-value rápida',
                color: Colors.deepPurple,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PantallaHive(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 20),

              /// BOTÓN 3: SQLite
              _buildNavigationButton(
                context,
                icon: Icons.storage,
                title: 'SQLite',
                description: 'Base de datos relacional completa',
                color: Colors.green,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PantallaSQLite(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 20),

              /// BOTÓN 4: Archivos Locales (ahora es el último)
              // _buildNavigationButton(
              //   context,
              //   icon: Icons.folder,
              //   title: 'Archivos Locales',
              //   description: 'JSON, CSV, TXT - Almacenamiento en archivos',
              //   color: Colors.orange,
              //   onTap: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) => const PantallaTareas(),
              //       ),
              //     );
              //   },
              // ),

              const SizedBox(height: 20),

              /// BOTÓN ADICIONAL: Comparativa
              ElevatedButton.icon(
                onPressed: () {
                  _mostrarComparativa(context);
                },
                icon: const Icon(Icons.compare_arrows),
                label: const Text('Ver Comparativa'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                ),
              ),

              const SizedBox(height: 50),

              /// INFORMACIÓN: Explicación de persistencia
              _buildInfoBox(),
            ],
          ),
        ),
      ),
    );
  }

  /// Widget con información sobre persistencia
  Widget _buildInfoBox() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.teal[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.teal[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '✓ ¿CÓMO FUNCIONAN LOS MÉTODOS DE PERSISTENCIA?',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.teal,
            ),
          ),
          const SizedBox(height: 12),
          _buildInfoItem(
            '📁 Archivos',
            'Guardar datos en JSON/CSV/TXT usando dart:io',
          ),
          _buildInfoItem(
            '⚙️ SharedPreferences',
            'Almacenar preferencias y tokens (datos pequeños)',
          ),
          _buildInfoItem(
            '🗝️ Hive',
            'Base de datos key-value embebida y rápida',
          ),
          _buildInfoItem(
            '🗄️ SQLite',
            'Base de datos relacional con queries complejas',
          ),
        ],
      ),
    );
  }

  /// Helper para mostrar items informativos
  Widget _buildInfoItem(String title, String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12,
              color: Colors.teal,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            content,
            style: const TextStyle(fontSize: 11, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  /// Mostrar comparativa en un diálogo
  void _mostrarComparativa(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('📊 Comparativa de Métodos'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildComparativaItem(
                  'Archivos',
                  ['✓ Datos grandes', '✓ Exportación', '✗ Queries complejas'],
                ),
                const SizedBox(height: 12),
                _buildComparativaItem(
                  'SharedPreferences',
                  ['✓ Muy rápido', '✓ Preferencias', '✗ Datos pequeños (<1MB)'],
                ),
                const SizedBox(height: 12),
                _buildComparativaItem(
                  'Hive',
                  ['✓ Muy rápido', '✓ Caché', '✗ No relacional'],
                ),
                const SizedBox(height: 12),
                _buildComparativaItem(
                  'SQLite',
                  ['✓ Queries complejas', '✓ Relacional', '✗ Más overhead'],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildComparativaItem(String titulo, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titulo,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
        ),
        const SizedBox(height: 4),
        ...items
            .map(
              (item) => Text(
                item,
                style: const TextStyle(fontSize: 11),
              ),
            )
            .toList(),
      ],
    );
  }

  /// Widget para crear botones de navegación personalizados
  Widget _buildNavigationButton(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: color.withAlpha(50),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color, size: 30),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(description),
        trailing: Icon(Icons.arrow_forward, color: color),
        onTap: onTap,
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// GUÍA DE USO EN main.dart
// ═══════════════════════════════════════════════════════════════════════════

/// CÓMO USAR ESTE ARCHIVO EN TU main.dart:
/// 
/// ```dart
/// void main() {
///   runApp(const Dia11Persistencia());
/// }
/// ```
/// 
/// ¡ESO ES TODO! El enrutamiento está configurado en la clase Dia11Persistencia.

// ═══════════════════════════════════════════════════════════════════════════
// DEPENDENCIAS REQUERIDAS
// ═══════════════════════════════════════════════════════════════════════════

/// Agregar a pubspec.yaml:
/// 
/// ```yaml
/// dependencies:
///   flutter:
///     sdk: flutter
///   path_provider: ^2.0.0
///   shared_preferences: ^2.1.0
///   hive: ^2.2.0
///   hive_flutter: ^1.1.0
///   sqflite: ^2.2.0
///   path: ^1.8.0
/// ```

// ═══════════════════════════════════════════════════════════════════════════
// TABLA COMPARATIVA
// ═══════════════════════════════════════════════════════════════════════════

/// 
/// ┌──────────────────┬───────────┬───────────┬─────────┬──────────┐
/// │ Característica   │ Archivos  │  Shared   │  Hive   │ SQLite   │
/// │                  │           │  Prefs    │         │          │
/// ├──────────────────┼───────────┼───────────┼─────────┼──────────┤
/// │ Velocidad        │    ★★★    │    ★★★★★  │ ★★★★★  │   ★★★★   │
/// │ Capacidad        │    ★★★★★  │    ★       │ ★★★★   │  ★★★★★  │
/// │ Complejidad      │    ★★★    │    ★      │  ★★    │   ★★★★   │
/// │ Queries          │    ★       │    ★      │  ★★    │  ★★★★★  │
/// │ Relaciones       │    ★       │    ★      │  ★     │  ★★★★★  │
/// └──────────────────┴───────────┴───────────┴─────────┴──────────┘
/// 
/// CUÁNDO USAR CADA UNO:
/// 
/// 📁 ARCHIVOS → Exportaciones, logs, datos grandes
/// ⚙️ SHARED PREFS → Tema, idioma, token, primer acceso
/// 🗝️ HIVE → Caché, favoritos, datos que cambian frecuentemente
/// 🗄️ SQLITE → Apps complejas, queries avanzadas, sincronización

// ═══════════════════════════════════════════════════════════════════════════
// EJEMPLOS RÁPIDOS
// ═══════════════════════════════════════════════════════════════════════════

/// EJEMPLO 1: Archivos JSON
/// 
/// ```dart
/// final usuario = Usuario(id: 1, nombre: 'Juan');
/// final dir = await getApplicationDocumentsDirectory();
/// final archivo = File('${dir.path}/usuario.json');
/// await archivo.writeAsString(jsonEncode(usuario.toJson()));
/// ```

/// EJEMPLO 2: SharedPreferences
/// 
/// ```dart
/// final prefs = await SharedPreferences.getInstance();
/// await prefs.setString('token', 'abc123');
/// final token = prefs.getString('token');
/// ```

/// EJEMPLO 3: Hive
/// 
/// ```dart
/// final box = Hive.box('usuarios');
/// box.put(1, usuario);
/// final user = box.get(1);
/// ```

/// EJEMPLO 4: SQLite
/// 
/// ```dart
/// final db = await database;
/// await db.insert('usuarios', usuario.toJson());
/// final usuarios = await db.query('usuarios');
/// ```
