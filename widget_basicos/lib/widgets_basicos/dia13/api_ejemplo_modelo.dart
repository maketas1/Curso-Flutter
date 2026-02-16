import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:widget_basicos/widgets_basicos/dia13/models/peliculas/peliculas.dart';
import 'package:widget_basicos/widgets_basicos/dia13/models/peliculas/search.dart';

/// 🌐 EJEMPLO 2: BUSCADOR DE PELÍCULAS CON MODELOS
///
/// En este ejemplo veremos:
/// - Crear un modelo de datos (clase Película)
/// - Serialización (toJson)
/// - Deserialización (fromJson)
/// - Búsqueda en una API de películas
/// - Mostrar resultados en GridView
///
/// API: OMDb (Open Movie Database)
/// URL: http://www.omdbapi.com/?apikey=CLAVE&s=BUSQUEDA
/// Nota: Requiere API key gratuita de https://www.omdbapi.com/apikey.aspx
/// Api key de ejemplo (limitada): 9da88f95 (usar tu propia key para evitar limitaciones)
/// https://www.omdbapi.com/?i=tt3896198&apikey=9da88f95 // Ejemplo de búsqueda: http://www.omdbapi.com/?apikey=9da88f95&s=Inception
/// https://www.omdbapi.com/?s=injection&apikey=9da88f95 // Búsqueda de "injection" devuelve resultados variados
///
/// ═══════════════════════════════════════════════════════════════════════════

void main() {
  runApp(const BuscadorPeliculasApp());
}

/// Modelo de datos: Película
class PeliculaManual {
  String? imdbId;
  String? title;
  String? year;
  String? type;
  String? poster;

  PeliculaManual({
    required this.imdbId,
    required this.title,
    required this.year,
    required this.type,
    required this.poster,
  });

  /// Deserializar desde JSON
  factory PeliculaManual.fromJson(Map<String, dynamic> json) {
    return PeliculaManual(
      imdbId: json['imdbID'] as String? ?? '',
      title: json['Title'] as String? ?? 'Sin título',
      year: json['Year'] as String? ?? 'N/A',
      type: json['Type'] as String? ?? 'Desconocido',
      poster: json['Poster'] as String?,
    );
  }

  /// Serializar a JSON
  Map<String, dynamic> toJson() {
    return {
      'imdbID': imdbId,
      'Title': title,
      'Year': year,
      'Type': type,
      'Poster': poster,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'imdbID': imdbId,
      'Title': title,
      'Year': year,
      'Type': type,
      'Poster': poster,
    };
  }
}

// Utilizando un plugins para generar el modelo automáticamente a partir del JSON de la API.
// Esto es recomendable para evitar errores y ahorrar tiempo, especialmente con APIs complejas.
// Json to Dart Model de hirantha.

// Copiar al portapapeles el JSON de la API (ej: http://www.omdbapi.com/?apikey=9da88f95&s=Inception)
// En la carpeta del proyecto (lib/models), botón  derecho -> JSON to Dart: From Clipboard
// Esto genera automáticamente las clases Peliculas y Search con sus métodos de serialización y deserialización, 
// basados en la estructura del JSON de la API. Es una forma rápida y confiable de crear modelos de datos para 
// consumir APIs REST en Flutter.

// ═══════════════════════════════════════════════════════════════════════════════
// APLICACIÓN PRINCIPAL
// ═══════════════════════════════════════════════════════════════════════════════

class BuscadorPeliculasApp extends StatelessWidget {
  const BuscadorPeliculasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Buscador de Películas',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const PeliculasPage(),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// PÁGINA DE BÚSQUEDA DE PELÍCULAS
// ═══════════════════════════════════════════════════════════════════════════════

class PeliculasPage extends StatefulWidget {
  const PeliculasPage({super.key});

  @override
  State<PeliculasPage> createState() => _PeliculasPageState();
}

class _PeliculasPageState extends State<PeliculasPage> {
  // API Key - Obtener en https://www.omdbapi.com/apikey.aspx

  static const String API_KEY =
      '9da88f95'; // Reemplazar con API key real de cada usuario y es una mala práctica dejarla hardcodeada en el código fuente.
  // En proyectos reales, usar variables de entorno o servicios de gestión de secretos.
  // Usar variables de entorno (paquete flutter_dotenv)
  // Añadir archivos sensibles al .gitignore
  // Usar backend como proxy para claves críticas

  List<dynamic> peliculas = [];
  bool isManual = false; // Cambiar a false para usar modelo generado automáticamente
  bool isLoading = false;
  String? error;
  String? ultimaBusqueda;

  final TextEditingController _busquedaController = TextEditingController();

  Future<void> _buscarPeliculas(String query) async {
    if (query.isEmpty) {
      setState(() => error = 'Por favor ingresa un título');
      return;
    }

    try {
      setState(() {
        isLoading = true;
        error = null;
      });

      final url =
          'http://www.omdbapi.com/?apikey=$API_KEY&s=${Uri.encodeComponent(query)}&type=movie';
      final response = await http
          .get(Uri.parse(url))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
        var listaPeliculas = <dynamic>[];

        if (jsonData['Response'] == 'True') {
          if (isManual) {
            //Deserializar usando el modelo manual (PeliculaManual)
            final resultados = jsonData['Search'] as List<dynamic>;
            listaPeliculas = resultados
                .map(
                  (item) => PeliculaManual.fromJson(
                    item as Map<String, dynamic>,
                  ), //lista manual
                )
                .toList();
          } else {
            // Deserializar usando el modelo generado automáticamente (Search)
             listaPeliculas = Peliculas.fromMap(jsonData).search ?? [];
          }
          setState(() {
            peliculas = listaPeliculas;
            isLoading = false;
            ultimaBusqueda = query;
          });
        } else {
          setState(() {
            peliculas = [];
            error = 'No se encontraron películas para "$query"';
            isLoading = false;
          });
        }
      } else {
        throw Exception('Error ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        error = 'Error: $e';
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _busquedaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🎬 Buscador de películas'),
        backgroundColor: Colors.lightBlue,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.blue[50],
            child: Column(
              children: [
                const Text(
                  '¿Qué película buscas?',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _busquedaController,
                        decoration: InputDecoration(
                          hintText: 'Ej: Inception',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onSubmitted: (value) => _buscarPeliculas(value),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      onPressed: () =>
                          _buscarPeliculas(_busquedaController.text),
                      icon: const Icon(Icons.search),
                      label: const Text('Buscar'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(child: _construirContenido()),
        ],
      ),
    );
  }

  Widget _construirContenido() {
    if (isLoading) return const Center(child: CircularProgressIndicator());
    if (error != null) return Center(child: Text(error!));
    if (peliculas.isEmpty)
      return const Center(child: Text('Busca una película'));

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: peliculas.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Padding(
            padding: const EdgeInsets.all(12),
            child: Text('${peliculas.length} resultados'),
          );
        }
        final pelicula = peliculas[index - 1];
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.25,
                  height: 120,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.horizontal(
                      left: Radius.circular(12),
                    ),
                    child: Image.network(
                      pelicula.poster ??
                          'https://placehold.co/300x450?text=Sin+Poster',
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => Container(
                        color: Colors.grey[300],
                        child: const Icon(Icons.image_not_supported),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pelicula.title ?? '',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        pelicula.year ?? '',
                        style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                      ),
                      Text(
                        'ID: ${pelicula.imdbId ?? ''}',
                        style: TextStyle(fontSize: 9, color: Colors.grey[500]),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
