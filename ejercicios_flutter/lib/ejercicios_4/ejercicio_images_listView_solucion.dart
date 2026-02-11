import 'package:flutter/material.dart';


// ============================================================================
// MODELO DE DATOS
// ============================================================================

class ImagenItem {
  final int id;
  final String titulo;
  String descripcion;
  final String rutaImagen;
  bool megusta;

  ImagenItem({
    required this.id,
    required this.titulo,
    required this.descripcion,
    required this.rutaImagen,
    this.megusta = false,
  });
}

// ============================================================================
// PÁGINA PRINCIPAL - GALERÍA
// ============================================================================

class GaleriaPage extends StatefulWidget {
  const GaleriaPage({super.key});

  @override
  State<GaleriaPage> createState() => _GaleriaPageState();
}

class _GaleriaPageState extends State<GaleriaPage>
    with TickerProviderStateMixin {
  // Variables de estado
  late List<ImagenItem> imagenes;
  bool mostrarSoloFavoritos = false;
  late AnimationController _animationController;
  int? _indexAnimado;

  @override
  void initState() {
    super.initState();
    _inicializarImagenes();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // Inicializa la lista de imágenes (PASO 2)
  void _inicializarImagenes() {
    imagenes = [
      ImagenItem(
        id: 1,
        titulo: 'Pikachu',
        descripcion: 'Imagen de un pikachu gordo',
        rutaImagen: 'assets/images/pikachu.jpg',
      ),
      ImagenItem(
        id: 2,
        titulo: 'Pikachu',
        descripcion: 'Imagen de un pikachu gordo',
        rutaImagen: 'assets/images/pikachu.jpg',
      ),
      ImagenItem(
        id: 3,
        titulo: 'Pikachu',
        descripcion: 'Imagen de un pikachu gordo',
        rutaImagen: 'assets/images/pikachu.jpg',
      ),
      ImagenItem(
        id: 4,
        titulo: 'Pikachu',
        descripcion: 'Imagen de un pikachu gordo',
        rutaImagen: 'assets/images/pikachu.jpg',
      ),
      ImagenItem(
        id: 5,
        titulo: 'Pikachu',
        descripcion: 'Imagen de un pikachu gordo',
        rutaImagen: 'assets/images/pikachu.jpg',
      ),
    ];
  }

  // Calcula total de "Me gusta"
  int get totalMegusta => imagenes.where((img) => img.megusta).length;

  // Obtiene lista filtrada (PASO 8)
  List<ImagenItem> get imagenesFiltradasActuales {
    if (mostrarSoloFavoritos) {
      return imagenes.where((img) => img.megusta).toList();
    }
    return imagenes;
  }

  // Alterna estado de "Me gusta" (PASO 4)
  void _toggleMegusta(int index) {
    setState(() {
      imagenes[index].megusta = !imagenes[index].megusta;
      _indexAnimado = index;
      _animationController.forward().then((_) {
        _animationController.reset();
      });
    });

    // Muestra SnackBar (PASO 5)
    final imagen = imagenes[index];
    final mensaje = imagen.megusta
        ? '❤️ ${imagen.titulo} te encanta'
        : '🤍 ${imagen.titulo} removido de favoritos';

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensaje),
        backgroundColor: imagen.megusta ? Colors.red[400] : Colors.grey[400],
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // Acción del botón "Ver Detalles" (PASO 6)
  void _verDetalles(ImagenItem imagen) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('ℹ️ Mostrando detalles de ${imagen.titulo}'),
        backgroundColor: Colors.blue[400],
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // Abre diálogo para editar descripción (PASO 10)
  void _editarDescripcion(int index) {
    final TextEditingController controller =
        TextEditingController(text: imagenes[index].descripcion);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Editar descripción de ${imagenes[index].titulo}'),
          content: TextField(
            controller: controller,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: 'Ingresa la nueva descripción',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  imagenes[index].descripcion = controller.text;
                });
                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('✏️ Descripción actualizada'),
                    backgroundColor: Colors.green,
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  // Alterna filtro de favoritos (PASO 8)
  void _toggleFiltro() {
    setState(() {
      mostrarSoloFavoritos = !mostrarSoloFavoritos;
    });

    final mensaje = mostrarSoloFavoritos
        ? '🔍 Mostrando solo favoritos'
        : '📋 Mostrando todas las imágenes';

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensaje),
        backgroundColor: Colors.blue,
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ========== APPBAR (PASO 1, 7, 8) ==========
      appBar: AppBar(
        title: const Text('📸 Mi Galería de Imágenes'),
        backgroundColor: Colors.blue[300],
        elevation: 0,
        actions: [
          // Contador de "Me gusta" (PASO 7)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.red[400],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const Text(
                      '❤️',
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '$totalMegusta',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Botón de filtro (PASO 8)
          IconButton(
            icon: Icon(
              Icons.filter_list,
              color: mostrarSoloFavoritos ? Colors.red : Colors.white,
            ),
            onPressed: _toggleFiltro,
            tooltip: 'Filtrar favoritos',
          ),
        ],
      ),

      // ========== BODY - LISTVIEW (PASO 3) ==========
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (imagenesFiltradasActuales.isEmpty)
              Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    const Text(
                      '😢 No hay imágenes favoritas',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Marca algunas imágenes como favoritas para verlas aquí',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 50),
                    ElevatedButton(
                      onPressed: _toggleFiltro,
                      child: const Text('Ver todas las imágenes'),
                    ),
                  ],
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: imagenesFiltradasActuales.length,
                itemBuilder: (context, index) {
                  final imagen = imagenesFiltradasActuales[index];
                  final imagenIndex = imagenes.indexOf(imagen);

                  return _construirTarjetaImagen(imagen, imagenIndex);
                },
              ),
          ],
        ),
      ),
    );
  }

  // Construye cada tarjeta de imagen (PASOS 3, 4, 5, 6, 9, 10)
  Widget _construirTarjetaImagen(ImagenItem imagen, int index) {
    // PASO 9: Animación
    bool estaAnimado = _indexAnimado == index;
    double escala = estaAnimado
        ? 1.0 + (0.2 * (1 - _animationController.value))
        : 1.0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen (PASO 3)
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12)),
                color: Colors.grey[300],
              ),
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.asset(
                  imagen.rutaImagen,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.image_not_supported, size: 50, color: Colors.grey[400]),
                          const SizedBox(height: 8),
                          Text('Imagen no disponible', style: TextStyle(color: Colors.grey[600])),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),

            // Contenido (título y descripción)
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    imagen.titulo,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    imagen.descripcion,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            // Botones (PASO 4, 5, 6, 10)
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Botón "Ver Detalles" (PASO 6)
                  ElevatedButton.icon(
                    onPressed: () => _verDetalles(imagen),
                    icon: const Icon(Icons.info, size: 18),
                    label: const Text('Detalles'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[400],
                      foregroundColor: Colors.white,
                    ),
                  ),

                  // Botón "Me gusta" (PASO 4, 5, 9)
                  Scale(
                    scale: escala,
                    child: IconButton(
                      icon: Icon(
                        imagen.megusta ? Icons.favorite : Icons.favorite_border,
                        color: imagen.megusta ? Colors.red : Colors.grey,
                        size: 28,
                      ),
                      onPressed: () => _toggleMegusta(index),
                      tooltip: 'Me gusta',
                    ),
                  ),

                  // Botón "Editar" (PASO 10)
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.orange),
                    onPressed: () => _editarDescripcion(index),
                    tooltip: 'Editar descripción',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget personalizado para animación de escala (PASO 9)
class Scale extends StatelessWidget {
  final double scale;
  final Widget child;

  const Scale({
    Key? key,
    required this.scale,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: scale,
      child: child,
    );
  }
}
