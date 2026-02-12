import 'package:flutter/material.dart';
import 'paso_1_vibracion.dart';
import 'paso_2_llamada.dart';
import 'paso_3_tareas_orden.dart';
import 'paso_4_compartir.dart';
import 'paso_5_errores.dart';
import 'paso_6_paralelo.dart';
import 'paso_7_bateria.dart';
import 'paso_8_stream_bateria.dart';
import 'paso_9_dos_streams.dart';
import 'paso_10_panel.dart';

/// PANTALLA PRINCIPAL DEL EJERCICIO
/// Integra todos los pasos (1-10) en un navegador con scroll
class EjercicioAsincroniaMain extends StatefulWidget {
  const EjercicioAsincroniaMain({super.key});

  @override
  State<EjercicioAsincroniaMain> createState() =>
      _EjercicioAsincroniaMainState();
}

class _EjercicioAsincroniaMainState extends State<EjercicioAsincroniaMain> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    Paso1Vibracion(),
    Paso2Llamada(),
    Paso3TareasEnOrden(),
    Paso4Compartir(),
    Paso5ManejoErrores(),
    Paso6AbrirEnParalelo(),
    Paso7Bateria(),
    Paso8StreamBateria(),
    Paso9DosStreamsCombinados(),
    Paso10PanelControl(),
  ];

  static const List<String> _titles = <String>[
    'Paso 1: Vibración',
    'Paso 2: Llamadas',
    'Paso 3: Tareas en Orden',
    'Paso 4: Compartir',
    'Paso 5: Manejo de Errores',
    'Paso 6: Operaciones en Paralelo',
    'Paso 7: Batería',
    'Paso 8: Stream de Batería',
    'Paso 9: Dos Streams',
    'Paso 10: Panel Control',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            const Text('Ejercicio Asincronía - Control del Teléfono'),
            Text(
              'Paso ${_selectedIndex + 1} de 10',
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
        centerTitle: true,
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(children: [_pages[_selectedIndex]]),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.vibration), label: 'P1'),
          BottomNavigationBarItem(icon: Icon(Icons.phone), label: 'P2'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'P3'),
          BottomNavigationBarItem(icon: Icon(Icons.share), label: 'P4'),
          BottomNavigationBarItem(icon: Icon(Icons.error_outline), label: 'P5'),
          BottomNavigationBarItem(icon: Icon(Icons.apps), label: 'P6'),
          BottomNavigationBarItem(icon: Icon(Icons.battery_full), label: 'P7'),
          BottomNavigationBarItem(icon: Icon(Icons.timeline), label: 'P8'),
          BottomNavigationBarItem(
            icon: Icon(Icons.waterfall_chart),
            label: 'P9',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'P10'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _mostrarInformacion();
        },
        tooltip: 'Información del ejercicio',
        child: const Icon(Icons.info),
      ),
    );
  }

  void _mostrarInformacion() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            '❓ Paso ${_selectedIndex + 1}: ${_titles[_selectedIndex]}',
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [_buildInfoPaso()],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Entendido'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildInfoPaso() {
    final pasos = [
      "Vibración:\nDemuestra un Future simple.\nEl teléfono vibra 500ms.",
      "Llamadas:\nAbre la app de teléfono.\nEjemplo de Intent a otra aplicación.",
      "Tareas en Orden:\nEjecuta 3 tareas secuenciales.\nUna tras otra, en orden.",
      "Compartir:\nAbre el dialogo de compartir.\nDetecta si el usuario compartió.",
      "Manejo de Errores:\nIntenta instalar una app.\nManeja errores con try/catch.",
      "Operaciones en Paralelo:\nAbre 4 apps a la vez.\nUsando Future.wait().",
      "Batería:\nLee la batería REAL del dispositivo.\nMuestra barra con color dinámico.",
      "Stream de Batería:\nActualiza cada 1 segundo.\nMuestra historial de cambios.",
      "Dos Streams:\nBatería + Velocidad de internet.\nAmbos actualizan en tiempo real.",
      "Panel de Control:\nProyecto capstone.\nIntegra todo lo aprendido.",
    ];

    return Text(pasos[_selectedIndex]);
  }
}
