import 'package:flutter/material.dart';

/// EJERCICIO: STATEFULWIDGET - NIVEL MEDIO
/// 
/// Este archivo contiene ejercicios prácticos de nivel medio sobre StatefulWidget.
/// Los ejercicios van aumentando en complejidad. Completa el código donde ves TODO()

// ============================================================================
// EJERCICIO 1: CARRITO DE VIAJES
// ============================================================================
/// 
/// 📝 OBJETIVO:
/// Crear un carrito de viajes donde el usuario pueda:
/// - Ver una lista de 10 destinos
/// - Aumentar/disminuir cantidad de reservas (personas)
/// - Ver el total del costo de viajes
/// - Remover destinos del carrito
///
/// 🎯 CONCEPTOS:
/// - setState() para actualizar cantidad
/// - Lista dinámica de objetos
/// - Cálculos en tiempo real
/// - Gestión de reservas
///

class Producto {
  final int id;
  final String nombre;
  final double precio;
  int numeroDePersonas;

  Producto({
    required this.id,
    required this.nombre,
    required this.precio,
    required this.numeroDePersonas,
  });
}

class EjercicioCarrito extends StatefulWidget {
  const EjercicioCarrito({Key? key}) : super(key: key);

  @override
  State<EjercicioCarrito> createState() => _EjercicioCarritoState();
}

class _EjercicioCarritoState extends State<EjercicioCarrito> {
  // 📌 DATOS INICIALES - Destinos de viajes disponibles
  List<Producto> carrito = [
    Producto(id: 1, nombre: 'París, Francia', precio: 1299.99, numeroDePersonas: 1),
    Producto(id: 2, nombre: 'Tokio, Japón', precio: 1599.99, numeroDePersonas: 0),
    Producto(id: 3, nombre: 'Bali, Indonesia', precio: 899.99, numeroDePersonas: 0),
    Producto(id: 4, nombre: 'Nueva York, USA', precio: 1099.99, numeroDePersonas: 0),
    Producto(id: 5, nombre: 'Barcelona, España', precio: 799.99, numeroDePersonas: 0),
    Producto(id: 6, nombre: 'Marrakech, Marruecos', precio: 649.99, numeroDePersonas: 0),
    Producto(id: 7, nombre: 'Singapur', precio: 1399.99, numeroDePersonas: 0),
    Producto(id: 8, nombre: 'Estambul, Turquía', precio: 799.99, numeroDePersonas: 0),
    Producto(id: 9, nombre: 'Roma, Italia', precio: 949.99, numeroDePersonas: 0),
    Producto(id: 10, nombre: 'Tailandia (Bangkok)', precio: 1199.99, numeroDePersonas: 0),
  ];

  // TODO 1: Crea una función que calcule el total del carrito
  // La fórmula es: suma(precio * numeroDePersonas) para cada producto
  double _calcularTotal() {
    double total = 0;
    for (var producto in carrito) {
      total += producto.precio * producto.numeroDePersonas;
    }
    return total;
  }

  // TODO 2: Crea una función para incrementar el número de personas
  // Parámetros: id del producto
  // Debe usar setState() para actualizar la UI
  void _incrementarPersonas(int id) {
    setState(() {
      for (var producto in carrito) {
        if (producto.id == id) {
          producto.numeroDePersonas++;
          break;
        }
      }
    });
  }

  // TODO 3: Crea una función para decrementar el número de personas
  // NO debe ser menor a 1
  // Si llega a 1 y intenta decrementar, muestra un Snackbar
  void _decrementarPersonas(int id) {
    setState(() {
      for (var producto in carrito) {
        if (producto.id == id) {
          if (producto.numeroDePersonas > 1) {
            producto.numeroDePersonas--;
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('⚠️ Mínimo 1 persona')),
            );
          }
          break;
        }
      }
    });
  }

  // TODO 4: Crea una función para remover un producto del carrito
  // Parámetros: id del producto
  // Muestra un Snackbar confirmando la eliminación
  void _removerProducto(int id) {
    setState(() {
      carrito.removeWhere((producto) => producto.id == id);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('🗑️ Producto removido del carrito')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🛒 Carrito de Compras'),
        elevation: 0,
      ),
      body: carrito.isEmpty
          ? const Center(
              child: Text(
                'El carrito está vacío',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : Column(
              children: [
                // Lista de productos
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: carrito.length,
                    itemBuilder: (context, index) {
                      final producto = carrito[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    producto.nombre,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete,
                                        color: Colors.red),
                                    onPressed: () =>
                                        _removerProducto(producto.id),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Precio: \$${producto.precio.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.remove_circle),
                                        onPressed: () => _decrementarPersonas(
                                            producto.id),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 8,
                                        ),
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        child: Text(
                                          '${producto.numeroDePersonas}',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.add_circle),
                                        onPressed: () =>
                                            _incrementarPersonas(producto.id),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'Subtotal: \$${(producto.precio * producto.numeroDePersonas).toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // Total y botón de compra
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border(top: BorderSide(color: Colors.grey[300]!)),
                    color: Colors.grey[50],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'TOTAL:',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '\$${_calcularTotal().toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                '✅ Compra completada! Total: \$${_calcularTotal().toStringAsFixed(2)}',
                              ),
                            ),
                          );
                        },
                        child: const Text('Proceder a Pagar'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

// ============================================================================
// EJERCICIO 2: TODO LIST MEJORADO
// ============================================================================
/// 
/// 📝 OBJETIVO:
/// Crear una aplicación de tareas con:
/// - Agregar tareas
/// - Marcar como completadas (checkbox)
/// - Eliminar tareas
/// - Filtrar por estado (todas, completadas, pendientes)
/// - Contador de tareas
///
/// 🎯 CONCEPTOS:
/// - Manejo de estado complejo
/// - Filtrado de listas
/// - ToggleButtons para filtros
///

class Tarea {
  final int id;
  String titulo;
  bool completada;

  Tarea({
    required this.id,
    required this.titulo,
    required this.completada,
  });
}

class EjercicioTodoList extends StatefulWidget {
  const EjercicioTodoList({Key? key}) : super(key: key);

  @override
  State<EjercicioTodoList> createState() => _EjercicioTodoListState();
}

class _EjercicioTodoListState extends State<EjercicioTodoList> {
  late TextEditingController _controlador;
  List<Tarea> tareas = [];
  int _proximoId = 1;
  
  // Filtro: 0 = todas, 1 = completadas, 2 = pendientes
  int _filtroActual = 0;

  @override
  void initState() {
    super.initState();
    _controlador = TextEditingController();
    // Datos iniciales
    tareas = [
      Tarea(id: _proximoId++, titulo: 'Estudiar Flutter', completada: false),
      Tarea(id: _proximoId++, titulo: 'Hacer ejercicios', completada: false),
      Tarea(id: _proximoId++, titulo: 'Revisar código', completada: true),
    ];
  }

  // TODO 5: Crea una función para agregar tarea
  // - Usa _controlador.text para obtener el texto
  // - Crea un nuevo objeto Tarea con id único
  // - Limpia el TextEditingController después
  // - Usa setState() para actualizar
  void _agregarTarea() {
    if (_controlador.text.isNotEmpty) {
      setState(() {
        tareas.add(
          Tarea(
            id: _proximoId++,
            titulo: _controlador.text,
            completada: false,
          ),
        );
      });
      _controlador.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('✅ Tarea añadida')),
      );
    }
  }

  // TODO 6: Crea una función para toglear el estado completado
  // Parámetros: id de la tarea
  void _toggleTarea(int id) {
    setState(() {
      for (var tarea in tareas) {
        if (tarea.id == id) {
          tarea.completada = !tarea.completada;
          break;
        }
      }
    });
  }

  // TODO 7: Crea una función para eliminar tarea
  // Parámetros: id de la tarea
  void _eliminarTarea(int id) {
    setState(() {
      tareas.removeWhere((tarea) => tarea.id == id);
    });
  }

  // TODO 8: Crea una función que retorne la lista filtrada
  // Según _filtroActual:
  // - 0: retorna todas
  // - 1: retorna solo completadas
  // - 2: retorna solo pendientes
  List<Tarea> _obtenerTareasFiltradas() {
    switch (_filtroActual) {
      case 1:
        return tareas.where((tarea) => tarea.completada).toList();
      case 2:
        return tareas.where((tarea) => !tarea.completada).toList();
      default:
        return tareas;
    }
  }

  int _contarCompletadas() {
    return tareas.where((tarea) => tarea.completada).length;
  }

  @override
  Widget build(BuildContext context) {
    final tareasFiltradas = _obtenerTareasFiltradas();

    return Scaffold(
      appBar: AppBar(
        title: const Text('✓ Mi Lista de Tareas'),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Estadísticas
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.blue[50],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _CardEstadistica(
                  titulo: 'Total',
                  cantidad: tareas.length,
                  color: Colors.blue,
                ),
                _CardEstadistica(
                  titulo: 'Completadas',
                  cantidad: _contarCompletadas(),
                  color: Colors.green,
                ),
                _CardEstadistica(
                  titulo: 'Pendientes',
                  cantidad: tareas.length - _contarCompletadas(),
                  color: Colors.orange,
                ),
              ],
            ),
          ),

          // Filtros
          Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _BotonFiltro(
                    label: 'Todas',
                    isSelected: _filtroActual == 0,
                    onPressed: () {
                      setState(() {
                        _filtroActual = 0;
                      });
                    },
                  ),
                  const SizedBox(width: 8),
                  _BotonFiltro(
                    label: 'Completadas',
                    isSelected: _filtroActual == 1,
                    onPressed: () {
                      setState(() {
                        _filtroActual = 1;
                      });
                    },
                  ),
                  const SizedBox(width: 8),
                  _BotonFiltro(
                    label: 'Pendientes',
                    isSelected: _filtroActual == 2,
                    onPressed: () {
                      setState(() {
                        _filtroActual = 2;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),

          // Lista de tareas filtradas
          Expanded(
            child: tareasFiltradas.isEmpty
                ? Center(
                    child: Text(
                      _filtroActual == 0
                          ? 'No hay tareas'
                          : _filtroActual == 1
                              ? 'No hay tareas completadas'
                              : 'No hay tareas pendientes',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: tareasFiltradas.length,
                    itemBuilder: (context, index) {
                      final tarea = tareasFiltradas[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          leading: Checkbox(
                            value: tarea.completada,
                            onChanged: (_) => _toggleTarea(tarea.id),
                          ),
                          title: Text(
                            tarea.titulo,
                            style: TextStyle(
                              decoration: tarea.completada
                                  ? TextDecoration.lineThrough
                                  : null,
                              color: tarea.completada ? Colors.grey : null,
                            ),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _eliminarTarea(tarea.id),
                          ),
                        ),
                      );
                    },
                  ),
          ),

          // Campo para agregar tarea
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey[300]!)),
              color: Colors.grey[50],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controlador,
                    decoration: InputDecoration(
                      hintText: 'Nueva tarea...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                FloatingActionButton(
                  onPressed: _agregarTarea,
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controlador.dispose();
    super.dispose();
  }
}

// Widgets auxiliares
class _CardEstadistica extends StatelessWidget {
  final String titulo;
  final int cantidad;
  final Color color;

  const _CardEstadistica({
    required this.titulo,
    required this.cantidad,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '$cantidad',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          titulo,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}

class _BotonFiltro extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onPressed;

  const _BotonFiltro({
    required this.label,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.blue : Colors.grey[300],
        foregroundColor: isSelected ? Colors.white : Colors.black,
      ),
      child: Text(label),
    );
  }
}

// ============================================================================
// PANTALLA PRINCIPAL - MENÚ DE EJERCICIOS
// ============================================================================
class MiEjercicioStateful extends StatelessWidget {
  const MiEjercicioStateful({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ejercicios StatefulWidget - Nivel Medio'),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Card(
            color: Colors.blue,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                '📚 EJERCICIOS PRÁCTICOS\n\n'
                'Completa los TODO() en cada ejercicio para aprender sobre StatefulWidget.\n\n'
                '🎯 Nivel: Medio\n'
                '⏱️ Tiempo estimado: 30-45 minutos cada uno',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
          const SizedBox(height: 24),
          _EjercicioCard(
            numero: '1',
            titulo: 'Carrito de Compras',
            descripcion: 'Gestiona cantidad de productos, calcula totales, elimina items',
            dificultad: '⭐⭐',
            temas: ['setState()', 'Listas dinámicas', 'Cálculos en tiempo real'],
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const EjercicioCarrito()),
            ),
          ),
          const SizedBox(height: 16),
          _EjercicioCard(
            numero: '2',
            titulo: 'TODO List Mejorado',
            descripcion: 'Crea, completa, elimina y filtra tareas por estado',
            dificultad: '⭐⭐⭐',
            temas: ['Filtrado de listas', 'Estado complejo', 'Toggles'],
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const EjercicioTodoList()),
            ),
          ),
        ],
      ),
    );
  }
}

class _EjercicioCard extends StatelessWidget {
  final String numero;
  final String titulo;
  final String descripcion;
  final String dificultad;
  final List<String> temas;
  final VoidCallback onPressed;

  const _EjercicioCard({
    required this.numero,
    required this.titulo,
    required this.descripcion,
    required this.dificultad,
    required this.temas,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Ejercicio $numero',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  dificultad,
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              titulo,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              descripcion,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: temas
                  .map(
                    (tema) => Chip(
                      label: Text(tema),
                      backgroundColor: Colors.blue[50],
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onPressed,
                child: const Text('Resolver Ejercicio →'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
