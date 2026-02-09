import 'package:flutter/material.dart';

/// SnackBar en Flutter
/// 
/// Los SnackBars son notificaciones breves que aparecen en la parte inferior
/// de la pantalla y se desaparecen automáticamente después de unos segundos.
/// Son perfectos para mostrar mensajes temporales, confirmaciones o errores.
/// 
/// CARACTERÍSTICAS PRINCIPALES:
/// - Aparecen en la parte inferior de la pantalla
/// - Se desaparecen automáticamente (duration)
/// - Pueden incluir acciones por el usuario
/// - Ideales para feedback rápido
/// 
/// REQUISITOS:
/// - Se deben mostrar dentro de un Scaffold
/// - Se acceden a través de ScaffoldMessenger
/// - Pueden ser superiores si se usa floating o dismissDirection

class MySnackBarExample extends StatefulWidget {
  const MySnackBarExample({super.key});

  @override
  State<MySnackBarExample> createState() => _MySnackBarExampleState();
}

class _MySnackBarExampleState extends State<MySnackBarExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SnackBar Examples'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Ejemplo 1: SnackBar básico
            _buildSectionTitle('1. SnackBar Básico'),
            ElevatedButton(
              onPressed: () => _showBasicSnackBar(context),
              child: const Text('Mostrar SnackBar Básico'),
            ),
            const SizedBox(height: 20),

            // Ejemplo 2: SnackBar con acción
            _buildSectionTitle('2. SnackBar con Acción'),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              onPressed: () => _showSnackBarWithAction(context),
              child: const Text('SnackBar con Botón de Acción'),
            ),
            const SizedBox(height: 20),

            // Ejemplo 3: SnackBar personalizado
            _buildSectionTitle('3. SnackBar Personalizado'),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
              ),
              onPressed: () => _showCustomSnackBar(context),
              child: const Text('SnackBar Personalizado'),
            ),
            const SizedBox(height: 20),

            // Ejemplo 4: SnackBar con duración personalizada
            _buildSectionTitle('4. SnackBar con Duración Personalizada'),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
              ),
              onPressed: () => _showSnackBarWithDuration(context),
              child: const Text('SnackBar 5 Segundos'),
            ),
            const SizedBox(height: 20),

            // Ejemplo 5: SnackBar con comportamiento flotante
            _buildSectionTitle('5. SnackBar Flotante'),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () => _showFloatingSnackBar(context),
              child: const Text('SnackBar Flotante'),
            ),
            const SizedBox(height: 20),

            // Ejemplo 6: SnackBar con múltiples acciones
            _buildSectionTitle('6. SnackBar con Confirmación'),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
              ),
              onPressed: () => _showConfirmationSnackBar(context),
              child: const Text('SnackBar de Confirmación'),
            ),
            const SizedBox(height: 30),

            // Información adicional
            _buildInfoSection(),
          ],
        ),
      ),
    );
  }

  // Ejemplo 1: SnackBar básico
  void _showBasicSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Este es un SnackBar básico'),
        duration: Duration(seconds: 3),
      ),
    );
  }

  // Ejemplo 2: SnackBar con acción
  void _showSnackBarWithAction(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('¿Te gustaría deshacer la acción?'),
        duration: const Duration(seconds: 4),
        action: SnackBarAction(
          label: 'DESHACER',
          onPressed: () {
            // Aquí se ejecuta la acción cuando presiona el botón
            print('Acción deshecha');
          },
        ),
      ),
    );
  }

  // Ejemplo 3: SnackBar personalizado con estilos
  void _showCustomSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 10),
            const Expanded(
              child: Text(
                'Operación completada exitosamente',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.green[700],
        duration: const Duration(seconds: 3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.all(12),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // Ejemplo 4: SnackBar con duración personalizada
  void _showSnackBarWithDuration(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Este SnackBar durará 5 segundos'),
        duration: Duration(seconds: 5), // Duración personalizada
      ),
    );
  }

  // Ejemplo 5: SnackBar flotante
  void _showFloatingSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('SnackBar flotante - aparece sobre otros widgets'),
        backgroundColor: Colors.red[700],
        behavior: SnackBarBehavior.floating, // Hace que flote
        margin: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  // Ejemplo 6: SnackBar con confirmación
  void _showConfirmationSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('¿Deseas ejecutar esta acción?'),
        duration: const Duration(seconds: 5),
        backgroundColor: Colors.indigo[700],
        action: SnackBarAction(
          label: 'ACEPTAR',
          textColor: Colors.yellow,
          onPressed: () {
            // Mostrar un diálogo o ejecutar la acción
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Confirmado'),
                content: const Text('La acción fue aceptada'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.blue,
        ),
      ),
    );
  }

  Widget _buildInfoSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'PROPIEDADES PRINCIPALES:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(height: 10),
          _buildInfoItem('content', 'Widget que muestra el mensaje'),
          _buildInfoItem('duration', 'Tiempo que aparece (default: 4 segundos)'),
          _buildInfoItem('action', 'Botón de acción opcional (SnackBarAction)'),
          _buildInfoItem('backgroundColor', 'Color de fondo del SnackBar'),
          _buildInfoItem('behavior', 'fixed (abajo) o floating (flotante)'),
          _buildInfoItem('shape', 'Forma de los bordes (ej: RoundedRectangleBorder)'),
          _buildInfoItem('margin', 'Espacio alrededor (solo con floating)'),
          _buildInfoItem('padding', 'Espacio interno del contenido'),
          const SizedBox(height: 15),
          const Text(
            'NOTAS IMPORTANTES:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(height: 8),
          const Text(
            '• Se debe mostrar dentro de un Scaffold\n'
            '• Use ScaffoldMessenger.of(context).showSnackBar()\n'
            '• El SnackBar anterior se cierra automáticamente\n'
            '• Los SnackBars aparecen encima del FAB (Floating Action Button)',
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String property, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '• ',
            style: TextStyle(
              color: Colors.blue[700],
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '$property: ',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: description,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// CLASE AUXILIAR PARA MOSTRAR EL EJEMPLO
/// Esta clase sirve como punto de entrada para mostrar todos los ejemplos de SnackBar
class MySnackBar extends StatelessWidget {
  const MySnackBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MySnackBarExample();
  }
}
