import 'package:flutter/material.dart';

/// 📚 MY LESSON HEADER - WIDGET PERSONALIZADO REUTILIZABLE
/// 
/// Este widget sirve como encabezado para cada lección o día.
/// Se puede personalizar fácilmente cambiando:
/// - fecha: Fecha o día de la lección (ej: "9 de febrero 2026")
/// - titulo: Tema principal (ej: "Enrutamiento en Flutter")
/// - color: Color del encabezado (ej: Colors.blue)
/// - icono: Icono decorativo (opcional)
/// - subtitulo: Descripción adicional (opcional)
/// 
/// VENTAJAS DE ESTE WIDGET:
/// ✅ Reutilizable en múltiples pantallas
/// ✅ Fácil de personalizar
/// ✅ Consistencia visual en toda la app
/// ✅ Reduce código duplicado
/// ✅ Cambios globales se hacen en un solo lugar
/// 
/// EJEMPLOS DE USO:
/// 
/// // Uso básico
/// MyLessonHeader(
///   fecha: '9 de febrero 2026',
///   titulo: 'Enrutamiento en Flutter',
/// )
/// 
/// // Con color personalizado
/// MyLessonHeader(
///   fecha: '10 de febrero 2026',
///   titulo: 'Formularios',
///   color: Colors.green,
/// )
/// 
/// // Con todo personalizado
/// MyLessonHeader(
///   fecha: '11 de febrero 2026',
///   titulo: 'Animaciones',
///   color: Colors.purple,
///   icono: Icons.animation,
///   subtitulo: 'Aprende a animar widgets',
/// )

class MyLessonHeader extends StatelessWidget {
  /// Fecha de la lección (ej: "9 de febrero 2026")
  final String fecha;
  
  /// Título o tema principal de la lección
  final String titulo;
  
  /// Color del encabezado (por defecto: azul)
  final Color color;
  
  /// Icono que aparece en el recuadro (por defecto: Icons.widgets)
  final IconData icono;
  
  /// Subtítulo o descripción adicional (opcional)
  final String? subtitulo;
  
  /// Height del recuadro del icono (por defecto: 80)
  final double iconBoxSize;
  
  /// Padding interno del widget (por defecto: 20)
  final double padding;

  const MyLessonHeader({
    super.key,
    required this.fecha,
    required this.titulo,
    this.color = Colors.blue,
    this.icono = Icons.widgets,
    this.subtitulo,
    this.iconBoxSize = 60,
    this.padding = 20,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// 🎨 RECUADRO CON ICONO
          /// 
          /// Container decorativo que contiene el icono.
          /// El color es más claro que el color principal.
          Container(
            width: iconBoxSize,
            height: iconBoxSize,
            decoration: BoxDecoration(
              /// Color de fondo: versión clara del color principal
              color: color.withAlpha(40), // Aproximadamente 0.15 opacidad),
              /// Bordes redondeados
              borderRadius: BorderRadius.circular(20),
            ),
            /// Icono centrado
            child: Icon(
              icono,
              size: iconBoxSize * 0.6, // 60% del tamaño del contenedor
              color: color,
            ),
          ),
          
          const SizedBox(height: 20),
          
          /// 📅 FECHA
          /// 
          /// Texto con la fecha/día de la lección.
          Text(
            fecha,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
              letterSpacing: 0.5, // Separación entre letras
            ),
          ),
          
          const SizedBox(height: 8),
          
          /// 📖 TÍTULO
          /// 
          /// Texto con el tema principal de la lección.
          /// Estilo: Mediano, gris oscuro, descriptivo.
          Text(
            titulo,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
              height: 1.4, // Altura de línea
            ),
            textAlign: TextAlign.center,
          ),
          
          /// 📝 SUBTÍTULO OPCIONAL
          /// 
          /// Si se proporciona un subtítulo, se muestra con estilo diferente.
          if (subtitulo != null) ...[
            const SizedBox(height: 12),
            Text(
              subtitulo!,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}

/// ═══════════════════════════════════════════════════════════════════════════
/// EJEMPLOS DE USO COMPLETOS
/// ═══════════════════════════════════════════════════════════════════════════

/// EJEMPLO 1: Versión básica
/// 
/// MyLessonHeader(
///   fecha: '9 de febrero 2026',
///   titulo: 'Enrutamiento en Flutter',
/// )
/// 
/// Resultado: Encabezado azul con icono de widgets

/// EJEMPLO 2: Con color personalizado
/// 
/// MyLessonHeader(
///   fecha: '10 de febrero 2026',
///   titulo: 'Gestión del Estado',
///   color: Colors.green,
/// )
/// 
/// Resultado: Encabezado verde

/// EJEMPLO 3: Con icono personalizado
/// 
/// MyLessonHeader(
///   fecha: '11 de febrero 2026',
///   titulo: 'Formularios',
///   color: Colors.orange,
///   icono: Icons.edit,
/// )
/// 
/// Resultado: Encabezado naranja con icono de edición

/// EJEMPLO 4: Con subtítulo
/// 
/// MyLessonHeader(
///   fecha: '12 de febrero 2026',
///   titulo: 'Animaciones Avanzadas',
///   color: Colors.purple,
///   icono: Icons.animation,
///   subtitulo: 'Aprende a crear transiciones suaves',
/// )
/// 
/// Resultado: Encabezado púrpura con subtítulo descriptivo

/// EJEMPLO 5: En un Scaffold completo
/// 
/// @override
/// Widget build(BuildContext context) {
///   return Scaffold(
///     appBar: AppBar(title: const Text('Lección del Día')),
///     body: SingleChildScrollView(
///       child: Column(
///         children: [
///           MyLessonHeader(
///             fecha: '13 de febrero 2026',
///             titulo: 'Navegación Avanzada',
///             color: Colors.blue,
///             icono: Icons.navigation,
///             subtitulo: 'Go Router y rutas complejas',
///           ),
///           // Resto del contenido aquí
///         ],
///       ),
///     ),
///   );
/// }

/// ═══════════════════════════════════════════════════════════════════════════
/// TABLA DE COLORES SUGERIDOS POR TEMA
/// ═══════════════════════════════════════════════════════════════════════════

/// Tema                          Color             Icono
/// ──────────────────────────────────────────────────────────
/// Enrutamiento                  Colors.blue       Icons.navigation
/// Widgets Básicos               Colors.teal       Icons.widgets
/// Formularios                   Colors.orange     Icons.edit
/// Animaciones                   Colors.purple     Icons.animation
/// Gestión de Estado             Colors.green      Icons.storage
/// Networking / APIs             Colors.indigo     Icons.cloud
/// Persistencia de Datos         Colors.brown      Icons.storage
/// Testing                       Colors.red        Icons.verified
/// Performance                   Colors.pink       Icons.speed
/// Firebase                      Colors.amber      Icons.local_fire_department
/// Responsive Design             Colors.cyan       Icons.devices
/// Internacionalización          Colors.blue       Icons.language

/// ═══════════════════════════════════════════════════════════════════════════
/// CÓMO USAR EN tus archivos dia_x_x.dart
/// ═══════════════════════════════════════════════════════════════════════════

/// 1. Importa el widget
/// ```dart
/// import 'my_lesson_header.dart';
/// ```
/// 
/// 2. Usa en tu body o en un Column
/// ```dart
/// body: SingleChildScrollView(
///   child: Column(
///     children: [
///       MyLessonHeader(
///         fecha: '9 de febrero 2026',
///         titulo: 'Enrutamiento en Flutter',
///         color: Colors.blue,
///         icono: Icons.navigation,
///       ),
///       // Resto del contenido
///     ],
///   ),
/// ),
/// ```
/// 
/// ¡Así mantendrás consistencia visual en todas tus lecciones!

/// ═══════════════════════════════════════════════════════════════════════════
/// VENTAJAS DE USAR WIDGETS PERSONALIZADOS COMO ESTE
/// ═══════════════════════════════════════════════════════════════════════════

/// 1. DRY (Don't Repeat Yourself)
///    ✅ Escribes una vez, usas en muchos lugares
///    ✅ Cambios globales son fáciles
/// 
/// 2. Consistencia
///    ✅ Todas las lecciones tienen el mismo estilo
///    ✅ Mejor experiencia para estudiantes
/// 
/// 3. Mantenibilidad
///    ✅ Si quieres cambiar el diseño, lo haces aquí
///    ✅ No necesitas buscar múltiples archivos
/// 
/// 4. Parámetros
///    ✅ Altamente personalizable
///    ✅ Flexible pero consistente
/// 
/// 5. Reusabilidad
///    ✅ Puedes usar en otros proyectos
///    ✅ Acelera el desarrollo
