/*
╔═══════════════════════════════════════════════════════════════════════════════╗
║      🌐 CONSUMO DE APIs EN FLUTTER - GUÍA EDUCATIVA COMPLETA                ║
║                                                                               ║
║ Esta es una GUÍA que enseña cómo consumir APIs externas desde Flutter.      ║
║ Aprenderás qué es una API, cómo hacer solicitudes HTTP y procesar datos.    ║
╚═══════════════════════════════════════════════════════════════════════════════╝
*/

// ═══════════════════════════════════════════════════════════════════════════════
// ¿QUÉ ES UNA API Y CÓMO CONSUMIRLA?
// ═══════════════════════════════════════════════════════════════════════════════

/*
🌐 API = Application Programming Interface (Interfaz de Programación de Aplicaciones)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📌 DEFINICIÓN SIMPLE:
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Una API es un "intermediario" que permite que tu app hable con servidores remotos
para obtener datos o enviar información.

Ejemplo real:
  • Tu app quiere conocer el clima
  • Llama a la API de weather.com
  • El servidor procesa tu solicitud
  • Te devuelve los datos del clima
  • Tu app muestra la información al usuario

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🏪 ANALOGÍA: RESTAURANTE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  TÚ (Cliente/Tu App)     --->  MESERO (API)  --->  COCINA (Servidor)
        ↓                                              ↓
   "Quiero un café"  --------➜  Lleva orden  -------➜  Prepara café
        ↑                                              ↑
   Recibe café  ←------- Trae resultado ------ Café listo
   
Componentes:
  • REQUEST (Solicitud): El café que pides → GET, POST, PUT, DELETE
  • RESPONSE (Respuesta): El café que recibes → JSON con datos
  • ENDPOINT: La ubicación donde llamas → https://api.ejemplo.com/cafe
  • STATUS CODE: Resultado de tu orden → 200 OK, 404 No encontrado, etc.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⚡ MÉTODOS HTTP (TIPOS DE SOLICITUDES)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

┌─────────┬────────────────┬──────────────────────────────────────────────────┐
│ MÉTODO  │ ACCIÓN         │ EJEMPLO                                          │
├─────────┼────────────────┼──────────────────────────────────────────────────┤
│ GET     │ LEER datos     │ Obtener lista de películas                       │
│         │ (No envía body)│ http.get('https://api.ejemplo.com/movies')      │
├─────────┼────────────────┼──────────────────────────────────────────────────┤
│ POST    │ CREAR datos    │ Crear una película nueva                         │
│         │ (Envía body)   │ http.post(url, body: jsonEncode({'title':...})) │
├─────────┼────────────────┼──────────────────────────────────────────────────┤
│ PUT     │ ACTUALIZAR     │ Cambiar título de una película                   │
│         │ (Envía body)   │ http.put(url, body: jsonEncode({'id':1,...}))   │
├─────────┼────────────────┼──────────────────────────────────────────────────┤
│ DELETE  │ ELIMINAR datos │ Borrar una película de la BD                    │
│         │ (No envía body)│ http.delete('https://api.ejemplo.com/movies/1') │
└─────────┴────────────────┴──────────────────────────────────────────────────┘

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🎯 CÓDIGOS DE RESPUESTA HTTP (STATUS CODES)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

┌─────┬────────┬───────────────────────────────────────────────────────────┐
│ 2XX │ ÉXITO  │ La solicitud fue procesada correctamente                 │
│ 200 │        │ OK - Todo bien                                            │
│ 201 │        │ Created - Se creó un nuevo recurso (POST exitoso)        │
├─────┼────────┼───────────────────────────────────────────────────────────┤
│ 4XX │ ERROR  │ Error del CLIENTE (tu solicitud fue incorrecta)          │
│ 400 │ CLIENT │ Bad Request - Datos incorrectos                           │
│ 401 │        │ Unauthorized - No autenticado (sin token/contraseña)     │
│ 403 │        │ Forbidden - No autorizado (sin permisos)                 │
│ 404 │        │ Not Found - La URL no existe                              │
├─────┼────────┼───────────────────────────────────────────────────────────┤
│ 5XX │ ERROR  │ Error del SERVIDOR (problema remoto)                     │
│ 500 │ SERVER │ Internal Server Error - Error en el servidor             │
│ 503 │        │ Service Unavailable - Servidor sobrecargado/caído        │
└─────┴────────┴───────────────────────────────────────────────────────────┘

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📚 ESTRUCTURA DE UNA SOLICITUD HTTP
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

SOLICITUD (REQUEST):
┌────────────────────────────────────────────────────────────────┐
│ GET https://api.openweathermap.org/data/2.5/weather?q=Madrid  │ ← ENDPOINT
├────────────────────────────────────────────────────────────────┤
│ HEADERS (Metadatos)                                            │
│   Content-Type: application/json                               │
│   Authorization: Bearer token_xxx                              │
│   User-Agent: Flutter App                                      │
├────────────────────────────────────────────────────────────────┤
│ BODY (Solo en POST, PUT, PATCH)                                │
│   {                                                             │
│     "name": "Juan",                                             │
│     "email": "juan@example.com",                                │
│     "age": 25                                                   │
│   }                                                             │
└────────────────────────────────────────────────────────────────┘

RESPUESTA (RESPONSE):
┌────────────────────────────────────────────────────────────────┐
│ STATUS CODE: 200 OK                                            │
├────────────────────────────────────────────────────────────────┤
│ HEADERS (Metadatos de respuesta)                               │
│   Content-Type: application/json                               │
│   Content-Length: 1234                                         │
│   Date: Mon, 12 Feb 2026 10:30:00 GMT                          │
├────────────────────────────────────────────────────────────────┤
│ BODY (Datos JSON)                                              │
│   {                                                             │
│     "id": 1,                                                    │
│     "name": "Juan",                                             │
│     "email": "juan@example.com",                                │
│     "age": 25,                                                  │
│     "createdAt": "2026-02-12T10:30:00Z"                        │
│   }                                                             │
└────────────────────────────────────────────────────────────────┘

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 CÓMO CONSUMIR UNA API (PASO A PASO)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

PASO 1: ENTENDER LA API - Leer la documentación
════════════════════════════════════════════════════════════════════════════════
Cada API tiene documentación (OpenAPI/Swagger) que incluye:
  ✓ Endpoints disponibles              ✓ Parámetros requeridos
  ✓ Métodos permitidos (GET, POST)     ✓ Formatos de respuesta
  ✓ Ejemplos de solicitudes/respuestas  ✓ Códigos de error

Ejemplo - API OMDb (películas):
  Endpoint: https://api.omdbapi.com/
  Método: GET
  Parámetros:
    - apikey (requerido): Tu clave de API
    - s (requerido): Nombre de película
    - y (opcional): Año
  
  Ejemplo completo:
  GET https://api.omdbapi.com/?apikey=abc123&s=Inception
  
  Respuesta:
  {
    "Search": [
      {"Title":"Inception","Year":"2010","imdbID":"tt1375666","Type":"movie"},
      {"Title":"Inception: The Cobol Job","Year":"2010","imdbID":"...","Type":"..."}
    ],
    "totalResults":"45",
    "Response":"True"
  }

PASO 2: INSTALAR DEPENDENCIAS
════════════════════════════════════════════════════════════════════════════════
Agregar package http a pubspec.yaml:
  dependencies:
    http: ^1.1.0

Ejecutar: flutter pub get

PASO 3: CREAR LA FUNCIÓN ASYNC PARA LA SOLICITUD
════════════════════════════════════════════════════════════════════════════════
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<Pelicula>> buscarPelulas(String titulo) async {
  // Construir la URL con parámetros
  final Uri url = Uri.parse(
    'https://api.omdbapi.com/?apikey=abc123&s=$titulo'
  );
  
  try {
    // PASO 4: HACER LA SOLICITUD
    final response = await http.get(url);
    
    // PASO 5: VERIFICAR STATUS CODE
    if (response.statusCode == 200) {
      // PASO 6: PARSEAR JSON
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      
      // PASO 7: VALIDAR RESPUESTA
      if (jsonData['Response'] == 'True') {
        List<dynamic> searchResults = jsonData['Search'];
        
        // PASO 8: CONVERTIR A OBJETOS DART
        List<Pelicula> peliculas = searchResults
            .map((p) => Pelicula.fromJson(p))
            .toList();
        
        // PASO 9: RETORNAR DATOS
        return peliculas;
      } else {
        throw Exception(jsonData['Error']);
      }
    } else {
      // ERROR: CÓDIGO DE ESTADO NO ES 200
      throw Exception('Error: ${response.statusCode}');
    }
  } catch (e) {
    // MANEJO DE ERRORES
    print('Error en llamada API: $e');
    rethrow;
  }
}

PASO 10: USAR LA FUNCIÓN EN TU WIDGET
════════════════════════════════════════════════════════════════════════════════
FutureBuilder<List<Pelicula>>(
  future: buscarPelulas('Inception'),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const CircularProgressIndicator();
    }
    
    if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    }
    
    if (snapshot.hasData) {
      return ListView(
        children: snapshot.data!
            .map((p) => ListTile(title: Text(p.titulo)))
            .toList(),
      );
    }
    
    return const Text('Sin resultados');
  },
)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🔄 FLUJO VISUAL COMPLETO DE UNA LLAMADA API
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Tu App Flutter
    ↓
    ├─ 1. Punto de activación
    │  └─ Usuario presiona botón "Buscar película"
    ↓
    ├─ 2. Construir URL
    │  └─ "https://api.omdbapi.com/?apikey=xxx&s=Inception"
    ↓
    ├─ 3. Solicitud enviada (REQUEST)
    │  └─ GET request a servidor remoto
    ↓
    ├─ 4. Servidor procesa
    │  └─ Base de datos busca películas con "Inception"
    ↓
    ├─ 5. Respuesta devuelta (RESPONSE)
    │  └─ JSON con películas encontradas
    ↓
    ├─ 6. JsonDecode
    │  └─ String JSON → Dart Map
    ↓
    ├─ 7. Validación
    │  └─ Verificar que no hubo errores
    ↓
    ├─ 8. Conversión de tipos
    │  └─ Map → Lista de objetos Pelicula
    ↓
    └─ 9. Mostrar en UI
       └─ ListView con resultados

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⚠️ ERRORES COMUNES AL CONSUMIR APIs
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

❌ ERROR 1: No importar dart:convert
   Olvidas: import 'dart:convert';
   Resultado: jsonDecode() no funciona

❌ ERROR 2: No manejar excepciones (try-catch)
   Código sin try-catch si falla:
   ✗ Causa crash de la app
   
❌ ERROR 3: Acceder a datos sin verificar null
   ✗ var titulo = jsonData['titulo'];  // Puede ser null
   ✓ var titulo = jsonData['titulo'] ?? 'Sin título';

❌ ERROR 4: Tipo de dato incorrecto
   ✗ int precio = jsonData['precio'];  // Si viene como String
   ✓ int precio = int.parse(jsonData['precio']);

❌ ERROR 5: URL mal formada
   ✗ "https://api.ejemplo.com/usuarios" + nombreCompleto  // Espacio
   ✓ Uri.parse() maneja caracteres especiales

❌ ERROR 6: Olvidar await en async
   ✗ Future<List> resultado = buscarAPI();  // Sin await
   ✓ List resultado = await buscarAPI();

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
💡 TIPS Y MEJORES PRÁCTICAS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✅ SIEMPRE verificar el status code (response.statusCode)
✅ USAR try-catch para manejar errores
✅ GUARDAR credenciales (API keys) en variables de entorno
✅ IMPLEMENTAR timeout para solicitudes
✅ USAR FutureBuilder para manejar async en UI
✅ GUARDAR en caché si la API es lenta
✅ MOSTRAR loading indicator mientras se espera respuesta
✅ LIMITAR número de solicitudes (throttling)
✅ DOCUMENTAR URLs y parámetros

*/

// ═══════════════════════════════════════════════════════════════════════════════
// MÉTODOS PARA CONSUMIR APIs EN FLUTTER
// ═══════════════════════════════════════════════════════════════════════════════

/*
Hay diferentes formas de hacer solicitudes HTTP en Flutter:

┌──────────────────────────────────────────────────────────────────────────────┐
│ 1️⃣ HTTP PACKAGE (Recomendado para empezar)                                  │
├──────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│ INSTALACIÓN:                                                                 │
│ pubspec.yaml:                                                               │
│   dependencies:                                                              │
│     http: ^1.1.0                                                            │
│                                                                              │
│ USO BÁSICO:                                                                 │
│   import 'package:http/http.dart' as http;                                 │
│                                                                              │
│   // GET                                                                    │
│   var response = await http.get(                                            │
│     Uri.parse('https://api.ejemplo.com/usuarios'),                         │
│   );                                                                         │
│                                                                              │
│   // POST                                                                   │
│   var response = await http.post(                                           │
│     Uri.parse('https://api.ejemplo.com/usuarios'),                         │
│     headers: {'Content-Type': 'application/json'},                          │
│     body: jsonEncode({'nombre': 'Juan', 'edad': 25}),                      │
│   );                                                                         │
│                                                                              │
│ ✅ VENTAJAS:                                                                │
│   • Simple de usar                                                          │
│   • Documentación oficial de Google                                         │
│   • Perfecto para aprender                                                  │
│   • No muchas dependencias                                                  │
│                                                                              │
│ ❌ DESVENTAJAS:                                                              │
│   • Requiere más código boilerplate                                         │
│   • No maneja interceptores fácilmente                                       │
│   • No tiene retry automático                                               │
└──────────────────────────────────────────────────────────────────────────────┘
*/

/*
┌──────────────────────────────────────────────────────────────────────────────┐
│ 2️⃣ DIO PACKAGE (Más avanzado y poderoso)                                    │
├──────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│ INSTALACIÓN:                                                                 │
│ pubspec.yaml:                                                               │
│   dependencies:                                                              │
│     dio: ^5.0.0                                                             │
│                                                                              │
│ USO BÁSICO:                                                                 │
│   import 'package:dio/dio.dart';                                            │
│                                                                              │
│   final dio = Dio();                                                        │
│                                                                              │
│   // GET                                                                    │
│   var response = await dio.get('https://api.ejemplo.com/usuarios');        │
│                                                                              │
│   // POST                                                                   │
│   var response = await dio.post(                                            │
│     'https://api.ejemplo.com/usuarios',                                     │
│     data: {'nombre': 'Juan', 'edad': 25},                                  │
│   );                                                                         │
│                                                                              │
│ ✅ VENTAJAS:                                                                │
│   • Muy poderoso y flexible                                                 │
│   • Interceptores integrados                                                │
│   • Más fácil de usar que http                                              │
│   • Manejo de errores mejorado                                              │
│   • Soporte para form data                                                  │
│                                                                              │
│ ❌ DESVENTAJAS:                                                              │
│   • Más pesado que http                                                     │
│   • Más complejo de aprender                                                │
│   • Menos documentación que http                                            │
└──────────────────────────────────────────────────────────────────────────────┘
*/

/*
┌──────────────────────────────────────────────────────────────────────────────┐
│ 3️⃣ RETROFIT (Basado en Dio, muy moderno)                                    │
├──────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│ INSTALACIÓN:                                                                 │
│ pubspec.yaml:                                                               │
│   dependencies:                                                              │
│     retrofit: ^4.0.0                                                        │
│   dev_dependencies:                                                          │
│     retrofit_generator: ^8.0.0                                              │
│     build_runner: ^2.0.0                                                    │
│                                                                              │
│ USO (AVANZADO - No lo usaremos hoy):                                        │
│   @RestApi(baseUrl: 'https://api.ejemplo.com')                             │
│   abstract class ApiClient {                                                │
│     factory ApiClient(Dio dio) = _ApiClient;                                │
│                                                                              │
│     @GET('/usuarios')                                                       │
│     Future<List<Usuario>> getUsuarios();                                   │
│   }                                                                          │
│                                                                              │
│ ✅ VENTAJAS:                                                                │
│   • Código muy limpio                                                       │
│   • Decoradores para endpoints                                              │
│   • Type-safe                                                               │
│                                                                              │
│ ❌ DESVENTAJAS:                                                              │
│   • Requiere code generation                                                │
│   • Más curva de aprendizaje                                                │
│   • Overkill para apps simples                                              │
└──────────────────────────────────────────────────────────────────────────────┘
*/

// ═══════════════════════════════════════════════════════════════════════════════
// 🛠️ POSTMAN - Herramienta para Probar APIs
// ═══════════════════════════════════════════════════════════════════════════════

/*
📮 ¿QUÉ ES POSTMAN?

Postman es una herramienta visual para:
✅ Hacer solicitudes HTTP a APIs
✅ Probar endpoints sin escribir código
✅ Inspeccionar respuestas (headers, body, status)
✅ Guardar colecciones de solicitudes
✅ Automatizar tests de API
✅ Documentar APIs

🌐 DESCARGAR: https://www.postman.com/downloads/

┌──────────────────────────────────────────────────────────────────────────────┐
│ INSTALACIÓN Y PRIMEROS PASOS                                               │
├──────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│ 1. Descargar desde https://www.postman.com/downloads/                      │
│    (Windows, Mac, Linux)                                                    │
│                                                                              │
│ 2. Instalar y abrir                                                         │
│                                                                              │
│ 3. Crear una cuenta gratuita (opcional pero recomendado)                   │
│    - Sincronizar colecciones en la nube                                    │
│    - Compartir con equipo                                                   │
│                                                                              │
│ 4. ¡Ya está listo para usar!                                               │
└──────────────────────────────────────────────────────────────────────────────┘

┌──────────────────────────────────────────────────────────────────────────────┐
│ CÓMO HACER UN REQUEST EN POSTMAN                                            │
├──────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│ PASO 1: SELECCIONAR MÉTODO HTTP                                             │
│ ┌─────────────────────────────────────────┐                                │
│ │ [GET v]  (dropdown para cambiar)         │                                │
│ │ GET, POST, PUT, DELETE, PATCH, etc.     │                                │
│ └─────────────────────────────────────────┘                                │
│                                                                              │
│ PASO 2: ESCRIBIR LA URL                                                     │
│ ┌────────────────────────────────────────────────────────────────┐          │
│ │ https://api.ejemplo.com/usuarios/1                             │          │
│ └────────────────────────────────────────────────────────────────┘          │
│                                                                              │
│ PASO 3: AGREGAR PARÁMETROS (Opcional)                                       │
│ [Params] [Authorization] [Headers] [Body] [Pre-request Script] [Tests]     │
│                                                                              │
│ • PARAMS: ?clave=valor&otra=valor2                                         │
│ • HEADERS: Content-Type, Accept, Authorization (API key)                  │
│ • BODY: JSON, form-data, raw, etc. (para POST/PUT)                        │
│                                                                              │
│ PASO 4: HACER CLIC EN [SEND]                                               │
│                                                                              │
│ PASO 5: VER RESPUESTA                                                       │
│ ┌────────────────────────────────────────────────────────────────┐          │
│ │ Status: 200 OK                                                  │          │
│ │                                                                 │          │
│ │ {                                                               │          │
│ │   "id": 1,                                                      │          │
│ │   "nombre": "Juan",                                             │          │
│ │   "email": "juan@email.com"                                    │          │
│ │ }                                                               │          │
│ └────────────────────────────────────────────────────────────────┘          │
└──────────────────────────────────────────────────────────────────────────────┘

┌──────────────────────────────────────────────────────────────────────────────┐
│ EJEMPLOS PRÁCTICOS                                                          │
├──────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│ 📌 EJEMPLO 1: GET simple (JSONPlaceholder)                                 │
│                                                                              │
│ 1. Método: [GET]                                                            │
│ 2. URL: https://jsonplaceholder.typicode.com/posts/1                       │
│ 3. Click [SEND]                                                             │
│ 4. Ver JSON de la película                                                  │
│                                                                              │
│ ─────────────────────────────────────────────────────────────────────────── │
│                                                                              │
│ 📌 EJEMPLO 2: POST con JSON (JSONPlaceholder)                              │
│                                                                              │
│ 1. Método: [POST]                                                           │
│ 2. URL: https://jsonplaceholder.typicode.com/posts                         │
│ 3. Ir a [Body] > seleccionar [raw] > JSON (en dropdown)                   │
│ 4. Escribir:                                                                │
│    {                                                                        │
│      "title": "Mi Post",                                                   │
│      "body": "Contenido del post",                                         │
│      "userId": 1                                                            │
│    }                                                                        │
│ 5. Click [SEND]                                                             │
│                                                                              │
│ ─────────────────────────────────────────────────────────────────────────── │
│                                                                              │
│ 📌 EJEMPLO 3: OMDb API (con API key en parámetros)                        │
│                                                                              │
│ 1. Método: [GET]                                                            │
│ 2. URL: https://www.omdbapi.com                                            │
│ 3. Ir a [Params] y agregar:                                                │
│    Key: s          Value: The Matrix                                       │
│    Key: type       Value: movie                                            │
│    Key: apikey     Value: TU_API_KEY                                       │
│    (Postman construirá automáticamente la URL)                             │
│ 4. Click [SEND]                                                             │
│ 5. Ver resultados de búsqueda                                              │
│                                                                              │
│ ─────────────────────────────────────────────────────────────────────────── │
│                                                                              │
│ 📌 EJEMPLO 4: Headers de autenticación                                     │
│                                                                              │
│ 1. Ir a [Headers] y agregar:                                               │
│    Key: Authorization    Value: Bearer {tu_token}                         │
│    Key: Content-Type     Value: application/json                          │
│ 2. Postman envía estos headers automáticamente                             │
│                                                                              │
└──────────────────────────────────────────────────────────────────────────────┘

┌──────────────────────────────────────────────────────────────────────────────┐
│ CARACTERÍSTICAS AVANZADAS                                                   │
├──────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│ 💾 COLECCIONES (Guardar requests)                                          │
│    • Click derecho en request > Save to collection                         │
│    • Organizar en carpetas (API Películas, API Clima, etc.)               │
│    • Reutilizar cuando sea necesario                                       │
│                                                                              │
│ 🔄 VARIABLES Y ENTORNOS                                                     │
│    • Definir variables globales (base_url, api_key)                       │
│    • Cambiar entre desarrollo/producción                                   │
│    • Uso: {{variable}} en URL o Body                                      │
│                                                                              │
│ 🧪 TESTING                                                                 │
│    • Ir a [Tests] y escribir validaciones                                 │
│    • Verificar status code: pm.response.code | should.equal(200)          │
│                                                                              │
│ 📊 HISTORIA                                                                 │
│    • Postman guarda todas las solicitudes que haces                        │
│    • Acceder desde el panel izquierdo [History]                           │
│                                                                              │
│ 📤 EXPORTAR / COMPARTIR                                                     │
│    • Exportar colecciones como JSON                                        │
│    • Compartir con compañeros (en la nube)                                 │
│    • Documentación automática desde colecciones                            │
│                                                                              │
└──────────────────────────────────────────────────────────────────────────────┘

💡 TIPS Y TRUCOS
═════════════════════════════════════════════════════════════════════════════

✅ Siempre verifica el formato de respuesta (JSON, XML, HTML)
✅ Lee los códigos de estado HTTP (200, 404, 401, 500)
✅ Usa Postman ANTES de implementar en Flutter
✅ Guarda tus colecciones para futuras referencias
✅ Si una API requiere autenticación, guarda la API key en un lugar seguro
✅ Testing en Postman ahorra tiempo depurando en Flutter

⚠️ NUNCA compartas:
   • API keys públicamente
   • Tokens de autenticación
   • Credenciales en screenshots

*/

// ═══════════════════════════════════════════════════════════════════════════════
// 🔧 PLUGINS RECOMENDADOS: Generar Data Classes desde JSON
// ═══════════════════════════════════════════════════════════════════════════════

/*
📌 ¿POR QUÉ USAR UN PLUGIN?

Cuando recibes JSON desde una API, necesitas una clase Dart para:
✅ Acceder seguro a los datos (película.titulo en lugar de json['titulo'])
✅ Type safety (el compilador verifica que exista 'titulo')
✅ Errores detectados en tiempo de compilación, no en tiempo de ejecución
✅ Autocompletado en el IDE

PROBLEMA MANUAL:
Si recibes 50 películas, crear la clase manualmente es tedioso y propenso a errores.

SOLUCIÓN: Plugins que GENERAN automáticamente las clases desde JSON

┌──────────────────────────────────────────────────────────────────────────────┐
│ 1️⃣ QUICKTYPE (Online - Sin instalar nada)                                  │
├──────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│ 🌐 SITIO: https://quicktype.io                                             │
│                                                                              │
│ ✅ PASOS:                                                                   │
│                                                                              │
│ 1. Ir a https://quicktype.io                                               │
│ 2. Seleccionar idioma: [Dart] (en el dropdown)                             │
│ 3. Seleccionar formato de entrada: [JSON] (por defecto)                    │
│ 4. Copiar el JSON de la API en la caja izquierda:                          │
│                                                                              │
│    {                                                                        │
│      "Title": "The Matrix",                                                │
│      "Year": "1999",                                                       │
│      "imdbID": "tt0133093",                                                │
│      "Type": "movie",                                                      │
│      "Poster": "https://m.media-amazon.com/..."                            │
│    }                                                                        │
│                                                                              │
│ 5. Ver el código generado en la caja derecha:                              │
│                                                                              │
│    import 'dart:convert';                                                   │
│                                                                              │
│    Pelicula peliculaFromJson(String str) =>                                │
│      Pelicula.fromJson(json.decode(str));                                 │
│                                                                              │
│    String peliculaToJson(Pelicula data) =>                                 │
│      json.encode(data.toJson());                                           │
│                                                                              │
│    class Pelicula {                                                         │
│      String title;                                                          │
│      String year;                                                           │
│      String imdbId;                                                         │
│      String type;                                                           │
│      String poster;                                                         │
│                                                                              │
│      Pelicula({                                                             │
│        required this.title,                                                │
│        required this.year,                                                 │
│        required this.imdbId,                                               │
│        required this.type,                                                 │
│        required this.poster,                                               │
│      });                                                                   │
│                                                                              │
│      factory Pelicula.fromJson(Map<String, dynamic> json) =>              │
│        Pelicula(                                                            │
│          title: json["Title"],                                             │
│          year: json["Year"],                                               │
│          imdbId: json["imdbID"],                                           │
│          type: json["Type"],                                               │
│          poster: json["Poster"],                                           │
│        );                                                                   │
│                                                                              │
│      Map<String, dynamic> toJson() => {                                    │
│        "Title": title,                                                     │
│        "Year": year,                                                       │
│        "imdbID": imdbId,                                                   │
│        "Type": type,                                                       │
│        "Poster": poster,                                                   │
│      };                                                                    │
│    }                                                                        │
│                                                                              │
│ 6. Copiar y pegar el código en tu proyecto (nuevo archivo lib/models/pelicula.dart)
│                                                                              │
│ ✅ VENTAJAS:                                                                │
│   • Rápido y sin instalaciones                                             │
│   • No requiere build_runner                                               │
│   • Genera métodos fromJson() y toJson()                                  │
│   • Interface visual amigable                                              │
│                                                                              │
│ ❌ DESVENTAJAS:                                                              │
│   • Manual (copiar/pegar)                                                  │
│   • Si la API cambia, regenerar manualmente                               │
│   • Online (requiere internet)                                             │
└──────────────────────────────────────────────────────────────────────────────┘

┌──────────────────────────────────────────────────────────────────────────────┐
│ 2️⃣ JSON TO DART (VS CODE EXTENSION) ⭐ RECOMENDADO para iniciarse con modelos │
├──────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│ 🔌 EXTENSIÓN: "JSON to Dart Model" por ashraf uddin                        │
│                                                                              │
│ 📥 INSTALACIÓN:                                                             │
│ 1. Abrir VS Code > Extensions (Ctrl+Shift+X)                              │
│ 2. Buscar: "JSON to Dart Model"                                            │
│ 3. Click en [Install]                                                      │
│ 4. Reload VS Code                                                          │
│                                                                              │
│ 📍 CÓMO USARLO:                                                             │
│ 1. Copiar un ejemplo de JSON de la API                                     │
│ 2. En VS Code, Nueva pestaña: Cmd+K Cmd+N (crear archivo)                │
│ 3. Click derecho > "Paste JSON as Dart Model"                             │
│ 4. Seleccionar nombre de clase (ej: Pelicula)                             │
│ 5. ¡Genera automáticamente el código!                                      │
│                                                                              │
│ ✅ VENTAJAS:                                                                │
│   • Muy integrado con VS Code                                              │
│   • Super rápido                                                            │
│   • Sin dejar el editor                                                    │
│   • Atajo de teclado después de copiar JSON                               │
│                                                                              │
│ ❌ DESVENTAJAS:                                                              │
│   • A veces genera código duplicado                                         │
│   • Puede necesitar ajustes manuales                                       │
└──────────────────────────────────────────────────────────────────────────────┘

┌──────────────────────────────────────────────────────────────────────────────┐
│ 3️⃣ DART DATA CLASS GENERATOR (VS CODE EXTENSION)          │
├──────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│ 🔌 EXTENSIÓN: "Dart Data Class Generator" por hzgdev                       │
│                                                                              │
│ 📥 INSTALACIÓN:                                                             │
│ 1. Abrir VS Code > Extensions (Ctrl+Shift+X)                              │
│ 2. Buscar: "Dart Data Class Generator"                                     │
│ 3. Click en [Install]                                                      │
│ 4. Reload VS Code                                                          │
│                                                                              │
│ 📍 CÓMO USARLO:                                                             │
│ 1. Crear archivo nuevo: lib/models/pelicula.dart                          │
│ 2. Pegar JSON como comentario:                                              │
│    /*                                                                       │
│    {                                                                        │
│      "Title": "The Matrix",                                                │
│      "Year": "1999",                                                       │
│      "imdbID": "tt0133093",                                                │
│      "Type": "movie",                                                      │
│      "Poster": "https://m.media-amazon.com/"                               │
│    }                                                                        │
│    */                                                                       │
│                                                                              │
│ 3. Seleccionar el comentario JSON                                           │
│ 4. Cmd+Shift+P > "Dart Data Class Generator: Generate from JSON"         │
│ 5. Presionar Enter                                                         │
│ 6. ¡Genera automáticamente la clase con fromJson(), toJson(), copyWith()│
│                                                                              │
│ 📤 CARACTERÍSTICAS ÚNICAS:                                                  │
│   • Genera fromJson() y toJson()                                          │
│   • Genera copyWith() automáticamente ⭐                                  │
│   • Genera toString()                                                      │
│   • Genera hashCode y == personalizados                                   │
│   • Maneja null safety correctamente                                       │
│   • Reconoce tipos complejos (List, Map, anidados)                        │
│                                                                              │
│ 💻 CÓDIGO GENERADO:                                                        │
│   class Pelicula {                                                          │
│     final String title;                                                    │
│     final String year;                                                     │
│     final String imdbId;                                                   │
│     final String type;                                                     │
│     final String poster;                                                   │
│                                                                              │
│     Pelicula({                                                              │
│       required this.title,                                                 │
│       required this.year,                                                  │
│       required this.imdbId,                                                │
│       required this.type,                                                  │
│       required this.poster,                                                │
│     });                                                                     │
│                                                                              │
│     Pelicula copyWith({                                                     │
│       String? title,                                                       │
│       String? year,                                                        │
│       String? imdbId,                                                      │
│       String? type,                                                        │
│       String? poster,                                                      │
│     }) =>                                                                   │
│       Pelicula(                                                             │
│         title: title ?? this.title,                                        │
│         year: year ?? this.year,                                           │
│         imdbId: imdbId ?? this.imdbId,                                     │
│         type: type ?? this.type,                                           │
│         poster: poster ?? this.poster,                                     │
│       );                                                                    │
│                                                                              │
│     factory Pelicula.fromJson(Map<String, dynamic> json) =>              │
│       Pelicula(                                                             │
│         title: json['Title'] as String,                                    │
│         year: json['Year'] as String,                                      │
│         imdbId: json['imdbID'] as String,                                  │
│         type: json['Type'] as String,                                      │
│         poster: json['Poster'] as String,                                  │
│       );                                                                    │
│                                                                              │
│     Map<String, dynamic> toJson() => {                                    │
│       'Title': title,                                                      │
│       'Year': year,                                                        │
│       'imdbID': imdbId,                                                    │
│       'Type': type,                                                        │
│       'Poster': poster,                                                    │
│     };                                                                      │
│   }                                                                         │
│                                                                              │
│ ✅ VENTAJAS:                                                                │
│   • Genera copyWith() (muy útil para immutabilidad)                       │
│   • Super rápido en VS Code                                                │
│   • Reconoce automáticamente tipos (String, int, bool, List, etc.)      │
│   • Genera código limpio y profesional                                     │
│   • Mejor que JSON to Dart (menos errores)                                │
│                                                                              │
│ ❌ DESVENTAJAS:                                                              │
│   • Manual (copiar JSON y generar)                                      │
│   • Si API cambia, regenerar                                               │
│   • No integrado con build_runner (generar código 
      automáticamente basado en anotaciones)                                 │
│                                                                              │
└──────────────────────────────────────────────────────────────────────────────┘

┌──────────────────────────────────────────────────────────────────────────────┐
│ 4️⃣ JSON_SERIALIZABLE (Automático con build_runner)                         │
├──────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│ 📦 INSTALACIÓN:                                                             │
│                                                                              │
│ pubspec.yaml:                                                               │
│   dependencies:                                                             │
│     json_annotation: ^4.8.0                                                │
│   dev_dependencies:                                                         │
│     build_runner: ^2.4.0                                                   │
│     json_serializable: ^6.7.0                                              │
│                                                                              │
│ 📝 CÓDIGO MANUAL (escribes las partes importantes):                        │
│                                                                              │
│ import 'package:json_annotation/json_annotation.dart';                    │
│                                                                              │
│ part 'pelicula.g.dart'; // ← Generate automáticamente                     │
│                                                                              │
│ @JsonSerializable()                                                         │
│ class Pelicula {                                                            │
│   @JsonKey(name: 'Title')                                                  │
│   final String title;                                                      │
│                                                                              │
│   @JsonKey(name: 'Year')                                                   │
│   final String year;                                                       │
│                                                                              │
│   Pelicula({required this.title, required this.year});                    │
│                                                                              │
│   factory Pelicula.fromJson(Map<String, dynamic> json) =>                 │
│     _$PeliculaFromJson(json);                                              │
│                                                                              │
│   Map<String, dynamic> toJson() => _$PeliculaToJson(this);               │
│ }                                                                            │
│                                                                              │
│ 🏃 GENERAR CÓDIGO:                                                          │
│ Terminal > flutter pub run build_runner build                              │
│                                                                              │
│ (Genera automáticamente pelicula.g.dart)                                    │
│                                                                              │
│ ✅ VENTAJAS:                                                                │
│   • Profesional y escalable                                                │
│   • Automático con build_runner                                            │
│   • Genera solo lo que necesitas (@JsonKey)                              │
│   • Manejo de tipos complejos                                              │
│                                                                              │
│ ❌ DESVENTAJAS:                                                              │
│   • Curva de aprendizaje                                                   │
│   • Require build_runner (más lento)                                      │
│   • Archivo .g.dart generado automáticamente                              │
│   • Más código boilerplate                                                 │
└──────────────────────────────────────────────────────────────────────────────┘

┌──────────────────────────────────────────────────────────────────────────────┐
│ 4️⃣ FREEZED (Inmutabilidad + Generación automática)                         │
├──────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│ 🧊 PARA PROYECTOS AVANZADOS                                                │
│                                                                              │
│ 📦 INSTALACIÓN:                                                             │
│   dependencies:                                                             │
│     freezed_annotation: ^2.4.0                                             │
│   dev_dependencies:                                                         │
│     freezed: ^2.4.0                                                        │
│     build_runner: ^2.4.0                                                   │
│                                                                              │
│ 💻 CÓDIGO:                                                                 │
│   import 'package:freezed_annotation/freezed_annotation.dart';            │
│                                                                              │
│   part 'pelicula.freezed.dart';                                            │
│   part 'pelicula.g.dart';                                                  │
│                                                                              │
│   @freezed                                                                 │
│   class Pelicula with _$Pelicula {                                         │
│     const factory Pelicula({                                               │
│       required String title,                                               │
│       required String year,                                               │
│     }) = _Pelicula;                                                        │
│                                                                              │
│     factory Pelicula.fromJson(Map<String, Object?> json) =>              │
│       _$PeliculaFromJson(json);                                            │
│   }                                                                         │
│                                                                              │
│ ✅ VENTAJAS:                                                                │
│   • Clases inmutables por defecto                                          │
│   • copyWith() automático                                                  │
│   • Pattern matching                                                        │
│   • Muy moderno y elegante                                                │
│                                                                              │
│ ❌ DESVENTAJAS:                                                              │
│   • Curva de aprendizaje pronunciada                                       │
│   • Para principiantes es excesivo                                         │
│   • Más tiempo de compilación                                              │
└──────────────────────────────────────────────────────────────────────────────┘

┌──────────────────────────────────────────────────────────────────────────────┐
│ ¿CUÁL USAR?                                                                 │
├──────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│ 👶 PRINCIPIANTES / ESTE CURSO: ⭐⭐⭐                                        │
│    Dart Data Class Generator (VS Code Extension)                           │
│    (Rápido, genera copyWith(), muy fácil de usar, sin build_runner)       │
│                                                                              │
│ 🎓 ALTERNATIVAS PARA PRINCIPIANTES:                                         │
│    QuickType o JSON to Dart Extension                                      │
│    (Si prefieres sin extensiones instaladas)                               │
│                                                                              │
│ 📚 PROYECTOS MEDIANOS/EMPRESARIALES:                                        │
│    json_serializable                                                        │
│    (Automático con build_runner, escalable, profesional)                  │
│                                                                              │
│ 🚀 PROYECTOS GRANDES / CÓDIGO CRÍTICO:                                      │
│    Freezed                                                                  │
│    (Inmutable, robusto, patterns avanzados, máxima seguridad)             │
│                                                                              │
└──────────────────────────────────────────────────────────────────────────────┘

📝 EJEMPLO PRÁCTICO: API de Películas OMDb

JSON de respuesta:
{
  "Search": [
    {
      "Title": "The Matrix",
      "Year": "1999",
      "imdbID": "tt0133093",
      "Type": "movie",
      "Poster": "https://m.media-amazon.com/..."
    }
  ],
  "totalResults": "145",
  "Response": "True"
}

Necesitas 2 clases:
• Película (para cada item en Search)
• Búsqueda (para la respuesta completa)

CON QUICKTYPE:
Copia el JSON → Genera ambas clases → Copiar/pegar → Listo

EN FLUTTER:
final json = jsonDecode(response.body);
final busqueda = BusquedaResponse.fromJson(json);
for (var pelicula in busqueda.search) {
  print(pelicula.title);  // Type-safe ✅
}

*/

// ═══════════════════════════════════════════════════════════════════════════════
// FLUJO DE CONSUMO DE API
// ═══════════════════════════════════════════════════════════════════════════════

/*
FLUJO RECOMENDADO:
1️⃣ PROBAR CON POSTMAN primero
2️⃣ GENERAR CLASES desde JSON (QuickType/json_to_dart)
3️⃣ IMPLEMENTAR en Flutter con las clases
4️⃣ MANEJAR errores y excepciones

PASO 1: HACER LA SOLICITUD (GET)
┌─────────────────────────────────────────────────────┐
│ var response = await http.get(                      │
│   Uri.parse('https://jsonplaceholder.typicode.com'  │
│     '/posts/1'),                                    │
│ );                                                   │
└─────────────────────────────────────────────────────┘

PASO 2: VERIFICAR ESTATUS
┌─────────────────────────────────────────────────────┐
│ if (response.statusCode == 200) {                   │
│   // Éxito: procesar datos                          │
│ } else {                                            │
│   // Error: mostrar mensaje                         │
│ }                                                    │
└─────────────────────────────────────────────────────┘

PASO 3: DECODIFICAR JSON
┌─────────────────────────────────────────────────────┐
│ final Map<String, dynamic> json =                   │
│   jsonDecode(response.body);                        │
│                                                     │
│ // O convertir a modelo                            │
│ final post = Post.fromJson(json);                  │
└─────────────────────────────────────────────────────┘

PASO 4: ACTUALIZAR UI
┌─────────────────────────────────────────────────────┐
│ setState(() {                                       │
│   datos = json;                                     │
│   isLoading = false;                                │
│ });                                                 │
└─────────────────────────────────────────────────────┘

PASO 5: MANEJO DE ERRORES
┌─────────────────────────────────────────────────────┐
│ try {                                               │
│   // Solicitud                                      │
│ } on SocketException {                              │
│   // Error de conexión                              │
│ } on TimeoutException {                             │
│   // Tiempo agotado                                 │
│ } catch (e) {                                       │
│   // Error general                                  │
│ }                                                   │
└─────────────────────────────────────────────────────┘
*/

// ═══════════════════════════════════════════════════════════════════════════════
// APIs PÚBLICAS GRATUITAS PARA PRACTICAR
// ═══════════════════════════════════════════════════════════════════════════════

/*
📌 AEMET (Agencia Estatal de Meteorología - España) 🌤️
URL: https://www.aemet.es/es/datos_abiertos/AEMET_OpenData
- API meteorológica oficial de España
- Datos de temperaturа, precipitación, predicción
- Requiere API key gratuita (registro recomendado)
- Cobertura: toda España con datos en tiempo real
- Ejemplo: https://opendata.aemet.es/opendata/api/prediccion/especifica/municipio/diaria/28079

📌 JSONPlaceholder (Excelente para aprender)
URL: https://jsonplaceholder.typicode.com
- Fake usuarios, posts, comentarios
- Péeerfecto para testing
- Ejemplo GET: https://jsonplaceholder.typicode.com/posts/1

📌 OpenWeatherMap (Datos meteorológicos)
URL: https://openweathermap.org
- Requiere API key gratuita
- Datos de clima en tiempo real
- Ejemplo: https://api.openweathermap.org/data/2.5/weather?q=Madrid

📌 Rick and Morty (Characters)
URL: https://rickandmortyapi.com
- Base de datos de personajes
- Completamente gratuita
- Ejemplo GET: https://rickandmortyapi.com/api/character/1

📌 OMDb API (The Open Movie Database) 🎬
URL: https://www.omdbapi.com
- 500,000+ películas y series
- Requiere API key gratuita (1,000 req/día)
- Buscar películas, obtener detalles, calificaciones
- Ejemplo: https://www.omdbapi.com/?s=The Matrix&apikey=YOUR_KEY
- Incluye IMDb ratings, posters, actores, sinopsis

📌 IMDb API (Alternativa no oficial) 🎭
URL: https://imdb.iamidiotareyoutoo.com
- API alternativa de IMDb (sin autenticación)
- Información de películas, actores, rankings
- Completamente gratuita
- Ejemplo: https://imdb.iamidiotareyoutoo.com/search?q=The Matrix
- ⚠️ Nota: API no oficial, puede tener cambios

📌 PokéAPI (Datos de Pokémon)
URL: https://pokeapi.co
- Información completa de Pokémon
- Gratuita y sin autenticación
- Ejemplo GET: https://pokeapi.co/api/v2/pokemon/pikachu

📌 TheCatAPI (Imágenes de gatos)
URL: https://thecatapi.com
- Imágenes aleatorias de gatos
- Datos sobre razas
- Requiere API key gratuita
*/

// ═══════════════════════════════════════════════════════════════════════════════
// SERIALIZACIÓN / DESERIALIZACIÓN JSON
// ═══════════════════════════════════════════════════════════════════════════════

/*
JSON es un formato de texto para intercambiar datos.

EJEMPLO JSON:
{
  "id": 1,
  "nombre": "Juan",
  "email": "juan@ejemplo.com",
  "edad": 25
}

CONVERTIR JSON → OBJETO DART:

  // Opción 1: Manualmente
  class Usuario {
    int id;
    String nombre;
    String email;
    int edad;

    factory Usuario.fromJson(Map<String, dynamic> json) {
      return Usuario(
        id: json['id'] as int,
        nombre: json['nombre'] as String,
        email: json['email'] as String,
        edad: json['edad'] as int,
      );
    }
  }

  // Opción 2: Con json_serializable (generado automáticamente)
  @JsonSerializable()
  class Usuario {
    int id;
    String nombre;
    String email;
    int edad;

    factory Usuario.fromJson(Map<String, dynamic> json) =>
      _$UsuarioFromJson(json);
  }

CONVERTIR OBJETO DART → JSON:

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'email': email,
      'edad': edad,
    };
  }

LISTAS EN JSON:

  [
    {"id": 1, "nombre": "Juan"},
    {"id": 2, "nombre": "María"}
  ]

  // En Dart:
  final List<dynamic> jsonList = jsonDecode(response.body);
  final usuarios = jsonList
    .map((item) => Usuario.fromJson(item))
    .toList();
*/

// ═══════════════════════════════════════════════════════════════════════════════
// MANEJO DE ERRORES COMUNES
// ═══════════════════════════════════════════════════════════════════════════════

/*
ERROR: SocketException
├─ CAUSA: No hay conexión a internet
└─ SOLUCIÓN: Verificar conexión, usar try-catch

ERROR: TimeoutException
├─ CAUSA: Servidor tardó demasiado
└─ SOLUCIÓN: Aumentar timeout, reintentar

ERROR: FormatException (JSON)
├─ CAUSA: Respuesta no es JSON válido
└─ SOLUCIÓN: Verificar response.body, validar con try-catch

ERROR: 404 Not Found
├─ CAUSA: URL o endpoint incorrecto
└─ SOLUCIÓN: Verificar documentación de API

ERROR: 401 Unauthorized
├─ CAUSA: Falta autenticación/API key
└─ SOLUCIÓN: Agregar headers de autenticación

ERROR: 429 Too Many Requests
├─ CAUSA: Demasiadas solicitudes
└─ SOLUCIÓN: Agregar delay entre requests
*/

// ═══════════════════════════════════════════════════════════════════════════════
// 🎬 OMDb API (The Open Movie Database)
// ═══════════════════════════════════════════════════════════════════════════════

/*
📺 ¿QUÉ ES OMDb API?

OMDb (Open Movie Database) es una API GRATUITA que proporciona información
sobre películas, series y temporadas de TV.

🌐 SITIO OFICIAL: https://www.omdbapi.com/

┌──────────────────────────────────────────────────────────────────────────────┐
│ CARACTERÍSTICAS                                                              │
├──────────────────────────────────────────────────────────────────────────────┤
│ ✅ Base de datos con 500,000+ películas y series                           │
│ ✅ Búsqueda por título, año, tipo (película/serie)                        │
│ ✅ Información detallada (actores, directores, sinopsis, etc.)            │
│ ✅ Calificaciones (IMDb, Rotten Tomatoes, Metacritic)                    │
│ ✅ Imágenes de posters                                                    │
│ ✅ API RESTful simple de usar                                             │
│ ✅ Plan gratuito: 1,000 solicitudes/día                                  │
│ ✅ No requiere autenticación en plan free (solo API key)                │
└──────────────────────────────────────────────────────────────────────────────┘

┌──────────────────────────────────────────────────────────────────────────────┐
│ PASOS PARA USAR OMDb API                                                    │
├──────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│ 1️⃣ REGISTRARSE Y OBTENER API KEY                                           │
│   → Ir a https://www.omdbapi.com/apikey.aspx                              │
│   → Email: tu_email@ejemplo.com                                             │
│   → Plan: Selecciona "FREE" (1,000 req/día)                               │
│   → Acepta términos                                                         │
│   → Recibirás tu API key por email                                         │
│   → Guardar: xxxxxxxxxxxxxxxx (nunca compartir)                             │
│                                                                              │
│ 2️⃣ INSTALAR PACKAGE HTTP                                                 │
│   pubspec.yaml:                                                             │
│     dependencies:                                                            │
│       http: ^1.1.0                                                         │
│                                                                              │
│ 3️⃣ HACER SOLICITUDES A LA API                                             │
│   URL BASE: https://www.omdbapi.com/                                      │
│   PARÁMETRO REQUERIDO: apikey=TU_API_KEY                                 │
└──────────────────────────────────────────────────────────────────────────────┘

┌──────────────────────────────────────────────────────────────────────────────┐
│ ENDPOINDS DISPONIBLES                                                       │
├──────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│ 1. BÚSQUEDA POR TÍTULO                                                     │
│    URL: https://www.omdbapi.com/?s=NombrePelicula&apikey=TU_KEY          │
│    Parámetros opcionales:                                                   │
│      • type=movie (película) | series (serie) | episode                    │
│      • y=AÑO (ej: 2020)                                                    │
│      • page=PÁGINA (ej: 1, 2, 3... máx 100 resultados/página)            │
│                                                                              │
│    Ejemplo:                                                                 │
│    https://www.omdbapi.com/?s=The Matrix&type=movie&y=1999&apikey=KEY    │
│                                                                              │
│    Respuesta:                                                               │
│    {                                                                         │
│      "Search": [                                                            │
│        {                                                                    │
│          "Title": "The Matrix",                                            │
│          "Year": "1999",                                                   │
│          "imdbID": "tt0133093",                                           │
│          "Type": "movie",                                                  │
│          "Poster": "https://m.media-amazon.com/..."                       │
│        }                                                                    │
│      ],                                                                     │
│      "totalResults": "145",                                                │
│      "Response": "True"                                                    │
│    }                                                                         │
│                                                                              │
│ 2. OBTENER DETALLES COMPLETOS                                              │
│    URL: https://www.omdbapi.com/?i=IMDB_ID&apikey=TU_KEY                 │
│    O: https://www.omdbapi.com/?t=TITULO&apikey=TU_KEY                    │
│                                                                              │
│    Parámetro:                                                               │
│      • i=IDIMDB (ej: tt0133093 - recomendado)                             │
│      • t=TITULO (ej: The Matrix)                                           │
│      • type=movie|series|episode (opcional)                               │
│      • plot=short|full (cantidad de sinopsis)                             │
│                                                                              │
│    Ejemplo:                                                                 │
│    https://www.omdbapi.com/?i=tt0133093&plot=full&apikey=KEY             │
│                                                                              │
│    Respuesta:                                                               │
│    {                                                                         │
│      "Title": "The Matrix",                                                │
│      "Year": "1999",                                                       │
│      "Rated": "R",                                                         │
│      "Released": "31 Mar 1999",                                           │
│      "Runtime": "136 min",                                                 │
│      "Director": "The Wachowskis",                                         │
│      "Plot": "A hacker's life...",                                        │
│      "Actors": "Keanu Reeves, Laurence Fishburne, Carrie-Anne Moss",    │
│      "imdbRating": "8.7",                                                 │
│      "Ratings": [                                                          │
│        {"Source": "Internet Movie Database", "Value": "8.7/10"},         │
│        {"Source": "Rotten Tomatoes", "Value": "88%"},                    │
│        {"Source": "Metacritic", "Value": "73/100"}                       │
│      ],                                                                     │
│      "imdbID": "tt0133093",                                               │
│      "Poster": "https://m.media-amazon.com/..."                          │
│    }                                                                         │
└──────────────────────────────────────────────────────────────────────────────┘

┌──────────────────────────────────────────────────────────────────────────────┐
│ EJEMPLO DE CÓDIGO EN FLUTTER                                               │
├──────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  import 'package:http/http.dart' as http;                                  │
│  import 'dart:convert';                                                     │
│                                                                              │
│  const String apiKey = 'TU_API_KEY_AQUI';                                │
│  const String baseUrl = 'https://www.omdbapi.com/';                      │
│                                                                              │
│  // Buscar películas                                                        │
│  Future<List<dynamic>> buscarPeliculas(String titulo) async {             │
│    final url = '$baseUrl?s=$titulo&type=movie&apikey=$apiKey';           │
│                                                                              │
│    try {                                                                    │
│      final response = await http.get(Uri.parse(url));                     │
│                                                                              │
│      if (response.statusCode == 200) {                                     │
│        final json = jsonDecode(response.body);                             │
│                                                                              │
│        if (json['Response'] == 'True') {                                   │
│          return json['Search'] ?? [];                                      │
│        } else {                                                             │
│          print('Error: ${json['Error']}');                                 │
│          return [];                                                         │
│        }                                                                    │
│      } else {                                                               │
│        print('Error HTTP: ${response.statusCode}');                        │
│        return [];                                                           │
│      }                                                                      │
│    } catch (e) {                                                            │
│      print('Excepción: $e');                                               │
│      return [];                                                             │
│    }                                                                        │
│  }                                                                          │
│                                                                              │
│  // Obtener detalles de una película                                        │
│  Future<Map<String, dynamic>?> obtenerDetalles(String imdbId) async {     │
│    final url = '$baseUrl?i=$imdbId&plot=full&apikey=$apiKey';            │
│                                                                              │
│    try {                                                                    │
│      final response = await http.get(Uri.parse(url));                     │
│                                                                              │
│      if (response.statusCode == 200) {                                     │
│        final json = jsonDecode(response.body);                             │
│        return json;                                                         │
│      }                                                                      │
│      return null;                                                           │
│    } catch (e) {                                                            │
│      print('Error: $e');                                                   │
│      return null;                                                           │
│    }                                                                        │
│  }                                                                          │
└──────────────────────────────────────────────────────────────────────────────┘

┌──────────────────────────────────────────────────────────────────────────────┐
│ LÍMITES Y CONSIDERACIONES                                                  │
├──────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│ ⏱️ LÍMITES (Plan FREE):                                                    │
│   • 1,000 solicitudes por día                                              │
│   • 1 solicitud por segundo (máximo)                                       │
│   • Sin acceso a datos completos en búsqueda                              │
│   • Limite de posters: resolución normal (no HD)                          │
│                                                                              │
│ 💰 PLANES PAGOS (si necesitas más):                                        │
│   • Patreon: $1-5 USD/mes para más solicitudes                            │
│   • Empresa: Contactar directamente                                         │
│                                                                              │
│ ⚠️ ERRORES COMUNES:                                                         │
│   • 401: API key inválida o expirada                                      │
│   • 404: Película no encontrada                                            │
│   • 429: Demasiadas solicitudes (esperar)                                 │
│   • "Response": "False" + Error: Extra spaces in search                   │
│     → Usar URLEncoding para caracteres especiales                         │
│                                                                              │
│ 🔒 SEGURIDAD:                                                              │
│   • NUNCA poner API key en código público                                 │
│   • Usar variables de entorno: .env (ej: flutter_dotenv)                 │
│   • O guardarla en backend, no en cliente                                │
│   • Considerar obfuscation en release builds                              │
└──────────────────────────────────────────────────────────────────────────────┘

┌──────────────────────────────────────────────────────────────────────────────┐
│ URLENCODING PARA BÚSQUEDAS ESPECIALES                                      │
├──────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  import 'package:http/http.dart' as http;                                  │
│                                                                              │
│  // Buscar con caracteres especiales                                        │
│  String titulo = "The Lord of the Rings: The Fellowship of the Ring";    │
│  String encoded = Uri.encodeComponent(titulo);                             │
│  String url = 'https://www.omdbapi.com/?s=$encoded&apikey=$apiKey';      │
│                                                                              │
│  // Ahora manejará correctamente: espacios, dos puntos, etc.             │
└──────────────────────────────────────────────────────────────────────────────┘

*/

// ═══════════════════════════════════════════════════════════════════════════════
// PARA ESTE CURSO
// ═══════════════════════════════════════════════════════════════════════════════

/*
📌 DÍA 13: CONSUMO DE APIs CON HTTP PACKAGE

✅ Usamos HTTP porque:
  • Es la opción más simple y educativa
  • Documentación oficial de Google
  • Verdadero aprendizaje sin "magia"
  • Perfecto para entender conceptos
  • Ya conocen las alternativas (Dio, Retrofit)

📈 PRÓXIMAS LECCIONES (futuro):
  • Día 14: Dio package para casos avanzados
  • Día 15: Autenticación (API keys, JWT)
  • Día 16: Duplexación de imágenes desde URLs
  • Día 17: Sincronización offline

💡 REGLA DE ORO:
  "Empieza simple con HTTP, evoluciona con Dio cuando lo necesites"
*/
