import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

/*
╔═══════════════════════════════════════════════════════════════════════════════╗
║  EJERCICIO: CONSULTADOR DE CLIMA POR PROVINCIA EN ESPAÑA                     ║
║                                                                               ║
║  API: https://api.open-meteo.com/v1/forecast (¡Gratuita y sin API key!)     ║
║                                                                               ║
║  Objetivos de aprendizaje:                                                   ║
║  ✓ Consultar APIs públicas sin autenticación                                 ║
║  ✓ Parsear JSON anidado (response.current)                                   ║
║  ✓ Crear modelos con factory.fromJson()                                      ║
║  ✓ Manejo de estados (loading, error, data)                                  ║
║  ✓ Dropdown para seleccionar ciudades                                        ║
║  ✓ Manejo de errores HTTP y de conexión                                      ║
╚═══════════════════════════════════════════════════════════════════════════════╝
*/

void main() {
  runApp(const ClimaApp());
}

// ═══════════════════════════════════════════════════════════════════════════════
// PASO 1: CREAR EL MODELO CLIMA
// ═══════════════════════════════════════════════════════════════════════════════

/*
TODO: Crea una clase Clima que tenga:

PROPIEDADES REQUERIDAS:
- temperatura (double): temperatura en grados Celsius
- descripcion (String): descripción del clima (ej: "Soleado", "Nublado")
- humedad (int): porcentaje de humedad (0-100)
- velocidadViento (double): velocidad del viento en km/h
- codigoClima (int): código numérico del tipo de clima

CONSTRUCTOR:
- Constructor normal requerido con todos los parámetros

FACTORY:
- factory Clima.fromJson(Map<String, dynamic> json)
  * Extrae los valores del JSON de Open-Meteo
  * Mapea: temperature_2m → temperatura
  * Mapea: weather_code → codigoClima
  * Mapea: relative_humidity_2m → humedad
  * Mapea: wind_speed_10m → velocidadViento
  * Mapea: codigoClima → descripcion usando getDescripcion()

MÉTODO:
- String getDescripcion() 
  * Convierte el código de clima en una descripción legible
  * Usa este mapeo:
    - 0: "Cielo despejado"
    - 1, 2: "Parcialmente nublado"
    - 3: "Nublado"
    - 45, 48: "Neblina"
    - 51-67: "Lluvia"
    - 80-82: "Lluvia fuerte"
    - 85, 86: "Nieve"
    - default: "Desconocido"
*/

class Clima {
  // TODO: Aquí va tu implementación
}

// ═══════════════════════════════════════════════════════════════════════════════
// PASO 2: APP PRINCIPAL
// ═══════════════════════════════════════════════════════════════════════════════

class ClimaApp extends StatelessWidget {
  const ClimaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clima España',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const ClimaPage(),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// PASO 3: PÁGINA PRINCIPAL CON ESTADO
// ═══════════════════════════════════════════════════════════════════════════════

class ClimaPage extends StatefulWidget {
  const ClimaPage({super.key});

  @override
  State<ClimaPage> createState() => _ClimaPageState();
}

class _ClimaPageState extends State<ClimaPage> {
  // TODO: Declara las variables necesarias:
  // - Clima? climaActual = null
  // - bool isLoading = false
  // - String? error
  // - String ciudadSeleccionada = 'Madrid'

  final Map<String, Map<String, double>> ciudades = {
    'Madrid': {'lat': 40.4168, 'lon': -3.7038},
    'Barcelona': {'lat': 41.3851, 'lon': 2.1734},
    'Valencia': {'lat': 39.4699, 'lon': -0.3763},
    'Sevilla': {'lat': 37.3886, 'lon': -5.9823},
    'Bilbao': {'lat': 43.2632, 'lon': -2.9349},
    'Málaga': {'lat': 36.7213, 'lon': -4.4214},
    'Zaragoza': {'lat': 41.6561, 'lon': -0.8773},
    'Córdoba': {'lat': 37.8882, 'lon': -4.7794},
    'Toledo': {'lat': 39.8619, 'lon': -4.0200},
    'Gijón': {'lat': 43.5319, 'lon': -5.6619},
  };

  @override
  void initState() {
    super.initState();
    // TODO: Llama a _cargarClima() aquí
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // PASO 4: MÉTODO PARA CARGAR CLIMA DESDE API
  // ═══════════════════════════════════════════════════════════════════════════

  /*
  TODO: Implementa Future<void> _cargarClima() async que:
  
  1. Obtén las coordenadas de la ciudad seleccionada
  2. Construye la URL:
     https://api.open-meteo.com/v1/forecast?latitude=LAT&longitude=LON&current=temperature_2m,weather_code,relative_humidity_2m,wind_speed_10m
  
  3. Haz un GET request con try-catch:
     - Timeout: 10 segundos
     - Headers: 'Accept': 'application/json'
  
  4. Si statusCode == 200:
     - Decodifica el JSON: jsonDecode(response.body)
     - Accede a ['current'] para obtener los datos actuales
     - Crea un Clima usando .fromJson()
     - setState con climaActual
  
  5. Si hay SocketException: error = 'Sin conexión a internet'
  
  6. Si hay TimeoutException: error = 'Solicitud tardó demasiado'
  
  7. Para otros errores: error = 'Error: {e.toString()}'
  
  8. Siempre actualiza isLoading = false al final
  */

  Future<void> _cargarClima() async {
    // TODO: Aquí va tu implementación
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🌤 Clima España'),
        backgroundColor: Colors.blue[600],
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // TODO: SELECTOR DE CIUDAD
              // 1. Crea un DropdownButton que liste ciudades
              // 2. Al cambiar, actualiza ciudadSeleccionada
              // 3. Llama a _cargarClima()

              const SizedBox(height: 24),

              // TODO: MOSTRAR CONTENIDO
              // Usa _construirContenido() para mostrar:
              // - Si isLoading: CircularProgressIndicator + "Cargando..."
              // - Si error != null: Icono de error + mensaje
              // - Si climaActual != null: Tarjeta con los datos
              // - Sino: Mensaje "Selecciona una ciudad"

              _construirContenido(),

              const SizedBox(height: 24),

              // TODO: BOTÓN REFRESCAR
              // ElevatedButton.icon con onPressed: _cargarClima
            ],
          ),
        ),
      ),
    );
  }

  Widget _construirContenido() {
    // TODO: Implementa la lógica de estados aquí
    return const SizedBox.shrink();
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// INSTRUCCIONES FINALES
// ═══════════════════════════════════════════════════════════════════════════════

/*
CHECKLIST DE IMPLEMENTACIÓN:

□ PASO 1: clase Clima
  □ Propiedades: temperatura, descripcion, humedad, velocidadViento, codigoClima
  □ Constructor normal con parámetros
  □ factory fromJson() que mapea correctamente los campos
  □ Método getDescripcion() con todos los códigos de clima

□ PASO 2: Variables de estado en _ClimaPageState
  □ climaActual (nullable)
  □ isLoading (bool)
  □ error (String? nullable)
  □ ciudadSeleccionada (String)

□ PASO 3: initState
  □ Llama a _cargarClima()

□ PASO 4: _cargarClima() async
  □ Obtiene coordenadas de ciudades[ciudadSeleccionada]
  □ Construye URL correctamente
  □ Hace GET request con timeout
  □ Parsea JSON y accede a ['current']
  □ Crea Clima.fromJson()
  □ Maneja SocketException, TimeoutException, generic Exception
  □ Actualiza estado con setState

□ PASO 5: build()
  □ DropdownButton para seleccionar ciudad
  □ Botón Refrescar
  □ Llama a _construirContenido()

□ PASO 6: _construirContenido()
  □ IF isLoading: muestra spinner circular
  □ IF error != null: muestra mensaje de error con ícono
  □ IF climaActual != null: muestra tarjeta con datos
     - Temperatura en grande
     - Descripción del clima
     - Humedad con icono
     - Velocidad del viento con icono
  □ ELSE: muestra "Selecciona una ciudad"

BONUS (Opcional):
  ☐ Agrega más ciudades al diccionario
  ☐ Colorea la tarjeta según la temperatura (rojo si >25°, azul si <5°, etc)
  ☐ Muestra un ícono diferente según el tipo de clima
  ☐ Guarda la última ciudad seleccionada en SharedPreferences
*/
