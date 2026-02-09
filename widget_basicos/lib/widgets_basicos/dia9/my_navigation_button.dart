import 'package:flutter/material.dart';

/// 🔘 MY NAVIGATION BUTTON - BOTÓN DE NAVEGACIÓN PERSONALIZADO
/// 
/// Widget reutilizable para botones que navegan a diferentes rutas.
/// Simplifica la creación de botones de navegación consistentes.
/// 
/// VENTAJAS:
/// ✅ Reutilizable en múltiples pantallas
/// ✅ Consistencia visual
/// ✅ Reducir código duplicado
/// ✅ Fácil de personalizar
/// ✅ Manejo de navegación integrado
/// 
/// EJEMPLO DE USO BÁSICO:
/// 
/// MyNavigationButton(
///   icon: Icons.notifications,
///   title: 'SnackBar',
///   description: 'Notificaciones temporales',
///   color: Colors.deepOrange,
///   routeName: '/snackbar',
///   onTap: () => Navigator.pushNamed(context, '/snackbar'),
/// )



class MyNavigationButton extends StatelessWidget {
  /// Icono que aparece a la izquierda
  final IconData icon;
  
  /// Título principal del botón
  final String title;
  
  /// Descripción o subtítulo
  final String description;
  
  /// Color principal (icono, flecha, etc.)
  final Color color;
  
  /// Nombre de la ruta a la que navegar
  final String routeName;
  
  /// Contexto necesario para la navegación
  final BuildContext context;
  
  /// Anchura del recuadro del icono (por defecto: 60)
  final double iconBoxSize;
  
  /// Tamaño del icono (por defecto: 30)
  final double iconSize;
  
  /// Elevación de la Card (por defecto: 4)
  final double elevation;
  
  /// Radio de los bordes redondeados (por defecto: 15)
  final double borderRadius;
  
  /// Callback adicional (optativo)
  /// Se ejecuta antes de navegar
  final VoidCallback? onBeforeNavigate;

  const MyNavigationButton({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
    required this.routeName,
    required this.context,
    this.iconBoxSize = 60,
    this.iconSize = 30,
    this.elevation = 4,
    this.borderRadius = 15,
    this.onBeforeNavigate,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      /// Sombra del botón
      elevation: elevation,
      
      /// Bordes redondeados
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      
      /// ListTile para un layout profesional
      child: ListTile(
        /// PARTE IZQUIERDA: Icono en recuadro
        leading: Container(
          width: iconBoxSize,
          height: iconBoxSize,
          decoration: BoxDecoration(
            /// Color de fondo: versión clara del color principal
            color: color.withAlpha(50), // Aproximadamente 0.2 opacidad
            borderRadius: BorderRadius.circular(10),
          ),
          /// Icono centrado
          child: Icon(icon, color: color, size: iconSize),
        ),
        
        /// PARTE CENTRAL: Título y descripción
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(description),
        
        /// PARTE DERECHA: Flecha indicadora
        trailing: Icon(Icons.arrow_forward, color: color),
        
        /// ACCIÓN: Al tocar el botón
        onTap: () {
          /// Ejecutar callback adicional si existe
          onBeforeNavigate?.call();
          
          /// Navegar a la ruta especificada
          Navigator.pushNamed(context, routeName);
        },
      ),
    );
  }
}

/// ═══════════════════════════════════════════════════════════════════════════
/// EJEMPLOS DE USO COMPLETOS
/// ═══════════════════════════════════════════════════════════════════════════

/// EJEMPLO 1: Uso básico
/// 
/// MyNavigationButton(
///   icon: Icons.notifications,
///   title: 'SnackBar',
///   description: 'Notificaciones temporales',
///   color: Colors.deepOrange,
///   routeName: '/snackbar',
///   context: context,
/// )

/// EJEMPLO 2: Con todos los parámetros
/// 
/// MyNavigationButton(
///   icon: Icons.image,
///   title: 'Imágenes',
///   description: 'Gestión de imágenes en Flutter',
///   color: Colors.green,
///   routeName: '/images',
///   context: context,
///   iconBoxSize: 70,
///   iconSize: 35,
///   elevation: 6,
///   borderRadius: 20,
///   onBeforeNavigate: () {
///     print('Navegando a imágenes...');
///   },
/// )

/// EJEMPLO 3: En un Column con múltiples botones
/// 
/// Column(
///   children: [
///     MyNavigationButton(
///       icon: Icons.notifications,
///       title: 'SnackBar',
///       description: 'Ver ejemplos de SnackBar',
///       color: Colors.deepOrange,
///       routeName: '/snackbar',
///       context: context,
///     ),
///     const SizedBox(height: 20),
///     MyNavigationButton(
///       icon: Icons.image,
///       title: 'Imágenes',
///       description: 'Ver gestión de imágenes',
///       color: Colors.green,
///       routeName: '/images',
///       context: context,
///     ),
///     const SizedBox(height: 20),
///     MyNavigationButton(
///       icon: Icons.list,
///       title: 'ListViews',
///       description: 'Ver ejemplos de listas',
///       color: Colors.purple,
///       routeName: '/listview',
///       context: context,
///     ),
///   ],
/// )

/// EJEMPLO 4: Con callback antes de navegar
/// 
/// MyNavigationButton(
///   icon: Icons.home,
///   title: 'Inicio',
///   description: 'Volver a la pantalla principal',
///   color: Colors.blue,
///   routeName: '/home',
///   context: context,
///   onBeforeNavigate: () {
///     // Guardar datos o mostrar animación
///     ScaffoldMessenger.of(context).showSnackBar(
///       const SnackBar(content: Text('Cargando...')),
///     );
///   },
/// )

/// ═══════════════════════════════════════════════════════════════════════════
/// TABLA DE COLORES Y ICONOS RECOMENDADOS
/// ═══════════════════════════════════════════════════════════════════════════

/// Tema / Módulo                Color             Icono
/// ──────────────────────────────────────────────────────────
/// SnackBar                      DeepOrange        notifications
/// Imágenes                      Green             image
/// ListView                      Purple            list
/// Formularios                   Orange            edit
/// Scaffold                      Blue              layers
/// Animaciones                   Pink              animation
/// Gestor de Estado              Indigo            storage
/// Networking                    Cyan              cloud
/// Persistencia de Datos         Brown             folder
/// Firebase                      Amber             local_fire_dept
/// Testing                       Red               verified
/// Responsive Design             Teal              devices

/// ═══════════════════════════════════════════════════════════════════════════
/// VENTAJAS DE USAR ESTE WIDGET
/// ═══════════════════════════════════════════════════════════════════════════

/// 1. CONSISTENCIA
///    ✅ Todos los botones tienen el mismo estilo
///    ✅ Fácil reconocimiento para los estudiantes
/// 
/// 2. REUTILIZACIÓN
///    ✅ Usa una vez, utiliza en muchos lugares
///    ✅ Cambios globales en un solo archivo
/// 
/// 3. MANTENIBILIDAD
///    ✅ Si necesitas cambiar el diseño, lo haces aquí
///    ✅ No necesitas buscar múltiples archivos
/// 
/// 4. FLEXIBILIDAD
///    ✅ Personalizable sin limitar funcionalidad
///    ✅ Parámetros opcionales con valores por defecto
/// 
/// 5. EDUCATIVO
///    ✅ Los estudiantes aprenden a criar widgets reutilizables
///    ✅ Entienden el concepto de composición
/// 
/// ═══════════════════════════════════════════════════════════════════════════
/// COMPARACIÓN: CON vs SIN widget personalizado
/// ═══════════════════════════════════════════════════════════════════════════

/// SIN el widget (mucho código):
/// 
/// _buildNavigationButton(
///   context,
///   icon: Icons.notifications,
///   title: 'SnackBar',
///   description: 'Notificaciones temporales',
///   color: Colors.deepOrange,
///   routeName: '/snackbar',
/// )
/// 
/// // Necesitas un método _buildNavigationButton en la clase

/// CON el widget (código limpio):
/// 
/// MyNavigationButton(
///   icon: Icons.notifications,
///   title: 'SnackBar',
///   description: 'Notificaciones temporales',
///   color: Colors.deepOrange,
///   routeName: '/snackbar',
///   context: context,
/// )
/// 
/// // Simplificas la lógica de tu pantalla
