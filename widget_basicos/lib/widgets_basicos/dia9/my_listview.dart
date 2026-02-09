import 'package:flutter/material.dart';

/// LISTVIEW EN FLUTTER - GUÍA COMPLETA
/// 
/// Un ListView es un widget que permite mostrar una lista de elementos desplazables.
/// Es ideal cuando tienes elementos que no caben en pantalla y necesitas scroll.

// ============================================================================
// 📋 PROPIEDADES PRINCIPALES DE LISTVIEW
// ============================================================================
/// 
/// 🎯 PROPIEDADES DE DESPLAZAMIENTO:
///   • scrollDirection: Axis → Define dirección del scroll
///     - Axis.vertical (default): Scroll vertical
///     - Axis.horizontal: Scroll horizontal
///   
///   • reverse: bool → Invierte el orden de los elementos (default: false)
///   
///   • physics: ScrollPhysics → Comportamiento del scroll
///     - BouncingScrollPhysics(): Efecto iOS (rebote)
///     - ClampingScrollPhysics(): Efecto Android (resistencia)
///     - NeverScrollableScrollPhysics(): Desactiva completamente el scroll
///     - AlwaysScrollableScrollPhysics(): Siempre scrolleable
///   
///   • controller: ScrollController → Control programático del scroll
///     - Permite scrollear a posiciones específicas
///     - Escuchar cambios de posición
///
/// 🎯 PROPIEDADES DE ESPACIADO:
///   • padding: EdgeInsets → Espacio alrededor de todo el ListView
///   
///   • itemExtent: double → Altura/ancho fijo de cada elemento
///     - Mejora significativamente el rendimiento
///     - Solo usa si TODOS los elementos tienen igual tamaño
///   
///   • shrinkWrap: bool → Si ListView ocupa solo el espacio de sus hijos
///     - Usa true cuando ListView está dentro de otro widget scrollable
///     - Usa false (default) cuando ListView ocupa todo el espacio disponible
///
/// 🎯 PROPIEDADES DE CONTENIDO:
///   • children: List<Widget> → Lista de widgets a mostrar (ListView simple)
///   
///   • itemCount: int → Número de elementos (ListView.builder)
///   
///   • itemBuilder: Function → Función que construye cada elemento
///     - Parámetros: (BuildContext context, int index)
///     - Se ejecuta para cada índice hasta itemCount
///   
///   • separatorBuilder: Function → Construye divisores entre elementos (ListView.separated)
///
/// 🎯 PROPIEDADES DE COMPORTAMIENTO:
///   • addAutomaticKeepAlives: bool → Mantiene en memoria widgets fuera de pantalla
///     - true: Previene que se destruyan (usa más RAM)
///     - false: Los destruye cuando salen de vista (usa menos RAM)
///   
///   • addRepaintBoundaries: bool → Agrupa elementos en límites de repaint
///     - true (default): Mejor rendimiento
///     - false: Menos memoria pero puede causar parpadeos
///   
///   • addSemanticIndexes: bool → Agrega índices semánticos (accesibilidad)
///   
///   • cacheExtent: double → Espacio adicional que pre-renderiza fuera de pantalla
///     - Valor mayor = más pre-renderizado = más suavidad pero más RAM
///   
///   • clipBehavior: Clip → Cómo recortar el contenido
///     - Clip.none: Sin recorte (default)
///     - Clip.antiAlias: Recorte con suavizado

// ============================================================================
// 📋 PROPIEDADES PRINCIPALES DE LISTTILE
// ============================================================================
/// 
/// ListTile es un widget que proporciona una estructura estándar para items en listas.
/// Combina leading, title, subtitle, trailing en una fila.
///
/// 🎯 PROPIEDADES PRINCIPALES:
///   • leading: Widget → Widget que aparece al inicio (ej: Icon, Avatar)
///   
///   • title: Widget → Texto/widget principal (normalmente Text)
///   
///   • subtitle: Widget → Texto/widget secundario debajo del title
///   
///   • trailing: Widget → Widget que aparece al final (ej: Icon, Switch)
///   
///   • onTap: VoidCallback → Se ejecuta cuando toca el ListTile
///   
///   • onLongPress: VoidCallback → Se ejecuta cuando presiona largo
///
/// 🎯 PROPIEDADES DE ESPACIADO Y TAMAÑO:
///   • contentPadding: EdgeInsets → Espaciado interno del ListTile
///     - Default: EdgeInsets.symmetric(horizontal: 16)
///   
///   • dense: bool → Reduce altura del ListTile
///     - true: Más compacto (minHeight: 48)
///     - false (default): Normal (minHeight: 56)
///   
///   • minVerticalPadding: double → Espacio mínimo vertical
///   
///   • minLeadingWidth: double → Ancho mínimo del leading
///
/// 🎯 PROPIEDADES VISUALES:
///   • enabled: bool → Si el ListTile es interactivo
///     - true: Responde a taps
///     - false: Deshabilitado, no responde
///   
///   • selected: bool → Si el ListTile está seleccionado
///     - true: Cambia el color de fondo
///   
///   • selectedTileColor: Color → Color cuando está seleccionado
///   
///   • textColor: Color → Color del texto
///   
///   • selectedColor: Color → Color de textos cuando está seleccionado
///   
///   • iconColor: Color → Color de los iconos
///   
///   • focusColor: Color → Color cuando tiene el foco
///   
///   • hoverColor: Color → Color cuando pasas el mouse
///
/// 🎯 PROPIEDADES AVANZADAS:
///   • shape: ShapeBorder → Forma del ListTile
///     - Ej: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))
///   
///   • tileColor: Color → Color de fondo del ListTile
///   
///   • splashColor: Color → Color del efecto splash al tocar
///   
///   • isThreeLine: bool → Si el ListTile tiene 3 líneas
///     - Aumenta la altura cuando hay mucho contenido

// ============================================================================
// 📋 EJEMPLOS DE TRAILING (Widget en la derecha del ListTile)
// ============================================================================
/// 
/// 📌 TIPOS DE TRAILING COMUNES:
///
/// ✅ Icono simple:
///   trailing: Icon(Icons.arrow_forward)
///
/// ✅ Switch (interactivo):
///   trailing: Switch(
///     value: isEnabled,
///     onChanged: (value) { setState(() => isEnabled = value); }
///   )
///
/// ✅ Checkbox (selectable):
///   trailing: Checkbox(
///     value: isSelected,
///     onChanged: (value) { setState(() => isSelected = value); }
///   )
///
/// ✅ IconButton (botón interactivo):
///   trailing: IconButton(
///     icon: Icon(Icons.delete),
///     onPressed: () { /* eliminar item */ }
///   )
///
/// ✅ Badge (con contador):
///   trailing: Badge(
///     label: Text('5'),
///     child: Icon(Icons.notifications)
///   )
///
/// ✅ PopupMenuButton (menú):
///   trailing: PopupMenuButton(
///     itemBuilder: (context) => [
///       PopupMenuItem(child: Text('Editar')),
///       PopupMenuItem(child: Text('Eliminar')),
///     ]
///   )

// ============================================================================
// 📋 EJEMPLOS DE USO COMPLETOS:
// ============================================================================
/// 
/// ✅ ListTile básico:
///   ListTile(
///     leading: Icon(Icons.person),
///     title: Text('Nombre'),
///     subtitle: Text('Descripción'),
///     trailing: Icon(Icons.arrow_forward),
///     onTap: () { print('Tapped'); },
///   )
///
/// ✅ ListView con builder optimizado:
///   ListView.builder(
///     itemCount: 100,
///     itemExtent: 80,  // Altura fija = mejor rendimiento
///     itemBuilder: (context, index) => ListTile(
///       title: Text('Item $index'),
///     ),
///   )
///
/// ✅ ListView horizontal:
///   ListView(
///     scrollDirection: Axis.horizontal,
///     children: [...],
///   )
///
/// ✅ ListView con separadores:
///   ListView.separated(
///     itemCount: items.length,
///     itemBuilder: (context, index) => ListTile(...),
///     separatorBuilder: (context, index) => Divider(),
///   )

// ============================================================================
// 1. LISTVIEW SIMPLE - Constructor básico
// ============================================================================
class ListViewSimple extends StatelessWidget {
  const ListViewSimple({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ListView Simple')),
      body: ListView(
        children: [
          // ┌─────────────────────────────────────────────────────────────┐
          // │ ESTRUCTURA DE UN LISTTILE:                                 │
          // │ [leading] [title   ] [trailing]                            │
          // │          [subtitle ]                                       │
          // └─────────────────────────────────────────────────────────────┘
          
          ListTile(
            // leading: Widget que aparece ANTES del texto (izquierda)
            // Generalmente es un icono, avatar o imagen
            leading: const Icon(Icons.person),
            
            // title: Widget PRINCIPAL (normalmente Text)
            // Es el contenido más importante del ListTile
            title: const Text('Elemento 1'),
            
            // subtitle: Widget SECUNDARIO (debajo del title)
            // Generalmente una descripción o información adicional
            subtitle: const Text('Descripción 1'),
            
            // Nota: Si no especificas trailing, el ListTile no ocupa todo el ancho
          ),
          
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Elemento 2'),
            subtitle: const Text('Descripción 2'),
            // trailing: Widget que aparece DESPUÉS del texto (derecha)
            // Ejemplos: Icon, Switch, Checkbox, PopupMenuButton
          ),
          
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Elemento 3'),
            subtitle: const Text('Descripción 3'),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// 2. LISTVIEW.BUILDER - Ideal para listas largas (rendimiento optimizado)
// ============================================================================
class ListViewBuilder extends StatelessWidget {
  const ListViewBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    // Genera 100 elementos dinámicamente
    final List<String> items = List.generate(100, (index) => 'Elemento ${index + 1}');

    return Scaffold(
      appBar: AppBar(title: const Text('ListView.builder()')),
      body: ListView.builder(
        // itemCount: Número TOTAL de elementos a mostrar
        // El itemBuilder se ejecutará desde index 0 hasta index (itemCount - 1)
        itemCount: items.length,
        
        // itemBuilder: Función que construye CADA elemento
        // Se ejecuta solo para elementos visibles en pantalla (OPTIMIZADO)
        // Parámetros:
        //   - context: BuildContext de la app
        //   - index: Índice del elemento (0, 1, 2, ...)
        itemBuilder: (context, index) {
          return ListTile(
            // leading: Icono/avatar con el número del elemento
            leading: CircleAvatar(
              child: Text('${index + 1}'),
            ),
            // title: Nombre del elemento
            title: Text(items[index]),
            // subtitle: Información adicional (el índice)
            subtitle: Text('Índice: $index'),
            // trailing: Icono indicador
            trailing: const Icon(Icons.arrow_forward),
            // onTap: Acción cuando se toca el ListTile
            onTap: () {
              // Muestra un Snackbar con el elemento seleccionado
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Seleccionaste ${items[index]}')),
              );
            },
          );
        },
      ),
    );
  }
}

// ============================================================================
// 3. LISTVIEW.SEPARATED - Con divisores entre elementos
// ============================================================================
class ListViewSeparated extends StatelessWidget {
  const ListViewSeparated({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> items = List.generate(50, (index) => 'Producto ${index + 1}');

    return Scaffold(
      appBar: AppBar(title: const Text('ListView.separated()')),
      body: ListView.separated(
        // padding: Espaciado alrededor de TODA la lista
        padding: const EdgeInsets.all(8),
        
        // itemCount: Número TOTAL de elementos
        // Nota: separatorBuilder se ejecutará itemCount - 1 veces
        itemCount: items.length,
        
        // itemBuilder: Construye cada elemento de la lista
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.shopping_bag),
            title: Text(items[index]),
            // Muestra un precio dinámico basado en el índice
            subtitle: Text('Precio: \$${(index + 1) * 10}'),
            trailing: const Icon(Icons.add_shopping_cart),
          );
        },
        
        // separatorBuilder: Construye el divisor ENTRE elementos
        // Se ejecuta entre cada par de elementos (itemCount - 1 veces)
        // El index aquí representa la posición del divisor
        separatorBuilder: (context, index) => const Divider(
          height: 1,           // Alto del divisor
          thickness: 1,        // Grosor de la línea
        ),
      ),
    );
  }
}

// ============================================================================
// 4. PROPIEDADES PRINCIPALES DE LISTVIEW
// ============================================================================
class ListViewConPropiedades extends StatelessWidget {
  const ListViewConPropiedades({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> items = List.generate(20, (index) => 'Elemento ${index + 1}');

    return Scaffold(
      appBar: AppBar(title: const Text('ListView con Propiedades')),
      body: ListView.builder(
        // ┌─────────────────────────────────────────────────────────────┐
        // │ PROPIEDADES DE DESPLAZAMIENTO                              │
        // └─────────────────────────────────────────────────────────────┘
        
        // scrollDirection: Define la dirección del scroll
        // - Axis.vertical: Scroll hacia arriba/abajo (default)
        // - Axis.horizontal: Scroll hacia izquierda/derecha
        scrollDirection: Axis.vertical,
        
        // reverse: Invierte el orden de los elementos
        // - true: El último elemento aparece primero
        // - false: El primer elemento aparece primero (default)
        reverse: false,
        
        // physics: Controla el comportamiento del scroll
        // - BouncingScrollPhysics(): Efecto iOS con rebote
        // - ClampingScrollPhysics(): Efecto Android con resistencia
        // - NeverScrollableScrollPhysics(): Desactiva completamente el scroll
        // - AlwaysScrollableScrollPhysics(): Siempre scrolleable aunque quepa todo
        physics: const BouncingScrollPhysics(),

        // ┌─────────────────────────────────────────────────────────────┐
        // │ PROPIEDADES DE ESPACIADO                                   │
        // └─────────────────────────────────────────────────────────────┘
        
        // padding: Espaciado alrededor de TODO el ListView
        // Aplica margen externo a toda la lista
        padding: const EdgeInsets.all(16),
        
        // itemExtent: Fija una altura/ancho constante para cada elemento
        // ⚠️ IMPORTANTE: Solo usa esto si TODOS los elementos tienen igual tamaño
        // Beneficio: Mejora MUCHO el rendimiento (evita cálculos de tamaño)
        // itemExtent: 80,

        // ┌─────────────────────────────────────────────────────────────┐
        // │ PROPIEDADES DE COMPORTAMIENTO                              │
        // └─────────────────────────────────────────────────────────────┘
        
        // shrinkWrap: Si es true, el ListView ocupa solo el espacio de sus hijos
        // - true: Usa si ListView está DENTRO de otro widget scrollable
        // - false: Usa si ListView ocupa todo el espacio disponible (default)
        // ⚠️ Usar true con muchos items puede degradar rendimiento
        shrinkWrap: false,
        
        // addAutomaticKeepAlives: Mantiene en memoria widgets fuera de pantalla
        // - true: Previene destrucción (más RAM, mejor scroll fluido)
        // - false: Destruye widgets fuera de vista (menos RAM)
        addAutomaticKeepAlives: true,
        
        // addRepaintBoundaries: Agrupa elementos en límites de repaint
        // - true: Mejor rendimiento (default)
        // - false: Menos memoria pero scroll menos fluido
        // Normalmente dejar en true
        
        // cacheExtent: Extensión de caché en píxeles
        // Define cuánto espacio adicional pre-renderiza fuera de pantalla
        // Mayor valor = más suavidad pero más consumo de RAM
        // Valor default: generalmente 250.0
        
        // clipBehavior: Cómo recorta el contenido
        // - Clip.none: Sin recorte (default)
        // - Clip.antiAlias: Recorte suave
        // - Clip.hardEdge: Recorte duro
        clipBehavior: Clip.antiAlias,

        itemCount: items.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              title: Text(items[index]),
              subtitle: const Text('Ejemplo de propiedades'),
            ),
          );
        },
      ),
    );
  }
}

// ============================================================================
// 4.5 EJEMPLO DE TRAILING - Diferentes tipos de widgets
// ============================================================================
/// Demuestra todas las formas comunes de usar la propiedad trailing
class EjemploTrailing extends StatefulWidget {
  const EjemploTrailing({Key? key}) : super(key: key);

  @override
  State<EjemploTrailing> createState() => _EjemploTrailingState();
}

class _EjemploTrailingState extends State<EjemploTrailing> {
  // Variables de estado para los controles
  bool notificaciones = true;
  bool favorito = false;
  Set<int> seleccionados = {};

  @override
  Widget build(BuildContext context) {
    final items = [
      'Icono Simple',
      'IconButton Interactivo',
      'Switch Activable',
      'Checkbox Selectable',
      'Contador',
      'Menú Emergente',
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Ejemplos de Trailing')),
      body: ListView.builder(
        itemCount: items.length,
        padding: const EdgeInsets.all(8),
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blue[100],
                child: Text('${index + 1}'),
              ),
              title: Text(items[index]),
              subtitle: Text('Tipo de trailing #${index + 1}'),
              
              // 📌 DIFERENTES TIPOS DE TRAILING:
              trailing: _construirTrailing(index),
            ),
          );
        },
      ),
    );
  }

  // Función que retorna diferentes widgets para trailing según el índice
  Widget _construirTrailing(int index) {
    switch (index) {
      // 1️⃣ ICONO SIMPLE
      case 0:
        return const Icon(
          Icons.arrow_forward,
          color: Colors.grey,
        );

      // 2️⃣ ICONBUTTON INTERACTIVO
      case 1:
        return IconButton(
          icon: Icon(
            favorito ? Icons.favorite : Icons.favorite_border,
            color: favorito ? Colors.red : Colors.grey,
          ),
          onPressed: () {
            setState(() {
              favorito = !favorito;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(favorito ? '❤️ Añadido a favoritos' : '💔 Eliminado de favoritos'),
              ),
            );
          },
        );

      // 3️⃣ SWITCH
      case 2:
        return Switch(
          value: notificaciones,
          onChanged: (value) {
            setState(() {
              notificaciones = value;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(notificaciones 
                  ? '🔔 Notificaciones activadas' 
                  : '🔕 Notificaciones desactivadas'),
              ),
            );
          },
        );

      // 4️⃣ CHECKBOX
      case 3:
        return Checkbox(
          value: seleccionados.contains(index),
          onChanged: (value) {
            setState(() {
              if (value ?? false) {
                seleccionados.add(index);
              } else {
                seleccionados.remove(index);
              }
            });
          },
        );

      // 5️⃣ CONTADOR CON BOTONES
      case 4:
        return Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                iconSize: 18,
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('➖ Decrementar')),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text('5', style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
              IconButton(
                icon: const Icon(Icons.add),
                iconSize: 18,
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('➕ Incrementar')),
                  );
                },
              ),
            ],
          ),
        );

      // 6️⃣ POPUPMENUBUTTON (Menú emergente)
      case 5:
        return PopupMenuButton<String>(
          onSelected: (value) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Seleccionaste: $value')),
            );
          },
          itemBuilder: (context) => [
            const PopupMenuItem(value: 'Editar', child: Text('✏️ Editar')),
            const PopupMenuItem(value: 'Compartir', child: Text('📤 Compartir')),
            const PopupMenuItem(value: 'Eliminar', child: Text('🗑️ Eliminar')),
          ],
          icon: const Icon(Icons.more_vert),
        );

      default:
        return const Icon(Icons.arrow_forward);
    }
  }
}

// ============================================================================
// 5. LISTVIEW CON SCROLLCONTROLLER - Control programático
// ============================================================================
class ListViewConController extends StatefulWidget {
  const ListViewConController({Key? key}) : super(key: key);

  @override
  State<ListViewConController> createState() => _ListViewConControllerState();
}

class _ListViewConControllerState extends State<ListViewConController> {
  late ScrollController _scrollController;
  bool _mostrarBoton = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    // Escucha cambios en el scroll
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    // Muestra botón si está scrolleado más del 50%
    final isScrolled = _scrollController.offset > 500;
    if (isScrolled != _mostrarBoton) {
      setState(() => _mostrarBoton = isScrolled);
    }
  }

  void _irAlFinal() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

  void _irAlInicio() {
    _scrollController.animateTo(
      0,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ListView con ScrollController')),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: 50,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(child: Text('${index + 1}')),
            title: Text('Item $index'),
            subtitle: const Text('Control programático del scroll'),
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (_mostrarBoton)
            FloatingActionButton(
              onPressed: _irAlInicio,
              heroTag: 'top',
              child: const Icon(Icons.arrow_upward),
            ),
          const SizedBox(height: 16),
          FloatingActionButton(
            onPressed: _irAlFinal,
            heroTag: 'bottom',
            child: const Icon(Icons.arrow_downward),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

// ============================================================================
// 6. LISTVIEW HORIZONTAL
// ============================================================================
// Demuestra un ListView que desplaza elementos horizontalmente
// Útil para galerías, carruseles de imágenes, etc.
class ListViewHorizontal extends StatelessWidget {
  const ListViewHorizontal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> items = List.generate(10, (index) => 'Card ${index + 1}');

    return Scaffold(
      appBar: AppBar(title: const Text('ListView Horizontal')),
      body: Center(
        // Usamos ListView.builder() pero con scrollDirection: Axis.horizontal
        child: ListView.builder(
          // scrollDirection: Axis.horizontal
          // Cambia la dirección del scroll a horizontal (de izquierda a derecha)
          // Default es Axis.vertical (arriba a abajo)
          scrollDirection: Axis.horizontal,
          
          // padding: Espaciado alrededor de TODO el ListView
          padding: const EdgeInsets.all(16),
          
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Card(
              // margin: Espaciado solo a la DERECHA de cada Card
              // De esta forma los cards están separados horizontalmente
              margin: const EdgeInsets.only(right: 16),
              child: Container(
                // width: Ancho FIJO de cada elemento
                // Importante para ListView horizontal
                width: 150,
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.image, size: 50),
                    const SizedBox(height: 8),
                    Text(items[index], textAlign: TextAlign.center),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// ============================================================================
// 7. LISTVIEW AVANZADO - Ejemplo completo
// ============================================================================
class ListViewAvanzado extends StatelessWidget {
  const ListViewAvanzado({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Producto> productos = List.generate(
      30,
      (index) => Producto(
        id: index + 1,
        nombre: 'Producto ${index + 1}',
        precio: (index + 1) * 10.0,
        descripcion: 'Descripción del producto ${index + 1}',
        imagen: 'https://via.placeholder.com/100',
      ),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('ListView Avanzado')),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        itemCount: productos.length,
        itemBuilder: (context, index) {
          final producto = productos[index];
          return ProductoTile(producto: producto);
        },
        separatorBuilder: (context, index) => const SizedBox(height: 8),
      ),
    );
  }
}

// Modelo de datos
class Producto {
  final int id;
  final String nombre;
  final double precio;
  final String descripcion;
  final String imagen;

  Producto({
    required this.id,
    required this.nombre,
    required this.precio,
    required this.descripcion,
    required this.imagen,
  });
}

// Widget personalizado para cada producto
// Demuestra cómo crear un ListTile personalizado y reutilizable
class ProductoTile extends StatelessWidget {
  final Producto producto;

  const ProductoTile({
    Key? key,
    required this.producto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      // ListTile con propiedades avanzadas:
      child: ListTile(
        // leading: Widget personalizado como leading
        // En este caso, un contenedor con imagen del producto
        leading: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.image, color: Colors.grey),
        ),
        
        // title: Nombre del producto en negrita
        title: Text(
          producto.nombre,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        
        // subtitle: Contenedor con descripción y precio
        // Usando Column para mostrar múltiples datos
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Descripción del producto
            Text(producto.descripcion),
            const SizedBox(height: 4),
            // Precio en color verde para destacar
            Text(
              '\$${producto.precio.toStringAsFixed(2)}',
              style: const TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        
        // trailing: Botón de acción (agregar al carrito)
        trailing: IconButton(
          icon: const Icon(Icons.add_shopping_cart),
          onPressed: () {
            // Muestra un Snackbar confirmando la acción
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('${producto.nombre} añadido al carrito')),
            );
          },
        ),
      ),
    );
  }
}

// ============================================================================
// 8. PANTALLA PRINCIPAL - Menú de ejemplos
// ============================================================================
/// 
/// 📌 RESUMEN - CUÁNDO USAR CADA TIPO:
/// 
/// 📍 ListView(children: [...])
///    ✅ Pocos elementos (< 20) que siempre caben en RAM
///    ✅ Simple y directo
///    ❌ Crea TODOS los widgets desde el inicio (ineficiente)
///
/// 📍 ListView.builder()
///    ✅ Lista grande de elementos
///    ✅ Solo crea widgets visibles (OPTIMIZADO)
///    ✅ MEJOR OPCIÓN para la mayoría de casos
///    ❌ Un poco más complejo
///
/// 📍 ListView.separated()
///    ✅ Quieres divisores entre elementos
///    ✅ Divisores automáticos (eficiente)
///    ❌ Necesitas definir separatorBuilder
///
/// ⚡ TIPS DE RENDIMIENTO:
///    1️⃣ Usa itemExtent si todos los elementos tienen igual altura
///    2️⃣ Usa ListView.builder en lugar del constructor simple
///    3️⃣ Evita shrinkWrap: true si no es necesario
///    4️⃣ Usa const constructores siempre que puedas
///    5️⃣ No hagas operaciones pesadas en itemBuilder
///
class MiListViewEjemplos extends StatelessWidget {
  const MiListViewEjemplos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ejemplos de ListView')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Card introductoria con información
          Card(
            color: Colors.blue,
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                '📚 EXPLORER DE LISTVIEW Y LISTTILE\n\n'
                '• ListView: Widget para mostrar listas scrolleables\n'
                '• ListTile: Widget que estructura items de lista\n\n'
                'Toca en cada ejemplo para explorar.',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
          const SizedBox(height: 16),
          _EjemploBoton(
            titulo: '1. ListView Simple',
            descripcion: 'Constructor básico con children',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ListViewSimple()),
              );
            },
          ),
          _EjemploBoton(
            titulo: '2. ListView.builder()',
            descripcion: 'Optimizado para listas largas',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ListViewBuilder()),
              );
            },
          ),
          _EjemploBoton(
            titulo: '3. ListView.separated()',
            descripcion: 'Con divisores entre elementos',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ListViewSeparated()),
              );
            },
          ),
          _EjemploBoton(
            titulo: '4. Propiedades del ListView',
            descripcion: 'Scrolling, padding, physics, etc.',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ListViewConPropiedades()),
              );
            },
          ),
          _EjemploBoton(
            titulo: '4.5 Ejemplos de Trailing',
            descripcion: 'Iconos, switches, checkboxes y menús',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const EjemploTrailing()),
              );
            },
          ),
          _EjemploBoton(
            titulo: '5. ScrollController',
            descripcion: 'Control programático del scroll',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ListViewConController()),
              );
            },
          ),
          _EjemploBoton(
            titulo: '6. ListView Horizontal',
            descripcion: 'Scroll en dirección horizontal',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ListViewHorizontal()),
              );
            },
          ),
          _EjemploBoton(
            titulo: '7. Ejemplo Avanzado',
            descripcion: 'ListView con modelo de datos',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ListViewAvanzado()),
              );
            },
          ),
        ],
      ),
    );
  }
}

// Widget reutilizable para los botones del menú
// Demuestra cómo crear un ListTile personalizado para navegación
class _EjemploBoton extends StatelessWidget {
  final String titulo;    // Texto principal del botón
  final String descripcion; // Texto secundario (descripción)
  final VoidCallback onPressed; // Función al tocar

  const _EjemploBoton({
    required this.titulo,
    required this.descripcion,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      // margin: Espaciado externo (alrededor del Card)
      margin: const EdgeInsets.only(bottom: 12),
      // Este Card contiene un ListTile que es interactivo
      child: ListTile(
        // title: Texto principal - el nombre del ejemplo
        title: Text(
          titulo,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        // subtitle: Texto secundario - descripción del ejemplo
        subtitle: Text(descripcion),
        // trailing: Icono a la derecha indicando navegación
        trailing: const Icon(Icons.arrow_forward),
        // onTap: Se ejecuta cuando tocas el ListTile
        onTap: onPressed,
      ),
    );
  }
}
