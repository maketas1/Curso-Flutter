import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

/// 🌐 EJEMPLO 1: CONSUMO DE API SIMPLE
///
/// En este ejemplo:
/// - Consumimos JSONPlaceholder API (fake API gratuita)
/// - Hacemos un GET request simple
/// - Mostramos los datos en un ListView
/// - Manejamos loading y errores
///
/// API Pública: https://jsonplaceholder.typicode.com
///
/// ═══════════════════════════════════════════════════════════════════════════

void main() {
  runApp(const ApiSimpleApp());
}

class ApiSimpleApp extends StatelessWidget {
  const ApiSimpleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Consumo de API Simple',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const PostsPage(),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// PÁGINA DE POSTS
// ═══════════════════════════════════════════════════════════════════════════════

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  // Variables de estado
  List<Map<String, dynamic>> posts = [];
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    _cargarPosts();
  }

  // PASO 1 & 2: Cargar posts desde la API
  Future<void> _cargarPosts() async {
    try {
      setState(() {
        isLoading = true;
        error = null;
      });

      // PASO 3: Hacer la solicitud GET
      final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/posts'),
        headers: {
          /// USER-AGENT: Identifica qué cliente/aplicación hace la solicitud
          ///
          /// ¿Por qué lo usamos?
          /// - Algunos servidores requieren un User-Agent válido
          /// - Rechazan solicitudes sin User-Agent o de bots maliciosos
          /// - Permite al servidor saber que es una app Flutter legítima
          /// - Se usa para estadísticas y análisis de tráfico
          ///
          /// Estructura: NombreApp/Version (Plataforma; SO)
          /// Ejemplos:
          ///   - 'MiApp/1.0 (Flutter; Android 12)'
          ///   - 'MiApp/1.0 (Flutter; iOS 15.0)'
          ///   - 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)' (Chrome)
          'User-Agent': 'MiApp/1.0 (Flutter)',

          /// ACCEPT: Indica qué tipo de respuesta esperamos recibir
          /// application/json = Queremos datos en formato JSON
          'Accept': 'application/json',
        },
      );

      // debugPrint(response.body); //Devuelve el JSON como String

      // PASO 4: Verificar estatus.
      if (response.statusCode == 200) {
        // PASO 5: Decodificar JSON. Convierte un String JSON a List o Map de Dart
        final List<dynamic> jsonList = jsonDecode(response.body);
        //  debugPrint(jsonList.toString());

        // PASO 6: Convertir a List<Map>
        final List<Map<String, dynamic>> listaPost = jsonList
            .map((item) => item as Map<String, dynamic>)
            .toList();

        debugPrint(listaPost.toString());

        // PASO 7: Actualizar UI
        setState(() {
          posts = listaPost;
          isLoading = false;
        });
      } else {
        throw Exception(
          'Error ${response.statusCode}: ${response.reasonPhrase}',
        );
      }
    } catch (e) {
      setState(() {
        error = 'Error: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('📱 Posts desde API'),
        backgroundColor: Colors.blue[300],
        actions: [
          // Botón para recargar
          IconButton(icon: const Icon(Icons.refresh), onPressed: _cargarPosts),
        ],
      ),
      body: _construirBody(),
    );
  }

  Widget _construirBody() {
    // Estado: Cargando
    if (isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Cargando posts...'),
          ],
        ),
      );
    }

    // Estado: Error
    if (error != null) {
      return Center(
        child: Text(
          'Oops! Hubo un error',
          style: TextStyle(fontSize: 18, color: Colors.red[400]),
        ),
      );
    }

    // Estado: Datos cargados
    if (posts.isEmpty) {
      return const Center(child: Text('No hay posts disponibles'));
    }

    return ListView.builder(
      itemCount: posts.length,
      padding: const EdgeInsets.all(8),
      itemBuilder: (context, index) {
        final post = posts[index];

        return Card(
          margin: const EdgeInsets.all(8),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Título
                Text(
                  post['title'] ?? 'Sin título',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),

                // Body/Contenido
                Text(
                  post['body'] ?? 'Sin contenido',
                  style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/*
═══════════════════════════════════════════════════════════════════════════════
EXPLICACIÓN PASO A PASO
═══════════════════════════════════════════════════════════════════════════════

1. INSTALACIÓN (pubspec.yaml):
   dependencies:
     http: ^1.1.0

2. SOLICITUD HTTP:
   final response = await http.get(Uri.parse(url));
   - await: Esperamos a que termine la solicitud
   - Uri.parse(): Convierte string a URL válida

3. HEADERS (Cabeceras HTTP):
   Headers son información adicional que enviamos con la solicitud
   
   - User-Agent: Identifica el cliente que hace la solicitud
     * Algunos servidores lo requieren para validar que es un cliente legítimo
     * Bloquean solicitudes sin User-Agent o de bots maliciosos
     * Ejemplo: 'MiApp/1.0 (Flutter; Android 12)'
   
   - Accept: Indica qué tipo de respuesta esperamos
     * 'application/json' = Queremos JSON
     * 'text/html' = Queremos HTML
     * 'application/xml' = Queremos XML

4. VERIFICAR ESTATUS:
   if (response.statusCode == 200) { ... }
   - 200 = OK (solicitud exitosa)
   - Otros códigos = error
   - 404 = No encontrado
   - 401 = No autorizado
   - 500 = Error del servidor

5. DECODIFICAR JSON:
   final List<dynamic> jsonList = jsonDecode(response.body);
   - response.body es un String con JSON
   - jsonDecode lo convierte a List o Map

6. ACTUALIZAR UI:
   setState(() { posts = listaPost; });
   - Actualiza la variable
   - Reconstruye el widget

7. MANEJO DE ERRORES:
   try-catch para SocketException, FormatException, etc.

═══════════════════════════════════════════════════════════════════════════════
*/
