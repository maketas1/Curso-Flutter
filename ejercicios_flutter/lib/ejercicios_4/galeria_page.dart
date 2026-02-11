import 'package:ejercicios_flutter/ejercicios_4/image_item.dart';
import 'package:flutter/material.dart';

class GaleriaPage extends StatefulWidget {
  const GaleriaPage({super.key});

  @override
  State<GaleriaPage> createState() => _GaleriaPageState();
}

class _GaleriaPageState extends State<GaleriaPage> {

  List<ImagenItem> items = [
    ImagenItem(1, "Pikachu", "Imagen de un pikachu gordo", "assets/images/pikachu.jpg"),
    ImagenItem(2, "Pikachu", "Imagen de un pikachu gordo", "assets/images/pikachu.jpg"),
    ImagenItem(3, "Pikachu", "Imagen de un pikachu gordo", "assets/images/pikachu.jpg"),
    ImagenItem(4, "Pikachu", "Imagen de un pikachu gordo", "assets/images/pikachu.jpg"),
    ImagenItem(5, "Pikachu", "Imagen de un pikachu gordo", "assets/images/pikachu.jpg"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('📸 Mi Galería de Imágenes'),
        backgroundColor: Colors.lightBlue,
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                items[index].rutaImagen,
                height: 400,
                width: 408,
              ),
              Text(items[index].titulo),
              Text(items[index].descripcion)
            ],
          );
        }
      ),
    );
  }
}