import 'package:flutter/material.dart';

/// 🖼️ ARCHIVO EDUCATIVO: Cómo usar imágenes en Flutter
/// Para EXPLICAR a alumnos de 5 años qué son y cómo funcionan las imágenes
/// Versión SIMPLIFICADA: Ejemplos inline sin helper classes

/// ═══════════════════════════════════════════════════════════════════════════
/// 📱 REQUISITOS PARA ANDROID
/// ═══════════════════════════════════════════════════════════════════════════
/// 
/// Android es como un teléfono con MUCHAS pantallas diferentes.
/// Algunos teléfonos tienen pantallas pequeñas, otros grandes, otros enormes.
/// 
/// 📂 ESTRUCTURA DE CARPETAS:
/// Necesitas crear estas carpetas en: android/app/src/main/res/
/// 
/// drawable/        → Imágenes tamaño NORMAL (160 dp)
/// drawable-hdpi/   → Imágenes para pantallas ALTAS (240 dp) 
/// drawable-xhdpi/  → Imágenes para pantallas MUY ALTAS (320 dp)
/// drawable-xxhdpi/ → Imágenes para pantallas ENORMES (480 dp)
/// 
/// 🖼️ LAS MISMAS IMÁGENES, DIFERENTES TAMAÑOS:
/// Si tu logo es 100x100 píxeles:
/// - Pon 100x100 en drawable/
/// - Pon 150x150 en drawable-hdpi/
/// - Pon 200x200 en drawable-xhdpi/
/// - Pon 300x300 en drawable-xxhdpi/
/// 
/// 💡 Flutter automáticamente elige la carpeta correcta según la pantalla.
/// ¡No necesitas código especial, solo organizar bien las carpetas!
/// 
/// ⚠️ PERMISOS EN ANDROID:
/// Para acceder a imágenes desde Internet (Image.network):
/// → Necesitas permiso en: android/app/src/main/AndroidManifest.xml
/// → Agrega esta línea:
///    <uses-permission android:name="android.permission.INTERNET" />
/// 
/// Para acceder a imágenes desde ARCHIVOS del teléfono:
/// → Necesitas en: android/app/build.gradle
///    compileSdkVersion 33 (o superior)
///    targetSdkVersion 33 (o superior)
/// 
/// ═══════════════════════════════════════════════════════════════════════════
/// 🍎 REQUISITOS PARA iOS
/// ═══════════════════════════════════════════════════════════════════════════
/// 
/// iOS es diferente. Los iPhones son más "uniformes" (todos parecido).
/// Pero tienen algo especial: las pantallas RETINA.
/// 
/// 📁 ESTRUCTURA:
/// iOS guarda imágenes en: ios/Runner/Assets.xcassets/
/// 
/// Cada imagen necesita 3 VERSIONES (según la pantalla):
/// 1x  → Pantalla normal (iPhone básico)
/// 2x  → Pantalla Retina (iPhone 6/7/8)
/// 3x  → Pantalla Super Retina (iPhone XS/Pro)
/// 
/// 🖼️ LAS MISMAS IMÁGENES, DIFERENTES RESOLUCIONES:
/// Si tu logo es 100x100:
/// - Versión 1x:  100x100  píxeles
/// - Versión 2x:  200x200  píxeles
/// - Versión 3x:  300x300  píxeles
/// 
/// 💡 Flutter automáticamente elige según la pantalla del iPhone.
/// Los Assets.xcassets se crean automáticamente si usas Image.asset()
/// 
/// ⚠️ PERMISOS EN iOS:
/// Para acceder a imágenes desde Internet (Image.network):
/// → NO necesitas hacer nada especial en iOS. Funciona directo.
/// 
/// Para acceder a la CÁMARA o GALERÍA del teléfono:
/// → Necesitas permisos en: ios/Runner/Info.plist
///    <key>NSPhotoLibraryUsageDescription</key>
///    <string>Necesitamos acceso a tus fotos</string>
///    <key>NSCameraUsageDescription</key>
///    <string>Necesitamos acceso a la cámara</string>
/// 
/// ═══════════════════════════════════════════════════════════════════════════
/// 💡 RESUMEN RÁPIDO
/// ═══════════════════════════════════════════════════════════════════════════
/// 
/// Image.asset('ruta'):
///   ✅ Android: Carpetas drawable/ drawable-hdpi/ drawable-xhdpi/
///   ✅ iOS:     Assets.xcassets (automático)
///   ✅ Permiso:  NO necesita permiso de internet (está en el proyecto)
/// 
/// Image.network('url'):
///   ✅ Android: Necesita <uses-permission android:name="android.permission.INTERNET" />
///   ✅ iOS:     No necesita nada especial
///   ⚠️  Permiso: NECESITA internet para descargar
/// 
/// ═══════════════════════════════════════════════════════════════════════════

/// 🏠 WIDGET PRINCIPAL: MyImages
/// Es el punto de entrada de esta pantalla educativa
class MyImages extends StatelessWidget {
  const MyImages({super.key});

  /// 🎨 MÉTODO BUILD: Construye la interfaz
  /// Devuelve un Scaffold con AppBar y cuerpo con ejemplos
  @override
  Widget build(BuildContext context) {
    /// 📱 Scaffold: Estructura básica de una pantalla en Flutter
    return Scaffold(
      /// 📱 AppBar: La barra superior con el título
      appBar: AppBar(
        title: const Text('🖼️ Imágenes en Flutter'),
        backgroundColor: Colors.purple,
      ),
      /// 📜 body: El contenido principal que se puede desplazar
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              /// ═══════════════════════════════════════════════════════
              /// 📁 OPCIÓN 1: Imágenes desde ASSETS (carpeta del proyecto)
              /// ═══════════════════════════════════════════════════════
              Text(
                '📁 OPCIÓN 1: Imágenes desde ASSETS',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Las imágenes que guardas EN TU PROYECTO. Como fotos en una carpeta de tu ordenador.',
                style: TextStyle(fontSize: 13, color: Colors.blue),
              ),
              const SizedBox(height: 12),

              /// Paso 1: Crear carpeta
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '🔧 Paso 1: Crear carpeta de imágenes',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '📌 IMPORTANTE PARA ANDROID Y iOS:\n'
                      'Esta carpeta "assets/" es igual para AMBAS plataformas.\n'
                      'Flutter automáticamente la usa en Android e iOS.\n'
                      'No necesitas crear carpetas separadas en cada plataforma.',
                      style: TextStyle(fontSize: 11, color: Colors.blue, fontStyle: FontStyle.italic),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Text(
                        'Tu proyecto/\\n  assets/\\n    images/\\n      logo.png\\n      perfil.png',
                        style: TextStyle(fontSize: 11, fontFamily: 'Courier'),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              /// Paso 2: Editar pubspec.yaml
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '🔧 Paso 2: Editar pubspec.yaml',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '📌 IMPORTANTE:\n'
                      'El pubspec.yaml es como un "REGISTRO" que le dice a Flutter dónde están tus imágenes.\n'
                      'Es usado por AMBAS plataformas (Android e iOS).\n'
                      'Sin esto, Flutter NO encuentra tus imágenes.',
                      style: TextStyle(fontSize: 11, color: Colors.blue, fontStyle: FontStyle.italic),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Text(
                        'flutter:\\n'
                        '  assets:\\n'
                        '    - assets/images/',
                        style: TextStyle(fontSize: 11, fontFamily: 'Courier'),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '💡 Esto le dice a Flutter: "Hay imágenes en esta carpeta, guárdalas"\n'
                      '⚠️ CUIDADO CON LOS ESPACIOS: Usa espacios, no tabulaciones (TAB)',
                      style: TextStyle(fontSize: 11, color: Colors.blue, fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              /// Paso 3: Usar en código
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '🔧 Paso 3: Usar en tu código',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '📌 QUÉ PASA EN ANDROID:\n'
                      '• Flutter busca en: android/app/src/main/res/drawable*\n'
                      '• Elige automáticamente según el tamaño de pantalla\n'
                      '• NO necesitas código especial, Flutter lo hace solo\n\n'
                      '📌 QUÉ PASA EN iOS:\n'
                      '• Flutter copia la imagen a Assets.xcassets\n'
                      '• Elige automáticamente 1x, 2x o 3x según la pantalla\n'
                      '• También automático, sin código extra',
                      style: TextStyle(fontSize: 11, color: Colors.blue, fontStyle: FontStyle.italic),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Text(
                        'Image.asset(\\n'
                        '  \'assets/images/logo.png\',\\n'
                        '  width: 100,\\n'
                        '  height: 100,\\n'
                        ')',
                        style: TextStyle(fontSize: 11, fontFamily: 'Courier'),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '✅ Ventajas: Rápido, no necesita internet, siempre está disponible\n'
                      '✅ Flutter maneja toda la magia de pantallas automáticamente',
                      style: TextStyle(fontSize: 11, color: Colors.blue),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              /// ═══════════════════════════════════════════════════════
              /// 🌐 OPCIÓN 2: Imágenes desde INTERNET (URLs)
              /// ═══════════════════════════════════════════════════════
              Text(
                '🌐 OPCIÓN 2: Imágenes desde INTERNET (URLs)',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Imágenes que descargas de internet. Como ir a Google Images y poner una foto.',
                style: TextStyle(fontSize: 13, color: Colors.green),
              ),
              const SizedBox(height: 12),

              /// Ejemplo URL
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.green),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Sintaxis:',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '📌 REQUISITOS PARA ANDROID:\n'
                      '• Necesita permiso en AndroidManifest.xml:\n'
                      '  <uses-permission android:name="android.permission.INTERNET" />\n'
                      '• Sin esto, la app NO puede descargar imágenes de internet\n\n'
                      '📌 REQUISITOS PARA iOS:\n'
                      '• NO necesita nada especial, funciona directo\n'
                      '• iOS confía en que tienes derecho a acceder a internet\n'
                      '• (A menos que quieras usar HTTPS, que es lo normal)',
                      style: TextStyle(fontSize: 11, color: Colors.green, fontStyle: FontStyle.italic),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Text(
                        'Image.network(\\n'
                        '  \'https://ejemplo.com/foto.png\',\\n'
                        '  width: 200,\\n'
                        '  height: 200,\\n'
                        ')',
                        style: TextStyle(fontSize: 11, fontFamily: 'Courier'),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      '⚠️ IMPORTANTE: Necesita internet para descargar la imagen\n'
                      '⚠️ Android requiere el permiso de INTERNET\n'
                      '⚠️ iOS funciona sin permisos adicionales',
                      style: TextStyle(fontSize: 11, color: Colors.orange, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              /// Ejemplo real
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.green),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Ejemplo en la app:',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Text(
                        'Image.network(\\n'
                        '  \'https://flutter.dev/images/flutter-mark-square-100.png\',\\n'
                        '  width: 100,\\n'
                        '  height: 100,\\n'
                        ')',
                        style: TextStyle(fontSize: 11, fontFamily: 'Courier'),
                      ),
                    ),
                    const SizedBox(height: 12),
                    /// Mostrar imagen de ejemplo
                    Center(
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green, width: 2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Image.network(
                          'https://flutter.dev/images/flutter-mark-square-100.png',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(Icons.image_not_supported),
                                  SizedBox(height: 4),
                                  Text('No disponible', style: TextStyle(fontSize: 10)),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '✅ Ventajas: Puedes cambiar imágenes sin recompilar la app',
                      style: TextStyle(fontSize: 11, color: Colors.green),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              /// ═══════════════════════════════════════════════════════
              /// 📊 COMPARACIÓN
              /// ═══════════════════════════════════════════════════════
              Text(
                '📊 COMPARACIÓN RÁPIDA',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber,
                ),
              ),
              const SizedBox(height: 12),

              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.amber[50],
                  border: Border.all(color: Colors.amber),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(child: Text('Aspecto', style: TextStyle(fontWeight: FontWeight.bold))),
                        Expanded(child: Container(padding: const EdgeInsets.all(8), color: Colors.blue[100], child: const Text('Assets'))),
                        Expanded(child: Container(padding: const EdgeInsets.all(8), color: Colors.green[100], child: const Text('Network'))),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(child: Text('Velocidad', style: TextStyle(fontWeight: FontWeight.bold))),
                        Expanded(child: Container(padding: const EdgeInsets.all(8), color: Colors.blue[100], child: const Text('⚡ Muy rápido'))),
                        Expanded(child: Container(padding: const EdgeInsets.all(8), color: Colors.green[100], child: const Text('⏳ Depende internet'))),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(child: Text('Necesita internet', style: TextStyle(fontWeight: FontWeight.bold))),
                        Expanded(child: Container(padding: const EdgeInsets.all(8), color: Colors.blue[100], child: const Text('❌ No'))),
                        Expanded(child: Container(padding: const EdgeInsets.all(8), color: Colors.green[100], child: const Text('✅ Sí'))),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(child: Text('Cambiar sin compilar', style: TextStyle(fontWeight: FontWeight.bold))),
                        Expanded(child: Container(padding: const EdgeInsets.all(8), color: Colors.blue[100], child: const Text('❌ No'))),
                        Expanded(child: Container(padding: const EdgeInsets.all(8), color: Colors.green[100], child: const Text('✅ Sí'))),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(child: Text('Uso típico', style: TextStyle(fontWeight: FontWeight.bold))),
                        Expanded(child: Container(padding: const EdgeInsets.all(8), color: Colors.blue[100], child: const Text('Logo, iconos'))),
                        Expanded(child: Container(padding: const EdgeInsets.all(8), color: Colors.green[100], child: const Text('Fotos de usuarios'))),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              /// ═══════════════════════════════════════════════════════
              /// 💡 CONSEJOS
              /// ═══════════════════════════════════════════════════════
              Text(
                '💡 CONSEJOS',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              const SizedBox(height: 12),

              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.teal[50],
                  border: Border.all(color: Colors.teal),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '✅ Usa Assets (Image.asset) para:',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.teal),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '🎨 Logos de tu app\n'
                      '🎨 Iconos personalizados\n'
                      '🎨 Fondos (backgrounds)\n'
                      '🎨 Imágenes que NO cambian',
                      style: TextStyle(fontSize: 12, color: Colors.teal),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      '✅ Usa Network (Image.network) para:',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.teal),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '📸 Fotos de usuarios\n'
                      '📸 Contenido que cambia\n'
                      '📸 Imágenes de redes sociales\n'
                      '📸 Imágenes que se actualizan',
                      style: TextStyle(fontSize: 12, color: Colors.teal),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      '⚡ PRO TIP: Combina ambas. Usa Assets para lo que es tuyo, Network para lo de los usuarios.',
                      style: TextStyle(fontSize: 12, color: Colors.teal, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              /// ═══════════════════════════════════════════════════════
              /// 🔧 OPCIONES ÚTILES
              /// ═══════════════════════════════════════════════════════
              Text(
                '🔧 OPCIONES ÚTILES',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
              ),
              const SizedBox(height: 12),

              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.indigo[50],
                  border: Border.all(color: Colors.indigo),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'fit: BoxFit.cover',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo, fontSize: 12),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: const Text(
                        'Image.asset(\'assets/images/foto.png\',\n  fit: BoxFit.cover,\n)',
                        style: TextStyle(fontSize: 10, fontFamily: 'Courier'),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '💡 La imagen rellena todo el espacio sin deformarse',
                      style: TextStyle(fontSize: 11, color: Colors.indigo),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'fit: BoxFit.contain',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo, fontSize: 12),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: const Text(
                        'Image.asset(\'assets/images/foto.png\',\n  fit: BoxFit.contain,\n)',
                        style: TextStyle(fontSize: 10, fontFamily: 'Courier'),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '💡 La imagen completa se ve, sin recortar, con espacios en blanco si es necesario',
                      style: TextStyle(fontSize: 11, color: Colors.indigo),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'fit: BoxFit.fill',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo, fontSize: 12),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: const Text(
                        'Image.asset(\'assets/images/foto.png\',\n  fit: BoxFit.fill,\n)',
                        style: TextStyle(fontSize: 10, fontFamily: 'Courier'),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '⚠️ La imagen se estira para llenar el espacio (puede deformarse)',
                      style: TextStyle(fontSize: 11, color: Colors.orange),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              /// ═══════════════════════════════════════════════════════
              /// 🎨 OPCIONES AVANZADAS
              /// ═══════════════════════════════════════════════════════
              Text(
                '🎨 OPCIONES AVANZADAS',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
              ),
              const SizedBox(height: 12),

              /// Opción 1: Bordes redondeados
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.purple[50],
                  border: Border.all(color: Colors.purple),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '🔲 Bordes Redondeados',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.purple, fontSize: 12),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: const Text(
                        'ClipRRect(\n'
                        '  borderRadius: BorderRadius.circular(10),\n'
                        '  child: Image.asset(\'assets/images/foto.png\',\n'
                        '    width: 100,\n'
                        '    height: 100,\n'
                        '    fit: BoxFit.cover,\n'
                        '  ),\n'
                        ')',
                        style: TextStyle(fontSize: 10, fontFamily: 'Courier'),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '💡 ClipRRect recorta la imagen con esquinas redondeadas\n'
                      '✅ Perfecto para avatares de usuarios',
                      style: TextStyle(fontSize: 11, color: Colors.purple),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// Opción 2: Transparencia
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.purple[50],
                  border: Border.all(color: Colors.purple),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '👻 Transparencia (Opacity)',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.purple, fontSize: 12),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: const Text(
                        'Opacity(\n'
                        '  opacity: 0.5,  // 0 = invisible, 1 = visible\n'
                        '  child: Image.asset(\'assets/images/foto.png\'),\n'
                        ')',
                        style: TextStyle(fontSize: 10, fontFamily: 'Courier'),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '💡 Hace la imagen semi-transparente\n'
                      '✅ Útil para watermarks o fondos',
                      style: TextStyle(fontSize: 11, color: Colors.purple),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// Opción 3: Sombra
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.purple[50],
                  border: Border.all(color: Colors.purple),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '✨ Sombra (BoxShadow)',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.purple, fontSize: 12),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: const Text(
                        'Container(\n'
                        '  decoration: BoxDecoration(\n'
                        '    boxShadow: [\n'
                        '      BoxShadow(\n'
                        '        color: Colors.black.withOpacity(0.3),\n'
                        '        blurRadius: 10,\n'
                        '        offset: Offset(0, 4),\n'
                        '      ),\n'
                        '    ],\n'
                        '  ),\n'
                        '  child: Image.asset(\'assets/images/foto.png\'),\n'
                        ')',
                        style: TextStyle(fontSize: 9, fontFamily: 'Courier'),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '💡 Agrega sombra debajo de la imagen\n'
                      '✅ Hace la imagen más destacada y profesional',
                      style: TextStyle(fontSize: 11, color: Colors.purple),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// Opción 4: Filtros de color
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.purple[50],
                  border: Border.all(color: Colors.purple),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '🎬 Filtros de Color',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.purple, fontSize: 12),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: const Text(
                        'Image.asset(\n'
                        '  \'assets/images/foto.png\',\n'
                        '  color: Colors.blue,\n'
                        '  colorBlendMode: BlendMode.overlay,\n'
                        ')',
                        style: TextStyle(fontSize: 10, fontFamily: 'Courier'),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '💡 Aplica un filtro de color a la imagen\n'
                      '✅ Modos: multiply, screen, overlay, colorDodge...\n'
                      '✅ Útil para efectos artísticos',
                      style: TextStyle(fontSize: 11, color: Colors.purple),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// Opción 5: Manejo de errores
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.purple[50],
                  border: Border.all(color: Colors.purple),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '⚠️ Manejar Errores (Image.network)',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.purple, fontSize: 12),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: const Text(
                        'Image.network(\n'
                        '  \'https://ejemplo.com/foto.png\',\n'
                        '  errorBuilder: (context, error, stackTrace) {\n'
                        '    return Container(\n'
                        '      color: Colors.grey[300],\n'
                        '      child: Icon(Icons.image_not_supported),\n'
                        '    );\n'
                        '  },\n'
                        ')',
                        style: TextStyle(fontSize: 9, fontFamily: 'Courier'),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '💡 Si la imagen no carga, muestra algo alternativo\n'
                      '✅ Mejora la experiencia del usuario',
                      style: TextStyle(fontSize: 11, color: Colors.purple),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// Opción 6: Indicador de carga
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.purple[50],
                  border: Border.all(color: Colors.purple),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '⏳ Mostrar indicador mientras carga',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.purple, fontSize: 12),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: const Text(
                        'Image.network(\n'
                        '  \'https://ejemplo.com/foto.png\',\n'
                        '  loadingBuilder: (context, child, progress) {\n'
                        '    if (progress == null) return child;\n'
                        '    return CircularProgressIndicator(\n'
                        '      value: progress.expectedTotalBytes != null\n'
                        '        ? progress.cumulativeBytesLoaded / progress.expectedTotalBytes!\n'
                        '        : null,\n'
                        '    );\n'
                        '  },\n'
                        ')',
                        style: TextStyle(fontSize: 8, fontFamily: 'Courier'),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '💡 Muestra un spinner mientras descarga la imagen\n'
                      '✅ El usuario sabe que algo está ocurriendo',
                      style: TextStyle(fontSize: 11, color: Colors.purple),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// Opción 7: Cache
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.purple[50],
                  border: Border.all(color: Colors.purple),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '💾 Optimización con Cache',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.purple, fontSize: 12),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: const Text(
                        'Image.network(\n'
                        '  \'https://ejemplo.com/foto.png\',\n'
                        '  cacheHeight: 400,\n'
                        '  cacheWidth: 400,\n'
                        ')',
                        style: TextStyle(fontSize: 10, fontFamily: 'Courier'),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '💡 Cachea la imagen con tamaño máximo especificado\n'
                      '✅ Ahorra memoria y acelera cargas futuras\n'
                      '✅ Flutter automáticamente cachea imágenes de network',
                      style: TextStyle(fontSize: 11, color: Colors.purple),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// Opción 8: Imagen con Hero Animation
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.purple[50],
                  border: Border.all(color: Colors.purple),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '✨ Hero Animation (Zoom al hacer click)',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.purple, fontSize: 12),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: const Text(
                        'GestureDetector(\n'
                        '  onTap: () {\n'
                        '    Navigator.push(context, MaterialPageRoute(\n'
                        '      builder: (context) => FullScreenImage(),\n'
                        '    ));\n'
                        '  },\n'
                        '  child: Hero(\n'
                        '    tag: \'foto\',\n'
                        '    child: Image.asset(\'assets/images/foto.png\'),\n'
                        '  ),\n'
                        ')',
                        style: TextStyle(fontSize: 9, fontFamily: 'Courier'),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '💡 Hero animation hace un zoom suave cuando abres la imagen\n'
                      '✅ Crea transiciones profesionales y fluidas',
                      style: TextStyle(fontSize: 11, color: Colors.purple),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              /// ═══════════════════════════════════════════════════════
              /// 📋 RESUMEN DE OPCIONES
              /// ═══════════════════════════════════════════════════════
              Text(
                '📋 RESUMEN DE OPCIONES',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 12),

              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  border: Border.all(color: Colors.grey[400]!),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Layout:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                    Text('  • fit: BoxFit (cover, contain, fill...)', style: TextStyle(fontSize: 11)),
                    SizedBox(height: 8),
                    Text('Decoración:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                    Text('  • ClipRRect: Bordes redondeados', style: TextStyle(fontSize: 11)),
                    Text('  • BoxShadow: Sombra', style: TextStyle(fontSize: 11)),
                    Text('  • Opacity: Transparencia', style: TextStyle(fontSize: 11)),
                    SizedBox(height: 8),
                    Text('Efectos:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                    Text('  • color + colorBlendMode: Filtros', style: TextStyle(fontSize: 11)),
                    Text('  • Hero: Animación al hacer click', style: TextStyle(fontSize: 11)),
                    SizedBox(height: 8),
                    Text('Red/Cache:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                    Text('  • errorBuilder: Manejar errores', style: TextStyle(fontSize: 11)),
                    Text('  • loadingBuilder: Indicador de carga', style: TextStyle(fontSize: 11)),
                    Text('  • cacheHeight/cacheWidth: Optimización', style: TextStyle(fontSize: 11)),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              /// ═══════════════════════════════════════════════════════
              /// 📸 FORMAS COMUNES DE MOSTRAR IMÁGENES
              /// ═══════════════════════════════════════════════════════
              Text(
                '📸 FORMAS COMUNES DE MOSTRAR IMÁGENES',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.cyan,
                ),
              ),
              const SizedBox(height: 12),

              /// Forma 1: CircleAvatar
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.cyan[50],
                  border: Border.all(color: Colors.cyan),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '👤 CircleAvatar (Avatar redondo)',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.cyan, fontSize: 12),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: const Text(
                        'CircleAvatar(\n'
                        '  radius: 50,\n'
                        '  backgroundImage: AssetImage(\'assets/images/avatar.png\'),\n'
                        '  backgroundColor: Colors.grey,\n'
                        ')',
                        style: TextStyle(fontSize: 10, fontFamily: 'Courier'),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '💡 Perfecto para perfiles de usuario\n'
                      '✅ Automáticamente redondo\n'
                      '✅ Puede tener fallback color\n'
                      '✅ Acepta child widget en su lugar',
                      style: TextStyle(fontSize: 11, color: Colors.cyan),
                    ),
                    const SizedBox(height: 8),
                    Center(
                      child: CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage(
                          'assets/images/avatar.png',
                        ),
                        backgroundColor: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// Forma 2: Image en Container con decoración
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.cyan[50],
                  border: Border.all(color: Colors.cyan),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '📦 Image dentro de Container decorado',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.cyan, fontSize: 12),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: const Text(
                        'Container(\n'
                        '  width: 150,\n'
                        '  height: 150,\n'
                        '  decoration: BoxDecoration(\n'
                        '    image: DecorationImage(\n'
                        '      image: AssetImage(\'assets/images/foto.png\'),\n'
                        '      fit: BoxFit.cover,\n'
                        '    ),\n'
                        '    borderRadius: BorderRadius.circular(12),\n'
                        '    boxShadow: [BoxShadow(...)],\n'
                        '  ),\n'
                        ')',
                        style: TextStyle(fontSize: 9, fontFamily: 'Courier'),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '💡 Más flexible que Image widget\n'
                      '✅ Permite combinar imagen + decoración + sombra\n'
                      '✅ Podés agregar widgets encima con Stack',
                      style: TextStyle(fontSize: 11, color: Colors.cyan),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// Forma 3: FadeInImage
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.cyan[50],
                  border: Border.all(color: Colors.cyan),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '🌅 FadeInImage (Transición suave)',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.cyan, fontSize: 12),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: const Text(
                        'Image.asset(\n'
                        '  \'assets/images/foto.png\',\n'
                        '  width: 200,\n'
                        '  height: 200,\n'
                        '  fit: BoxFit.cover,\n'
                        ')',
                        style: TextStyle(fontSize: 9, fontFamily: 'Courier'),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '💡 Muestra imagen de baja calidad mientras carga\n'
                      '✅ Mejor UX que mostrar nada\n'
                      '✅ Transición suave cuando carga la final',
                      style: TextStyle(fontSize: 11, color: Colors.cyan),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// Forma 4: Image como fondo (Stack)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.cyan[50],
                  border: Border.all(color: Colors.cyan),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '🎨 Imagen como fondo (Stack)',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.cyan, fontSize: 12),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: const Text(
                        'Stack(\n'
                        '  children: [\n'
                        '    Image.asset(\'assets/images/fondo.png\',\n'
                        '      fit: BoxFit.cover,\n'
                        '      width: double.infinity,\n'
                        '      height: 300,\n'
                        '    ),\n'
                        '    Positioned(\n'
                        '      bottom: 20,\n'
                        '      left: 20,\n'
                        '      child: Text(\'Título\'),\n'
                        '    ),\n'
                        '  ],\n'
                        ')',
                        style: TextStyle(fontSize: 8, fontFamily: 'Courier'),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '💡 Superpone widgets encima de imagen\n'
                      '✅ Útil para banners con texto\n'
                      '✅ Usa Positioned para ubicar elementos',
                      style: TextStyle(fontSize: 11, color: Colors.cyan),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// Forma 5: Image en ListTile
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.cyan[50],
                  border: Border.all(color: Colors.cyan),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '📋 Imagen en ListTile (Lista)',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.cyan, fontSize: 12),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: const Text(
                        'ListTile(\n'
                        '  leading: CircleAvatar(\n'
                        '    backgroundImage: AssetImage(\'assets/images/avatar.png\'),\n'
                        '  ),\n'
                        '  title: Text(\'Nombre\'),\n'
                        '  subtitle: Text(\'Descripción\'),\n'
                        '  trailing: Icon(Icons.arrow_forward),\n'
                        ')',
                        style: TextStyle(fontSize: 9, fontFamily: 'Courier'),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '💡 Forma estándar en listas de usuarios\n'
                      '✅ leading: imagen a la izquierda\n'
                      '✅ trailing: icono a la derecha',
                      style: TextStyle(fontSize: 11, color: Colors.cyan),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// Forma 6: Image en Card
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.cyan[50],
                  border: Border.all(color: Colors.cyan),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '🃏 Imagen en Card',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.cyan, fontSize: 12),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: const Text(
                        'Card(\n'
                        '  elevation: 8,\n'
                        '  child: Column(\n'
                        '    children: [\n'
                        '      Image.asset(\'assets/images/producto.png\'),\n'
                        '      Padding(\n'
                        '        padding: EdgeInsets.all(8),\n'
                        '        child: Text(\'Producto\'),\n'
                        '      ),\n'
                        '    ],\n'
                        '  ),\n'
                        ')',
                        style: TextStyle(fontSize: 9, fontFamily: 'Courier'),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '💡 Tarjeta con imagen (estilo Pinterest)\n'
                      '✅ elevation: proporciona sombra\n'
                      '✅ Perfecto para galerías',
                      style: TextStyle(fontSize: 11, color: Colors.cyan),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// Forma 7: Image en AppBar
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.cyan[50],
                  border: Border.all(color: Colors.cyan),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '📱 Imagen en AppBar (Encabezado)',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.cyan, fontSize: 12),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: const Text(
                        'AppBar(\n'
                        '  title: Image.asset(\'assets/images/logo.png\',\n'
                        '    height: 40,\n'
                        '  ),\n'
                        '  centerTitle: true,\n'
                        '  leading: CircleAvatar(backgroundImage: AssetImage(\'assets/images/avatar.png\')),\n'
                        '  actions: [CircleAvatar(backgroundImage: AssetImage(...))],\n'
                        ')',
                        style: TextStyle(fontSize: 9, fontFamily: 'Courier'),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '💡 Logo o avatar en la barra superior\n'
                      '✅ leading: imagen a la izquierda\n'
                      '✅ actions: imagen a la derecha',
                      style: TextStyle(fontSize: 11, color: Colors.cyan),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// Forma 8: Image en FloatingActionButton
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.cyan[50],
                  border: Border.all(color: Colors.cyan),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '🎯 Imagen en FloatingActionButton',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.cyan, fontSize: 12),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: const Text(
                        'FloatingActionButton(\n'
                        '  onPressed: () {},\n'
                        '  child: Image.asset(\'assets/icono.png\',\n'
                        '    width: 30,\n'
                        '    height: 30,\n'
                        '  ),\n'
                        ')',
                        style: TextStyle(fontSize: 10, fontFamily: 'Courier'),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '💡 Usa imagen en lugar de Icon\n'
                      '✅ Permite iconos personalizados\n'
                      '✅ Más control sobre el diseño',
                      style: TextStyle(fontSize: 11, color: Colors.cyan),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// Forma 9: GridView con imágenes
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.cyan[50],
                  border: Border.all(color: Colors.cyan),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '🔲 GridView con imágenes (Galería)',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.cyan, fontSize: 12),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: const Text(
                        'GridView.builder(\n'
                        '  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(\n'
                        '    crossAxisCount: 3,\n'
                        '  ),\n'
                        '  itemBuilder: (context, index) => Image.asset(\n'
                        '    \'assets/images/foto.png\',\n'
                        '    fit: BoxFit.cover,\n'
                        '  ),\n'
                        ')',
                        style: TextStyle(fontSize: 9, fontFamily: 'Courier'),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '💡 Mostrar múltiples imágenes en grid\n'
                      '✅ Perfecto para galerías\n'
                      '✅ crossAxisCount controla columnas',
                      style: TextStyle(fontSize: 11, color: Colors.cyan),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// Forma 10: Imagen con BorderRadius
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.cyan[50],
                  border: Border.all(color: Colors.cyan),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '⬜ Imagen rectangular con esquinas redondeadas',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.cyan, fontSize: 12),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: const Text(
                        'Container(\n'
                        '  decoration: BoxDecoration(\n'
                        '    borderRadius: BorderRadius.circular(12),\n'
                        '    image: DecorationImage(\n'
                        '      image: AssetImage(\'assets/images/banner.png\'),\n'
                        '      fit: BoxFit.cover,\n'
                        '    ),\n'
                        '  ),\n'
                        '  width: 300,\n'
                        '  height: 150,\n'
                        ')',
                        style: TextStyle(fontSize: 9, fontFamily: 'Courier'),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '💡 Alternativa a ClipRRect\n'
                      '✅ Puede combinar con otros BoxDecoration\n'
                      '✅ Mejor performance en algunos casos',
                      style: TextStyle(fontSize: 11, color: Colors.cyan),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              /// ═══════════════════════════════════════════════════════
              /// 📚 TABLA COMPARATIVA DE FORMAS
              /// ═══════════════════════════════════════════════════════
              Text(
                '📚 TABLA COMPARATIVA',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                ),
              ),
              const SizedBox(height: 12),

              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blueGrey[50],
                  border: Border.all(color: Colors.blueGrey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Forma', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                    Text('  • CircleAvatar: Avatares redondos', style: TextStyle(fontSize: 11)),
                    Text('  • Container + DecorationImage: Imagen + decoración', style: TextStyle(fontSize: 11)),
                    Text('  • FadeInImage: Transición suave con placeholder', style: TextStyle(fontSize: 11)),
                    Text('  • Stack: Imagen como fondo + widgets encima', style: TextStyle(fontSize: 11)),
                    Text('  • ListTile: Imagen en lista (leading)', style: TextStyle(fontSize: 11)),
                    SizedBox(height: 8),
                    Text('Casos de uso', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                    Text('  • CircleAvatar: Perfil de usuario', style: TextStyle(fontSize: 11)),
                    Text('  • Image widget: Simple y directo', style: TextStyle(fontSize: 11)),
                    Text('  • FadeInImage: Redes sociales / feeds', style: TextStyle(fontSize: 11)),
                    Text('  • Stack: Banners con texto superpuesto', style: TextStyle(fontSize: 11)),
                    Text('  • GridView: Galerías de fotos', style: TextStyle(fontSize: 11)),
                    Text('  • Card: E-commerce / catálogos', style: TextStyle(fontSize: 11)),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              /// ═══════════════════════════════════════════════════════
              /// 🎯 EJEMPLOS PRÁCTICOS CON IMÁGENES REALES
              /// ═══════════════════════════════════════════════════════
              Text(
                '🎯 EJEMPLOS PRÁCTICOS CON IMÁGENES DEL PROYECTO',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Las siguientes imágenes están en: assets/images/',
                style: TextStyle(fontSize: 12, color: Colors.grey, fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 20),

              /// Ejemplo 1: logo.png
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.deepPurple[50],
                  border: Border.all(color: Colors.deepPurple),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '1️⃣ Logo (logo.png - 100x100)',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepPurple, fontSize: 12),
                    ),
                    const SizedBox(height: 12),
                    Center(
                      child: Image.asset(
                        'assets/images/logo.png',
                        width: 100,
                        height: 100,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: const Text(
                        'Image.asset(\n'
                        '  \'assets/images/logo.png\',\n'
                        '  width: 100,\n'
                        '  height: 100,\n'
                        ')',
                        style: TextStyle(fontSize: 9, fontFamily: 'Courier'),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// Ejemplo 2: avatar.png
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.deepPurple[50],
                  border: Border.all(color: Colors.deepPurple),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '2️⃣ Avatar con CircleAvatar (avatar.png - 150x150)',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepPurple, fontSize: 12),
                    ),
                    const SizedBox(height: 12),
                    Center(
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: AssetImage('assets/images/avatar.png'),
                        backgroundColor: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: const Text(
                        'CircleAvatar(\n'
                        '  radius: 60,\n'
                        '  backgroundImage: AssetImage(\'assets/images/avatar.png\'),\n'
                        ')',
                        style: TextStyle(fontSize: 9, fontFamily: 'Courier'),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// Ejemplo 3: foto.png
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.deepPurple[50],
                  border: Border.all(color: Colors.deepPurple),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '3️⃣ Imagen simple (foto.png - 300x300)',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepPurple, fontSize: 12),
                    ),
                    const SizedBox(height: 12),
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.deepPurple, width: 2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Image.asset(
                          'assets/images/foto.png',
                          width: 200,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: const Text(
                        'Image.asset(\n'
                        '  \'assets/images/foto.png\',\n'
                        '  width: 200,\n'
                        '  height: 200,\n'
                        '  fit: BoxFit.cover,\n'
                        ')',
                        style: TextStyle(fontSize: 9, fontFamily: 'Courier'),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// Ejemplo 4: perfil.png
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.deepPurple[50],
                  border: Border.all(color: Colors.deepPurple),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '4️⃣ Imagen con bordes redondeados (perfil.png - 200x200)',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepPurple, fontSize: 12),
                    ),
                    const SizedBox(height: 12),
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          'assets/images/perfil.png',
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: const Text(
                        'ClipRRect(\n'
                        '  borderRadius: BorderRadius.circular(15),\n'
                        '  child: Image.asset(\n'
                        '    \'assets/images/perfil.png\',\n'
                        '    width: 150,\n'
                        '    height: 150,\n'
                        '    fit: BoxFit.cover,\n'
                        '  ),\n'
                        ')',
                        style: TextStyle(fontSize: 9, fontFamily: 'Courier'),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// Ejemplo 5: producto.png
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.deepPurple[50],
                  border: Border.all(color: Colors.deepPurple),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '5️⃣ Imagen en Card (producto.png - 300x400)',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepPurple, fontSize: 12),
                    ),
                    const SizedBox(height: 12),
                    Center(
                      child: Card(
                        elevation: 8,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              'assets/images/producto.png',
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                            const Padding(
                              padding: EdgeInsets.all(12),
                              child: Text(
                                'Producto Ejemplo',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(bottom: 12),
                              child: Text(
                                '\$99.99',
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: const Text(
                        'Card(\n'
                        '  elevation: 8,\n'
                        '  child: Column(\n'
                        '    children: [\n'
                        '      Image.asset(\'assets/images/producto.png\'),\n'
                        '      Text(\'Producto\'),\n'
                        '    ],\n'
                        '  ),\n'
                        ')',
                        style: TextStyle(fontSize: 9, fontFamily: 'Courier'),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// Ejemplo 6: fondo.png y banner.png
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.deepPurple[50],
                  border: Border.all(color: Colors.deepPurple),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '6️⃣ Imagen como fondo con Stack (fondo.png - 400x200)',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepPurple, fontSize: 12),
                    ),
                    const SizedBox(height: 12),
                    Center(
                      child: Stack(
                        children: [
                          Image.asset(
                            'assets/images/fondo.png',
                            width: 300,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            bottom: 12,
                            left: 12,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.black54,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text(
                                '📌 Título superpuesto',
                                style: TextStyle(color: Colors.white, fontSize: 12),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: const Text(
                        'Stack(\n'
                        '  children: [\n'
                        '    Image.asset(\'assets/images/fondo.png\'),\n'
                        '    Positioned(\n'
                        '      bottom: 12,\n'
                        '      left: 12,\n'
                        '      child: Text(\'Título superpuesto\'),\n'
                        '    ),\n'
                        '  ],\n'
                        ')',
                        style: TextStyle(fontSize: 9, fontFamily: 'Courier'),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// Ejemplo 7: banner.png
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.deepPurple[50],
                  border: Border.all(color: Colors.deepPurple),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '7️⃣ Imagen con DecorationImage (banner.png - 400x150)',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepPurple, fontSize: 12),
                    ),
                    const SizedBox(height: 12),
                    Center(
                      child: Container(
                        width: 280,
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: const DecorationImage(
                            image: AssetImage('assets/images/banner.png'),
                            fit: BoxFit.cover,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: const Text(
                        'Container(\n'
                        '  decoration: BoxDecoration(\n'
                        '    borderRadius: BorderRadius.circular(12),\n'
                        '    image: DecorationImage(\n'
                        '      image: AssetImage(\'assets/images/banner.png\'),\n'
                        '      fit: BoxFit.cover,\n'
                        '    ),\n'
                        '    boxShadow: [...],\n'
                        '  ),\n'
                        ')',
                        style: TextStyle(fontSize: 9, fontFamily: 'Courier'),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
