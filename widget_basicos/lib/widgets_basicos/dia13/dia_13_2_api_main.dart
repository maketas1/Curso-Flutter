import 'package:flutter/material.dart';

/// 🌐 DÍA 13 DE FEBRERO: CONSUMO DE APIs EN FLUTTER
///
/// Aprenderemos a consumir APIs externas para obtener datos en tiempo real.
/// Integraremos datos de servidores remotos en nuestras aplicaciones.
///

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Material App', home: Dia132Api());
  }
}

class Dia132Api extends StatelessWidget {
  const Dia132Api({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🌐 Consumo de APIs'),
        backgroundColor: Colors.deepPurple[700],
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER EDUCATIVO
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.deepPurple[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.deepPurple),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '¿Qué es una API?',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Una API es un intermediario que permite que tu app comunique con servidores remotos '
                    'para obtener datos, enviar información y sincronizarse en tiempo real.',
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Lo que haremos hoy:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  _buildBulletPoint('✅ Hacer solicitudes HTTP (GET, POST)'),
                  _buildBulletPoint('✅ Procesar respuestas JSON'),
                  _buildBulletPoint('✅ Crear modelos serializables'),
                  _buildBulletPoint('✅ Manejar estados asincronos'),
                  _buildBulletPoint('✅ Consumir APIs públicas reales'),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // SECCIÓN: GUÍA
            const Text(
              '📚 GUÍA Y CONCEPTOS',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildLessonCard(
              title: '📖 Guía de Consumo de APIs',
              subtitle: 'Conceptos, métodos HTTP, APIs públicas',
              icon: Icons.info_outline,
              color: Colors.blue,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('📖 Archivo: guia_consumo_apis.dart'),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),

            // SECCIÓN: EJEMPLOS
            const Text(
              '💡 EJEMPLOS PRÁCTICOS',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildLessonCard(
              title: '📱 Ejemplo 1: API Simple',
              subtitle: 'GET request, JSON decode, ListView',
              icon: Icons.api,
              color: Colors.orange,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('📱 Archivo: api_ejemplo_simple.dart'),
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
            _buildLessonCard(
              title: '🎬 Ejemplo 2: Con Modelos',
              subtitle: 'Clases, serialización, GridView, paginación',
              icon: Icons.category,
              color: Colors.purple,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('🎬 Archivo: api_ejemplo_modelo.dart'),
                  ),
                );
              },
            ),
            const SizedBox(height: 32),

            // SECCIÓN: EJERCICIO
            const Text(
              '🎯 EJERCICIO DEL DÍA',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildLessonCard(
              title: '🎴 Clima en España',
              subtitle: '6 pasos: básico → medio → avanzado',
              icon: Icons.train,
              color: Colors.red,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      '🎴 Archivo: ejercicio/ejercicio_clima_spain.dart',
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
            _buildLessonCard(
              title: '✅ Solución Clima España',
              subtitle: 'Código completo con todos los pasos',
              icon: Icons.check_circle,
              color: Colors.green,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      '✅ Archivo: ejercicio/ejercicio_clima_spain_solucion.dart',
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 32),

            // SECCIÓN: CONCEPTOS CLAVE
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.yellow[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.yellow[700]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '🔑 CONCEPTOS CLAVE',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  _buildConceptPoint(
                    'API REST',
                    'Arquitectura para comunicación entre aplicaciones',
                  ),
                  _buildConceptPoint('HTTP GET', 'Obtener datos del servidor'),
                  _buildConceptPoint('JSON', 'Formato de intercambio de datos'),
                  _buildConceptPoint(
                    'Serialización',
                    'Convertir objetos a JSON (toJson)',
                  ),
                  _buildConceptPoint(
                    'Deserialización',
                    'Convertir JSON a objetos (fromJson)',
                  ),
                  _buildConceptPoint(
                    'Async/Await',
                    'Manejar operaciones no bloqueantes',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // CHECKLIST
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '✅ ORDEN DE ESTUDIO',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  _buildChecklistItem('1. Leer guia_consumo_apis.dart'),
                  _buildChecklistItem('2. Estudiar api_ejemplo_simple.dart'),
                  _buildChecklistItem('3. Estudiar api_ejemplo_modelo.dart'),
                  _buildChecklistItem('4. Intentar resolver ejercicio'),
                  _buildChecklistItem('5. Comparar con la solución'),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // DEPENDENCIAS
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.red[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.red[300]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '⚙️ INSTALACIÓN (pubspec.yaml)',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'dependencies:\n'
                      '  flutter:\n'
                      '    sdk: flutter\n'
                      '  http: ^1.1.0',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'monospace',
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Luego: flutter pub get',
                    style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // APIs PÚBLICAS
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '🌍 APIs PÚBLICAS PARA PRACTICAR',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  // Entretenimiento
                  const Text(
                    '🎮 Entretenimiento',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  _buildApiCard(
                    'PokéAPI',
                    'https://pokeapi.co',
                    'Pokémon - Datos completos (Sin auth)',
                  ),
                  _buildApiCard(
                    'Rick & Morty',
                    'https://rickandmortyapi.com/api',
                    'Personajes, episodios (Sin auth)',
                  ),
                  _buildApiCard(
                    'OpenTDB (Trivia)',
                    'https://opentdb.com/api.php',
                    'Preguntas de trivia (Sin auth)',
                  ),
                  _buildApiCard(
                    'Studio Ghibli',
                    'https://ghibliapi.herokuapp.com',
                    'Películas y personajes (Sin auth)',
                  ),
                  const SizedBox(height: 16),
                  // Datos Públicos
                  const Text(
                    '📊 Datos Públicos',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  _buildApiCard(
                    'JSONPlaceholder',
                    'https://jsonplaceholder.typicode.com',
                    'Fake data - Posts, usuarios (Sin auth)',
                  ),
                  _buildApiCard(
                    'Open Notify',
                    'http://api.open-notify.org',
                    'ISS, astronautas (Sin auth)',
                  ),
                  _buildApiCard(
                    'OpenWeather',
                    'https://openweathermap.org/api',
                    'Clima mundial (Requiere API key - Free)',
                  ),                  _buildApiCard(
                    'Open-Meteo',
                    'https://api.open-meteo.com',
                    'Clima y meteorología (Sin auth - ¡Gratuita!)',
                  ),                  const SizedBox(height: 16),
                  // Desarrollo
                  const Text(
                    '💻 Desarrollo',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  _buildApiCard(
                    'GitHub API',
                    'https://api.github.com',
                    'Repos, usuarios, issues (Sin auth - Limited)',
                  ),
                  _buildApiCard(
                    'JSONBin',
                    'https://jsonbin.io',
                    'Almacenar/leer JSON (Gratis con key)',
                  ),
                  _buildApiCard(
                    'httpbin.org',
                    'https://httpbin.org',
                    'Testing HTTP requests (Sin auth)',
                  ),
                  const SizedBox(height: 16),
                  // Noticias & Contenido
                  const Text(
                    '📰 Noticias & Contenido',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  _buildApiCard(
                    'NewsAPI',
                    'https://newsapi.org',
                    'Noticias mundiales (Requiere key - Free)',
                  ),
                  _buildApiCard(
                    'SpaceX API',
                    'https://api.spacexdata.com',
                    'Cohetes, misiones (Sin auth)',
                  ),
                  _buildApiCard(
                    'Marvel API',
                    'https://developer.marvel.com',
                    'Personajes, cómics (Requiere key)',
                  ),
                  const SizedBox(height: 16),
                  // Utilidades
                  const Text(
                    '🛠️ Utilidades',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  _buildApiCard(
                    'Genderize.io',
                    'https://api.genderize.io',
                    'Predecir género por nombre (Sin auth)',
                  ),
                  _buildApiCard(
                    'Agify.io',
                    'https://api.agify.io',
                    'Predecir edad por nombre (Sin auth)',
                  ),
                  _buildApiCard(
                    'REST Countries',
                    'https://restcountries.com/v3.1',
                    'Información de países (Sin auth)',
                  ),
                  _buildApiCard(
                    'QR Server',
                    'https://api.qrserver.com',
                    'Generar códigos QR (Sin auth)',
                  ),
                  const SizedBox(height: 16),
                  // Música & Audio
                  const Text(
                    '🎵 Música & Audio',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  _buildApiCard(
                    'Spotify API',
                    'https://api.spotify.com',
                    'Música, artistas, playlists (Requiere auth)',
                  ),
                  _buildApiCard(
                    'Last.fm API',
                    'https://www.last.fm/api',
                    'Scrobbling de música (Requiere key)',
                  ),
                  _buildApiCard(
                    'Genius API',
                    'https://api.genius.com',
                    'Letras de canciones (Requiere token)',
                  ),
                  const SizedBox(height: 16),
                  // Deportes
                  const Text(
                    '⚽ Deportes',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  _buildApiCard(
                    'Football-Data.org',
                    'https://www.football-data.org/api',
                    'Fútbol, ligas, equipos (Requiere key)',
                  ),
                  _buildApiCard(
                    'ESPN Cricket API',
                    'https://reliapi.herokuapp.com',
                    'Cricket, resultados (Sin auth)',
                  ),
                  _buildApiCard(
                    'TheSportsDB',
                    'https://www.thesportsdb.com/api.php',
                    'Deportes múltiples (Sin auth)',
                  ),
                  const SizedBox(height: 16),
                  // Películas & Series
                  const Text(
                    '🎬 Películas & Series',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  _buildApiCard(
                    'OMDB API',
                    'http://www.omdbapi.com',
                    'Películas y series (Requiere key)',
                  ),
                  _buildApiCard(
                    'The Movie Database (TMDB)',
                    'https://www.themoviedb.org/api',
                    'Películas, TV, personas (Requiere key)',
                  ),
                  _buildApiCard(
                    'BrasilAPI',
                    'https://brasilapi.com.br',
                    'Dados públicos brasileiros (Sin auth)',
                  ),
                  const SizedBox(height: 16),
                  // Comida & Recetas
                  const Text(
                    '🍕 Comida & Recetas',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  _buildApiCard(
                    'TheMealDB',
                    'https://www.themealdb.com/api.php',
                    'Recetas de comidas del mundo (Sin auth)',
                  ),
                  _buildApiCard(
                    'CocktailDB',
                    'https://www.thecocktaildb.com/api.php',
                    'Recetas de cócteles (Sin auth)',
                  ),
                  _buildApiCard(
                    'Spoonacular',
                    'https://spoonacular.com/food-api',
                    'Nutrición, recetas (Requiere key)',
                  ),
                  const SizedBox(height: 16),
                  // Criptomonedas & Finanzas
                  const Text(
                    '💰 Criptomonedas & Finanzas',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  _buildApiCard(
                    'CoinGecko API',
                    'https://api.coingecko.com',
                    'Precios crypto (Sin auth, sin límite)',
                  ),
                  _buildApiCard(
                    'Finnhub (Stocks)',
                    'https://finnhub.io',
                    'Datos de bolsa (Requiere key - Free)',
                  ),
                  _buildApiCard(
                    'Exchange Rate API',
                    'https://api.exchangerate-api.com',
                    'Tasas de cambio (Sin auth limitado)',
                  ),
                  const SizedBox(height: 16),
                  // Imágenes & Fotos
                  const Text(
                    '📷 Imágenes & Fotos',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  _buildApiCard(
                    'Unsplash API',
                    'https://unsplash.com/api',
                    'Fotos gratis (Requiere key - Free)',
                  ),
                  _buildApiCard(
                    'Pexels API',
                    'https://www.pexels.com/api',
                    'Fotos stock (Requiere API key)',
                  ),
                  _buildApiCard(
                    'Pixabay API',
                    'https://pixabay.com/api',
                    'Fotos e ilustraciones (Requiere key)',
                  ),
                  const SizedBox(height: 16),
                  // Educación
                  const Text(
                    '📚 Educación',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  _buildApiCard(
                    'Random User Generator',
                    'https://randomuser.me/api',
                    'Usuarios aleatorios con datos (Sin auth)',
                  ),
                  _buildApiCard(
                    'PokeAPI Docs',
                    'https://pokeapi.co/docs/v2',
                    'Documentación con ejemplos (Sin auth)',
                  ),
                  _buildApiCard(
                    'API Ninjas',
                    'https://api-ninjas.com',
                    '50+ APIs útiles (Requiere key - Free)',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  static Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text(text, style: const TextStyle(fontSize: 13)),
    );
  }

  static Widget _buildLessonCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          leading: Icon(icon, color: color, size: 32),
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        ),
      ),
    );
  }

  static Widget _buildConceptPoint(String concept, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 12, top: 2),
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: Colors.yellow[700],
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  concept,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: const TextStyle(fontSize: 12, color: Colors.black54),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildChecklistItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(Icons.check_circle_outline, size: 18, color: Colors.blue[600]),
          const SizedBox(width: 12),
          Text(text, style: const TextStyle(fontSize: 13)),
        ],
      ),
    );
  }

  static Widget _buildApiCard(String name, String url, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.green[200]!),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(url, style: TextStyle(fontSize: 11, color: Colors.blue[600])),
            const SizedBox(height: 4),
            Text(
              description,
              style: const TextStyle(fontSize: 11, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
