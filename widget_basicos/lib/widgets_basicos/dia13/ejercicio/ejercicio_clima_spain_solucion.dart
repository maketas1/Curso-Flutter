import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

/*
╔═══════════════════════════════════════════════════════════════════════════════╗
║  SOLUCIÓN: CONSULTADOR DE CLIMA POR PROVINCIA EN ESPAÑA                      ║
║                                                                               ║
║  API: https://api.open-meteo.com/v1/forecast (Gratuita y sin API key)       ║
║                                                                               ║
║  Funcionalidades implementadas:                                              ║
║  ✓ Consultar APIs públicas sin autenticación                                 ║
║  ✓ Parsear JSON anidado (response.current)                                   ║
║  ✓ Crear modelos con factory.fromJson()                                      ║
║  ✓ Manejo de estados (loading, error, data)                                  ║
║  ✓ Dropdown para seleccionar ciudades                                        ║
║  ✓ Manejo de errores HTTP y de conexión                                      ║
║  ✓ UI responsiva con tarjetas atractivas                                     ║
╚═══════════════════════════════════════════════════════════════════════════════╝
*/

void main() {
  runApp(const ClimaApp());
}

// ═══════════════════════════════════════════════════════════════════════════════
// PASO 1: MODELO DE DATOS - CLIMA
// ═══════════════════════════════════════════════════════════════════════════════

class Clima {
  final double temperatura;
  final String descripcion;
  final int humedad;
  final double velocidadViento;
  final int codigoClima;

  Clima({
    required this.temperatura,
    required this.descripcion,
    required this.humedad,
    required this.velocidadViento,
    required this.codigoClima,
  });

  /// Factory constructor para deserializar JSON de la API Open-Meteo
  factory Clima.fromJson(Map<String, dynamic> json) {
    final int codigoClima = json['weather_code'] as int? ?? 0;

    return Clima(
      temperatura: (json['temperature_2m'] as num?)?.toDouble() ?? 0.0,
      codigoClima: codigoClima,
      descripcion: _getDescripcion(codigoClima),
      humedad: json['relative_humidity_2m'] as int? ?? 0,
      velocidadViento: (json['wind_speed_10m'] as num?)?.toDouble() ?? 0.0,
    );
  }

  /// Convierte el código WMO de clima a descripción en español
  static String _getDescripcion(int codigoClima) {
    switch (codigoClima) {
      case 0:
        return 'Cielo despejado';
      case 1 || 2:
        return 'Parcialmente nublado';
      case 3:
        return 'Nublado';
      case 45 || 48:
        return 'Neblina';
      case 51 || 53 || 55 || 61 || 63 || 65:
        return 'Lluvia';
      case 67 || 80 || 81 || 82:
        return 'Lluvia fuerte';
      case 85 || 86:
        return 'Nieve';
      default:
        return 'Desconocido';
    }
  }

  /// Retorna un ícono según el tipo de clima
  IconData getIcono() {
    switch (codigoClima) {
      case 0:
        return Icons.wb_sunny;
      case 1 || 2:
        return Icons.wb_cloudy;
      case 3:
        return Icons.cloud;
      case 45 || 48:
        return Icons.cloud_queue;
      case 51 || 53 || 55 || 61 || 63 || 65 || 67 || 80 || 81 || 82:
        return Icons.grain;
      case 85 || 86:
        return Icons.ac_unit;
      default:
        return Icons.help_outline;
    }
  }

  /// Retorna un color según la temperatura
  Color getColorTemperatura() {
    if (temperatura > 30) {
      return Colors.red[400]!;
    } else if (temperatura > 20) {
      return Colors.orange[400]!;
    } else if (temperatura > 10) {
      return Colors.blue[400]!;
    } else {
      return Colors.blue[700]!;
    }
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// APP PRINCIPAL
// ═══════════════════════════════════════════════════════════════════════════════

class ClimaApp extends StatelessWidget {
  const ClimaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clima España',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue[600],
          centerTitle: true,
          elevation: 0,
        ),
      ),
      home: const ClimaPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// PÁGINA PRINCIPAL
// ═══════════════════════════════════════════════════════════════════════════════

class ClimaPage extends StatefulWidget {
  const ClimaPage({super.key});

  @override
  State<ClimaPage> createState() => _ClimaPageState();
}

class _ClimaPageState extends State<ClimaPage> {
  // Variables de estado
  Clima? climaActual;
  bool isLoading = false;
  String? error;
  String ciudadSeleccionada = 'Madrid';

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
    _cargarClima();
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // PASO 4: CARGAR CLIMA DESDE API
  // ═══════════════════════════════════════════════════════════════════════════

  Future<void> _cargarClima() async {
    try {
      // Obtener coordenadas de la ciudad seleccionada
      final coordenadas = ciudades[ciudadSeleccionada];
      if (coordenadas == null) {
        setState(() {
          error = 'Ciudad no encontrada';
          isLoading = false;
        });
        return;
      }

      setState(() {
        isLoading = true;
        error = null;
        climaActual = null;
      });

      // Construir URL de la API
      // Documentación: https://open-meteo.com/en/docs
      final url =
          'https://api.open-meteo.com/v1/forecast?'
          'latitude=${coordenadas['lat']}'
          '&longitude=${coordenadas['lon']}'
          '&current=temperature_2m,weather_code,relative_humidity_2m,wind_speed_10m'
          '&timezone=Europe/Madrid';

      debugPrint('📍 Consultando: $url');

      // Hacer la solicitud GET con timeout
      final response = await http
          .get(Uri.parse(url), headers: {'Accept': 'application/json'})
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () =>
                throw TimeoutException('La solicitud tardó demasiado tiempo'),
          );

      debugPrint('Status: ${response.statusCode}');

      if (response.statusCode == 200) {
        // Decodificar JSON
        final json = jsonDecode(response.body) as Map<String, dynamic>;

        // Acceder a la sección 'current' que contiene los datos actuales
        final currentData = json['current'] as Map<String, dynamic>?;

        if (currentData == null) {
          throw Exception('Datos actuales no disponibles en la respuesta');
        }

        // Crear instancia de Clima
        final clima = Clima.fromJson(currentData);

        setState(() {
          climaActual = clima;
          isLoading = false;
        });

        debugPrint(
          '✅ Clima cargado: ${clima.temperatura}°C, ${clima.descripcion}',
        );
      } else {
        throw Exception(
          'Error ${response.statusCode}: ${response.reasonPhrase}',
        );
      }
    } on SocketException catch (e) {
      debugPrint('❌ Error de conexión: $e');
      setState(() {
        error = 'Sin conexión a internet ☁️';
        isLoading = false;
      });
    } on TimeoutException catch (e) {
      debugPrint('❌ Timeout: $e');
      setState(() {
        error = 'La solicitud tardó demasiado tiempo ⏱️';
        isLoading = false;
      });
    } catch (e) {
      debugPrint('❌ Error: $e');
      setState(() {
        error = 'Error: ${e.toString()}';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🌤 Clima España'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // SELECTOR DE CIUDAD
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue[400]!),
                borderRadius: BorderRadius.circular(12),
              ),
              child: DropdownButton<String>(
                value: ciudadSeleccionada,
                isExpanded: true,
                underline: const SizedBox(),
                items: ciudades.keys.map((ciudad) {
                  return DropdownMenuItem(
                    value: ciudad,
                    child: Text(
                      ciudad,
                      style: const TextStyle(fontSize: 16),
                    ),
                  );
                }).toList(),
                onChanged: (nuevoValor) {
                  if (nuevoValor != null) {
                    setState(() {
                      ciudadSeleccionada = nuevoValor;
                    });
                    _cargarClima();
                  }
                },
              ),
            ),

            const SizedBox(height: 24),

            // CONTENIDO PRINCIPAL
            _construirContenido(),

            const SizedBox(height: 24),

            // BOTÓN REFRESCAR
            ElevatedButton.icon(
              onPressed: isLoading ? null : _cargarClima,
              icon: const Icon(Icons.refresh),
              label: const Text('Refrescar'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
                backgroundColor: Colors.blue[600],
                disabledBackgroundColor: Colors.grey[300],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _construirContenido() {
    // Estado: Cargando
    if (isLoading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Text(
              'Cargando clima de $ciudadSeleccionada...',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 40),
          ],
        ),
      );
    }

    // Estado: Error
    if (error != null) {
      return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.red[50],
          border: Border.all(color: Colors.red[400]!),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(Icons.error_outline, color: Colors.red[600], size: 48),
            const SizedBox(height: 12),
            Text(
              error ?? 'Error desconocido',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.red[700],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }

    // Estado: Datos cargados
    if (climaActual != null) {
      final clima = climaActual!;

      return Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue[300]!,
              Colors.blue[600]!,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            // Ícono y ciudad
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  clima.getIcono(),
                  size: 60,
                  color: Colors.white,
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ciudadSeleccionada,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      clima.descripcion,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Temperatura grande
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                '${clima.temperatura.toStringAsFixed(1)}°C',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 56,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Grid de detalles
            Row(
              children: [
                // Humedad
                Expanded(
                  child: _buildDetalleCard(
                    icono: Icons.opacity,
                    titulo: 'Humedad',
                    valor: '${clima.humedad}%',
                  ),
                ),
                const SizedBox(width: 12),
                // Viento
                Expanded(
                  child: _buildDetalleCard(
                    icono: Icons.air,
                    titulo: 'Viento',
                    valor: '${clima.velocidadViento.toStringAsFixed(1)} km/h',
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    // Estado: Sin datos
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          Icon(
            Icons.cloud_queue,
            size: 80,
            color: Colors.blue[200],
          ),
          const SizedBox(height: 16),
          Text(
            'Selecciona una ciudad para ver el clima',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  /// Widget para mostrar detalles (humedad, viento, etc.)
  Widget _buildDetalleCard({
    required IconData icono,
    required String titulo,
    required String valor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icono, color: Colors.white, size: 28),
          const SizedBox(height: 8),
          Text(
            titulo,
            style: const TextStyle(fontSize: 12, color: Colors.white70),
          ),
          const SizedBox(height: 4),
          Text(
            valor,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
