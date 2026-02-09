import 'package:flutter/material.dart';

/// 🏠 SCAFFOLD EN FLUTTER - GUÍA COMPLETA PARA ESTUDIANTES
/// 
/// El Scaffold es UNO DE LOS WIDGETS MÁS IMPORTANTES en Flutter.
/// Es como el "marco" o "estructura básica" de una pantalla.
/// 
/// Sin Scaffold:
/// ❌ Difícil posicionar elementos
/// ❌ Sin botón atrás automático
/// ❌ Sin AppBar integrada
/// ❌ Sin soporte para FAB (Floating Action Button)
/// ❌ Complicado implementar drawer
/// 
/// Con Scaffold:
/// ✅ Estructura clara y organizada
/// ✅ AppBar, body, FAB, drawer, etc. integrados
/// ✅ Manejo automático de elementos
/// ✅ Material Design automático
/// ✅ Fácil de personalizar
/// 
/// ANALOGÍA:
/// Piensa en Scaffold como un EDIFICIO:
/// 
///  ┌─────────────────────────────────────┐
///  │  AppBar (Techo/Entrada principal)   │  ← AppBar: Barra superior
///  ├─────────────────────────────────────┤
///  │                                     │
///  │                                     │
///  │  Body (Contenido principal)         │  ← Body: Donde va el contenido
///  │                                     │
///  │                                     │
///  ├─────────────────────────────────────┤
///  │  BottomNavigationBar (Puerta)       │  ← Navegación inferior
///  └─────────────────────────────────────┘
///  
///  🎯 FAB (Botón flotante en la esquina)

/// ═══════════════════════════════════════════════════════════════════════════
/// PANTALLA PRINCIPAL CON EJEMPLOS
/// ═══════════════════════════════════════════════════════════════════════════

class MyScaffold extends StatefulWidget {
  const MyScaffold({super.key});

  @override
  State<MyScaffold> createState() => _MyScaffoldState();
}

class _MyScaffoldState extends State<MyScaffold> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// ─────────────────────────────────────────────────────────────────────
      /// 1️⃣ AppBar - La barra superior
      /// ─────────────────────────────────────────────────────────────────────
      /// 
      /// El AppBar es una sección horizontal en la parte superior.
      /// Típicamente contiene:
      /// - Título de la pantalla
      /// - Iconos de acción (settings, search, etc.)
      /// - Botón para abrir Drawer
      /// 
      /// PROPIEDADES PRINCIPALES:
      /// - title: Texto que aparece en el centro (o izquierda)
      /// - backgroundColor: Color de fondo
      /// - elevation: Sombra debajo del AppBar
      /// - leading: Widget antes del título (ej: botón atrás)
      /// - actions: Lista de iconos a la derecha
      /// - bottom: Widget que aparece debajo (ej: TabBar)
      appBar: AppBar(
        title: const Text('Scaffold - Widget Fundamental'),
        backgroundColor: Colors.blue[700],
        elevation: 8, // Sombra: 0=sin sombra, 8=mucha sombra
        centerTitle: true, // Centra el título
        
        /// Icono personalizado a la izquierda
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Icono de menú presionado')),
            );
          },
        ),
        
        /// Acciones a la derecha del AppBar
        /// Son widgets que aparecen en la esquina derecha
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Búsqueda presionada')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Más opciones presionado')),
              );
            },
          ),
        ],
      ),

      /// ─────────────────────────────────────────────────────────────────────
      /// 2️⃣ Body - El contenido principal
      /// ─────────────────────────────────────────────────────────────────────
      /// 
      /// El body es el CORAZÓN del Scaffold.
      /// Aquí va TODO el contenido de la pantalla.
      /// 
      /// REGLA IMPORTANTE:
      /// El body puede ser CUALQUIER widget:
      /// - Column, Row
      /// - ListView, GridView
      /// - SingleChildScrollView
      /// - Widgets personalizados
      /// 
      /// CONSEJO: Si tienes mucho contenido, usa ListView o SingleChildScrollView
      /// para que sea scrolleable.
      body: _buildBodyContent(),

      /// ─────────────────────────────────────────────────────────────────────
      /// 3️⃣ Drawer - Menú lateral
      /// ─────────────────────────────────────────────────────────────────────
      /// 
      /// Un menú que se desliza desde la IZQUIERDA.
      /// Se abre al:
      /// - Deslizar desde el borde izquierdo
      /// - Presionar el botón de menú (hamburguesa) en AppBar
      /// 
      /// ESTRUCTURA TÍPICA:
      /// Drawer
      ///   └─ ListView
      ///       ├─ DrawerHeader (encabezado)
      ///       └─ ListTile (items del menú)
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            /// HEADER del Drawer - Sección decorativa arriba
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue[700],
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.person, size: 50, color: Colors.white),
                  SizedBox(height: 10),
                  Text(
                    'Mi Aplicación',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            
            /// ITEMS del menú
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Inicio'),
              onTap: () {
                Navigator.pop(context); // Cierra el Drawer
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Configuración'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('Acerca de'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),

      /// ─────────────────────────────────────────────────────────────────────
      /// 4️⃣ FloatingActionButton (FAB) - Botón flotante
      /// ─────────────────────────────────────────────────────────────────────
      /// 
      /// Un botón REDONDO y FLOTANTE en la esquina inferior derecha.
      /// Típicamente para la acción PRINCIPAL de la pantalla.
      /// 
      /// EJEMPLOS DE USO:
      /// - Botón "+" para crear algo nuevo
      /// - Botón para hacer una llamada
      /// - Botón para enviar un mensaje
      /// 
      /// RECOMENDACIÓN:
      /// - Usa FAB para SOLO UNA acción importante
      /// - Si necesitas más botones, usa BottomNavigationBar o AppBar
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('FAB presionado - Acción principal'),
              duration: Duration(seconds: 2),
            ),
          );
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),

      /// ─────────────────────────────────────────────────────────────────────
      /// 5️⃣ FloatingActionButtonLocation - Posición del FAB
      /// ─────────────────────────────────────────────────────────────────────
      /// 
      /// Por defecto, el FAB está en la esquina inferior derecha.
      /// Puedes cambiar su posición:
      /// 
      /// - FloatingActionButtonLocation.endFloat
      ///   (Por defecto: esquina inferior derecha)
      /// 
      /// - FloatingActionButtonLocation.centerFloat
      ///   (Centro inferior, ideal con BottomNavigationBar)
      /// 
      /// - FloatingActionButtonLocation.startFloat
      ///   (Esquina inferior izquierda)
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      /// ─────────────────────────────────────────────────────────────────────
      /// 6️⃣ BottomNavigationBar - Navegación en la parte inferior
      /// ─────────────────────────────────────────────────────────────────────
      /// 
      /// Una barra con MÚLTIPLES opciones en la parte inferior.
      /// Se usa para navegar entre secciones principales.
      /// 
      /// DIFERENCIA CON FAB:
      /// - FAB: UNA sola acción importante
      /// - BottomNavigationBar: MÚLTIPLES opciones de navegación
      /// 
      /// TIPOS:
      /// 1. BottomNavigationBar: Barra fija (tradicional)
      /// 2. BottomNavigationBar con shifting: Colores que cambian
      /// 3. NavigationBar (Material 3): Más moderno
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        backgroundColor: Colors.blue[700],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        elevation: 8, // Agrega sombra y asegura que sea visible
        type: BottomNavigationBarType.fixed, // Asegura que se vea todo
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          
          /// EJEMPLO: Realizar acciones según el índice presionado
          /// 
          /// switch (index) {
          ///   case 0: // Inicio
          ///     print('Ir a pantalla de Inicio');
          ///     // Navigator.pushNamed(context, '/home');
          ///     break;
          ///   case 1: // Buscar
          ///     print('Abrir búsqueda');
          ///     ScaffoldMessenger.of(context).showSnackBar(
          ///       const SnackBar(content: Text('Buscando...')),
          ///     );
          ///     break;
          ///   case 2: // Favoritos
          ///     print('Mostrar favoritos');
          ///     // Mostrar lista de favoritos
          ///     break;
          ///   case 3: // Perfil
          ///     print('Ir a perfil del usuario');
          ///     // Navigator.pushNamed(context, '/profile');
          ///     break;
          /// }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Buscar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favoritos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),

      /// ═════════════════════════════════════════════════════════════════════
      /// EJEMPLO PRÁCTICO: ACCIONES POR CADA BOTTOMNAVIGATIONBARITEM
      /// ═════════════════════════════════════════════════════════════════════
      /// 
      /// OPCIÓN 1: Cambiar el contenido del body según el índice
      /// ────────────────────────────────────────────────────────────────
      /// body: _buildBodyContent(), // Se actualiza según _selectedIndex
      /// 
      /// El método _buildBodyContent() cambiaría así:
      /// 
      /// Widget _buildBodyContent() {
      ///   switch (_selectedIndex) {
      ///     case 0:
      ///       return HomeScreen();
      ///     case 1:
      ///       return SearchScreen();
      ///     case 2:
      ///       return FavoritesScreen();
      ///     case 3:
      ///       return ProfileScreen();
      ///     default:
      ///       return HomeScreen();
      ///   }
      /// }
      /// 
      /// ─────────────────────────────────────────────────────────────────
      /// OPCIÓN 2: Navegar a pantallas diferentes (con rutas)
      /// ─────────────────────────────────────────────────────────────────
      /// 
      /// onTap: (index) {
      ///   switch (index) {
      ///     case 0:
      ///       Navigator.pushNamed(context, '/home');
      ///     case 1:
      ///       Navigator.pushNamed(context, '/search');
      ///     case 2:
      ///       Navigator.pushNamed(context, '/favorites');
      ///     case 3:
      ///       Navigator.pushNamed(context, '/profile');
      ///   }
      /// }
      /// 
      /// ─────────────────────────────────────────────────────────────────
      /// OPCIÓN 3: Acciones sin cambiar pantalla
      /// ─────────────────────────────────────────────────────────────────
      /// 
      /// onTap: (index) {
      ///   switch (index) {
      ///     case 0: // Inicio
      ///       setState(() => _selectedIndex = 0);
      ///     case 1: // Buscar
      ///       _openSearchDialog();
      ///     case 2: // Favoritos
      ///       _loadFavorites();
      ///     case 3: // Perfil
      ///       _showUserProfile();
      ///   }
      /// }
      /// 
      /// ─────────────────────────────────────────────────────────────────
      /// OPCIÓN 4: Mostrar snackbars o diálogos
      /// ─────────────────────────────────────────────────────────────────
      /// 
      /// onTap: (index) {
      ///   setState(() => _selectedIndex = index);
      ///   
      ///   final messages = [
      ///     'Bienvenido a Inicio',
      ///     'Realizando búsqueda...',
      ///     'Cargando favoritos...',
      ///     'Abriendo perfil...',
      ///   ];
      ///   
      ///   ScaffoldMessenger.of(context).showSnackBar(
      ///     SnackBar(content: Text(messages[index])),
      ///   );
      /// }
      /// 
      /// ─────────────────────────────────────────────────────────────────
      /// OPCIÓN 5: Validaciones antes de navegar
      /// ─────────────────────────────────────────────────────────────────
      /// 
      /// onTap: (index) {
      ///   // Solo ir a perfil si el usuario está autenticado
      ///   if (index == 3) {
      ///     if (isUserLoggedIn) {
      ///       setState(() => _selectedIndex = index);
      ///     } else {
      ///       _showLoginDialog();
      ///     }
      ///   } else {
      ///     setState(() => _selectedIndex = index);
      ///   }
      /// }
      /// 
      /// ═════════════════════════════════════════════════════════════════════

      /// ─────────────────────────────────────────────────────────────────────
      /// 7️⃣ EndDrawer - Menú lateral DERECHO (opcional)
      /// ─────────────────────────────────────────────────────────────────────
      /// 
      /// Similar a Drawer, pero se abre desde la DERECHA.
      /// Raramente usado, pero útil para opciones secundarias.
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.orange[700],
              ),
              child: const Text(
                'Opciones',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text('Ayuda'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.feedback),
              title: const Text('Enviar feedback'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),

      /// ─────────────────────────────────────────────────────────────────────
      /// 8️⃣ ResizeToAvoidBottomInset - Teclado
      /// ─────────────────────────────────────────────────────────────────────
      /// 
      /// Cuando el teclado aparece, ¿qué pasa?
      /// 
      /// true (por defecto): El body se comprime para hacer espacio
      /// false: El body NO se mueve, el teclado lo cubre
      /// 
      /// RECOMENDACIÓN: Déjalo en true para formularios
      resizeToAvoidBottomInset: true,
    );
  }

  /// Contenido del body - Cambias según la pestaña seleccionada
  Widget _buildBodyContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// SECCIÓN 1: Información general
          _buildSection(
            title: 'Scaffold - Estructura Base',
            content: '''El Scaffold proporciona una estructura visual basada en Material Design. 
Es el widget fundamental para crear pantallas profesionales en Flutter.
            
Todos los componentes como AppBar, body, BottomNavigationBar, etc., 
funcionan juntos de manera coordinada.''',
          ),

          /// SECCIÓN 2: Componentes
          _buildSection(
            title: 'Componentes Principales',
            content: '''
1. AppBar - Barra superior con título y acciones
2. Body - Contenido principal de la pantalla
3. Drawer - Menú lateral izquierdo
4. FloatingActionButton (FAB) - Botón flotante
5. BottomNavigationBar - Barra inferior de navegación
6. EndDrawer - Menú lateral derecho (opcional)
7. FloatingActionButtonLocation - Posición del FAB
8. ResizeToAvoidBottomInset - Comportamiento del teclado
            ''',
          ),

          /// SECCIÓN 3: Props importantes
          _buildSection(
            title: 'Propiedades Importantes',
            content: '''
appBar: AppBar()
  └─ Barra superior con título, acciones, etc.

body: Widget()
  └─ Contenido principal (Column, ListView, etc.)

drawer: Drawer()
  └─ Menú lateral izquierdo

floatingActionButton: FloatingActionButton()
  └─ Botón flotante para acción principal

bottomNavigationBar: BottomNavigationBar()
  └─ Navegación inferior con múltiples opciones

backgroundColor: Color
  └─ Color de fondo del Scaffold

resizeToAvoidBottomInset: bool
  └─ Si el body se ajusta al aparecer el teclado
            ''',
          ),

          /// SECCIÓN 4: Ejemplo de uso
          _buildSection(
            title: 'Estructura Básica',
            content: '''
Scaffold(
  appBar: AppBar(title: Text('Mi App')),
  body: Center(child: Text('Hola Mundo')),
  floatingActionButton: FloatingActionButton(
    onPressed: () {},
    child: Icon(Icons.add),
  ),
  bottomNavigationBar: BottomNavigationBar(
    items: [...],
  ),
)
            ''',
          ),

          /// SECCIÓN 5: Comparativa
          _buildSection(
            title: 'Pantalla Seleccionada',
            content: 'Selecciona un item en el BottomNavigationBar: $_selectedIndex',
          ),
        ],
      ),
    );
  }

  /// Widget auxiliar para mostrar secciones
  Widget _buildSection({required String title, required String content}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.blue[700],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: Text(
            content,
            style: const TextStyle(fontSize: 14, height: 1.6),
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}

/// ═══════════════════════════════════════════════════════════════════════════
/// TABLA COMPARATIVA: SIN SCAFFOLD vs CON SCAFFOLD
/// ═══════════════════════════════════════════════════════════════════════════

/// SIN SCAFFOLD (❌ MAL):
/// 
/// @override
/// Widget build(BuildContext context) {
///   return Column(
///     children: [
///       Container(
///         color: Colors.blue,
///         child: Text('Barra superior'),
///       ),
///       Expanded(
///         child: SingleChildScrollView(
///           child: Text('Contenido'),
///         ),
///       ),
///       Container(
///         color: Colors.grey,
///         child: Row(
///           children: [Icon(Icons.home), Icon(Icons.search)],
///         ),
///       ),
///     ],
///   );
/// }
/// 
/// PROBLEMAS:
/// ❌ Mucho código boilerplate
/// ❌ Difícil de mantener
/// ❌ Sin Material Design automático
/// ❌ Sin soporte para temas
/// ❌ Comportamiento inconsistente

/// CON SCAFFOLD (✅ BIEN):
/// 
/// @override
/// Widget build(BuildContext context) {
///   return Scaffold(
///     appBar: AppBar(title: Text('Barra superior')),
///     body: SingleChildScrollView(child: Text('Contenido')),
///     bottomNavigationBar: BottomNavigationBar(
///       items: [
///         BottomNavigationBarItem(icon: Icon(Icons.home)),
///         BottomNavigationBarItem(icon: Icon(Icons.search)),
///       ],
///     ),
///   );
/// }
/// 
/// VENTAJAS:
/// ✅ Código limpio y legible
/// ✅ Fácil de mantener
/// ✅ Material Design automático
/// ✅ Soporte para temas
/// ✅ Comportamiento consistente

/// ═══════════════════════════════════════════════════════════════════════════
/// CASOS DE USO COMUNES
/// ═══════════════════════════════════════════════════════════════════════════

/// CASO 1: Aplicación con navegación
/// 
/// Scaffold(
///   appBar: AppBar(title: Text('Mi App')),
///   body: HomeScreen(),
///   bottomNavigationBar: BottomNavigationBar(items: [
///     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
///     BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Buscar'),
///   ]),
/// )

/// CASO 2: Formulario
/// 
/// Scaffold(
///   appBar: AppBar(title: Text('Nuevo Usuario')),
///   body: Form(
///     child: Column(
///       children: [
///         TextFormField(),
///         TextFormField(),
///         ElevatedButton(onPressed: () {}, child: Text('Guardar')),
///       ],
///     ),
///   ),
/// )

/// CASO 3: Lista con FAB
/// 
/// Scaffold(
///   appBar: AppBar(title: Text('Tareas')),
///   body: ListView(children: [...]),
///   floatingActionButton: FloatingActionButton(
///     onPressed: () => agregarTarea(),
///     child: Icon(Icons.add),
///   ),
/// )

/// ═══════════════════════════════════════════════════════════════════════════
/// RESUMEN PARA ESTUDIANTES
/// ═══════════════════════════════════════════════════════════════════════════

/// ¿CUÁNDO USAR SCAFFOLD?
/// ✅ Cuando necesitas una pantalla profesional
/// ✅ Cuando quieres seguir Material Design
/// ✅ Cuando necesitas AppBar
/// ✅ Cuando necesitas navegación
/// ✅ En casi TODAS las aplicaciones reales

/// ¿CUÁNDO NO USAR SCAFFOLD?
/// ❌ En widgets internos (dentro de otros widgets)
/// ❌ Si necesitas un diseño muy personalizado
/// ❌ En overlays o diálogos

/// CONSEJO FINAL:
/// Aprende Scaffold a fondo. Es la BASE de cualquier app Flutter.
/// El 90% de las pantallas que verás usarán Scaffold.
