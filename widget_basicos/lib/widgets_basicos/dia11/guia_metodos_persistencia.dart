/*
╔═══════════════════════════════════════════════════════════════════════════════╗
║         📚 MÉTODOS DE PERSISTENCIA DE DATOS EN FLUTTER - COMPARACIÓN         ║
║                                                                               ║
║ Esta es una GUÍA EDUCATIVA que compara los diferentes métodos para guardar   ║
║ datos en Flutter, sus ventajas, desventajas y cuándo usar cada uno.          ║
╚═══════════════════════════════════════════════════════════════════════════════╝
*/

// ═══════════════════════════════════════════════════════════════════════════════
// 1️⃣ SharedPreferences (Más simple y común)
// ═══════════════════════════════════════════════════════════════════════════════

/*
📦 INSTALACIÓN:
pubspec.yaml:
  dependencies:
    shared_preferences: ^2.0.0 (o versión más reciente)

💾 QUÉ ALMACENA:
- Tipos primitivos simples: String, int, double, bool, List<String>
- Es un almacenamiento de clave-valor (como un diccionario)

⚡ USO BÁSICO:

  // GUARDAR
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('nombre', 'Juan');
  await prefs.setInt('edad', 25);
  await prefs.setBool('logueado', true);

  // LEER
  String nombre = prefs.getString('nombre') ?? 'Desconocido';
  int edad = prefs.getInt('edad') ?? 0;
  bool logueado = prefs.getBool('logueado') ?? false;

  // ELIMINAR
  await prefs.remove('nombre');
  await prefs.clear(); // Borra TODO

✅ VENTAJAS:
  • Muy simple de usar
  • Perfecto para datos pequeños
  • No requiere dependencias complejas
  • Rendimiento rápido
  • Ideal para preferencias de usuario

❌ DESVENTAJAS:
  • Solo tipos simples
  • No es una base de datos real
  • Lento si tienes muchos datos
  • No tiene relaciones entre datos
  • No escalable para aplicaciones complejas

🎯 MEJOR PARA:
  ✓ Guardar preferencias del usuario
  ✓ Recordar último login
  ✓ Guardar token de autenticación
  ✓ Contar visitas/interacciones
  ✓ Guardar configuración simple
  ✓ Datos pequeños que cambian ocasionalmente

❌ NO USAR PARA:
  ✗ Listas grandes de objetos complejos
  ✗ Datos que tienen relaciones
  ✗ Información sensible crítica
  ✗ Datos que requieren consultas complejas
*/

// ═══════════════════════════════════════════════════════════════════════════════
// 2️⃣ Hive (Base de datos local NoSQL)
// ═══════════════════════════════════════════════════════════════════════════════

/*
📦 INSTALACIÓN:
pubspec.yaml:
  dependencies:
    hive: ^2.0.0
    hive_flutter: ^1.1.0
  dev_dependencies:
    hive_generator: ^2.0.0
    build_runner: ^2.0.0

💾 QUÉ ALMACENA:
- Objetos complejos
- Listas de objetos
- Datos jerarquizados

⚡ USO BÁSICO:

  // DEFINIR MODELO (con anotaciones)
  @HiveType()
  class Persona {
    @HiveField(0)
    String nombre;
    
    @HiveField(1)
    int edad;
  }

  // GENERAR: flutter pub run build_runner build

  // USAR
  final personaBox = Hive.box<Persona>('personas');
  personaBox.add(Persona(nombre: 'Juan', edad: 25));
  List<Persona> todas = personaBox.values.toList();

✅ VENTAJAS:
  • Muy rápido (optimizado para mobile)
  • Soporta objetos complejos
  • Puede indexar y consultar datos
  • Perfecto para Flutter
  • Código generado automáticamente

❌ DESVENTAJAS:
  • Más complejo de aprender
  • Requiere code generation
  • Overhead inicial de configuración
  • No es una base de datos relacional

🎯 MEJOR PARA:
  ✓ Listas de tareas
  ✓ Contactos locales
  ✓ Productos de una tienda
  ✓ Chats sin sincronización
  ✓ Datos offline que se sincronizan después

❌ NO USAR PARA:
  ✗ Datos que necesitan SQL complejo
  ✗ Relaciones complejas entre tablas
  ✗ Análisis de datos grande
*/

// ═══════════════════════════════════════════════════════════════════════════════
// 3️⃣ SQLite (Base de datos relacional)
// ═══════════════════════════════════════════════════════════════════════════════

/*
📦 INSTALACIÓN:
pubspec.yaml:
  dependencies:
    sqflite: ^2.0.0
    path: ^1.8.0

💾 QUÉ ALMACENA:
- Tablas con filas y columnas
- Relaciones entre tablas
- Datos complejos con queries SQL

⚡ USO BÁSICO:

  // CREAR BD
  Database db = await openDatabase(
    join(await getDatabasesPath(), 'mi_bd.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE personas(id INTEGER PRIMARY KEY, nombre TEXT)',
      );
    },
  );

  // INSERTAR
  await db.insert('personas', {'nombre': 'Juan'});

  // CONSULTAR
  List<Map> resultado = await db.query('personas');

  // ACTUALIZAR
  await db.update('personas', {'nombre': 'Carlos'}, where: 'id = ?');

  // ELIMINAR
  await db.delete('personas', where: 'id = ?');

✅ VENTAJAS:
  • Muy poderoso y flexible
  • SQL estándar
  • Relaciones complejas
  • Transacciones
  • Mejor para datos grandes

❌ DESVENTAJAS:
  • Más complejo de código
  • SQL puede ser complicado
  • Overhead inicial mayor
  • Menos intuitivo que Hive

🎯 MEJOR PARA:
  ✓ Aplicaciones con datos complejos
  ✓ Relaciones entre entidades
  ✓ Análisis de datos
  ✓ Gran volumen de datos
  ✓ Consultas complejas

❌ NO USAR PARA:
  ✗ Preferencias simples
  ✗ Datos muy pequeños
  ✗ Prototipos rápidos
*/

// ═══════════════════════════════════════════════════════════════════════════════
// 4️⃣ Firebase (Backend en la nube)
// ═══════════════════════════════════════════════════════════════════════════════

/*
📦 INSTALACIÓN:
pubspec.yaml:
  dependencies:
    firebase_core: ^latest
    cloud_firestore: ^latest

💾 QUÉ ALMACENA:
- Documentos JSON en la nube
- Sincronización automática
- Autenticación integrada

⚡ USO BÁSICO:

  // GUARDAR
  await FirebaseFirestore.instance.collection('usuarios').add({
    'nombre': 'Juan',
    'edad': 25,
  });

  // LEER
  QuerySnapshot snapshot = 
    await FirebaseFirestore.instance.collection('usuarios').get();

  // ESCUCHAR CAMBIOS (Real-time)
  FirebaseFirestore.instance.collection('usuarios').snapshots().listen(
    (snapshot) {
      // Se ejecuta cada vez que hay cambios
    }
  );

✅ VENTAJAS:
  • Sincronización en tiempo real
  • Almacenamiento en la nube
  • Autenticación integrada
  • Escala automática
  • Backup automático

❌ DESVENTAJAS:
  • Requiere conexión a internet
  • Costos por uso
  • Requiere configuración Firebase
  • Dependencia de servicio externo
  • Privacidad/seguridad de datos

🎯 MEJOR PARA:
  ✓ Aplicaciones multiusuario
  ✓ Chat en tiempo real
  ✓ Sincronización entre dispositivos
  ✓ Datos que necesitan backup
  ✓ Aplicaciones con backend

❌ NO USAR PARA:
  ✗ Datos que solo están en un dispositivo
  ✗ Aplicaciones offline-first
  ✗ Cuando necesitas control total
*/

// ═══════════════════════════════════════════════════════════════════════════════
// TABLA COMPARATIVA RÁPIDA
// ═══════════════════════════════════════════════════════════════════════════════

/*
┌─────────────────────┬──────────┬──────┬────────┬──────────┬──────────────┐
│ Característica      │ Shared   │ Hive │ SQLite │ Firebase │ Recomendado  │
├─────────────────────┼──────────┼──────┼────────┼──────────┼──────────────┤
│ Facilidad de uso    │ ⭐⭐⭐⭐⭐ │ ⭐⭐⭐⭐ │ ⭐⭐⭐ │ ⭐⭐⭐⭐ │ ✅ Shared   │
│ Velocidad           │ ⭐⭐⭐⭐ │ ⭐⭐⭐⭐⭐ │ ⭐⭐⭐⭐ │ ⭐⭐⭐ │ ✅ Hive      │
│ Escalabilidad       │ ⭐       │ ⭐⭐⭐ │ ⭐⭐⭐⭐ │ ⭐⭐⭐⭐⭐ │ ✅ Firebase  │
│ Datos complejos     │ ❌       │ ⭐⭐⭐⭐ │ ⭐⭐⭐⭐⭐ │ ⭐⭐⭐⭐⭐ │ ✅ Firebase  │
│ Sync tiempo real    │ ❌       │ ❌    │ ❌     │ ⭐⭐⭐⭐⭐ │ ✅ Firebase  │
│ Necesita internet   │ No       │ No   │ No     │ Sí       │ Depende      │
│ Costo               │ Gratis   │ Gratis│ Gratis │ Por uso  │ ✅ Gratis    │
└─────────────────────┴──────────┴──────┴────────┴──────────┴──────────────┘
*/

// ═══════════════════════════════════════════════════════════════════════════════
// 🎯 DECISIÓN RÁPIDA: ¿CUÁL USAR?
// ═══════════════════════════════════════════════════════════════════════════════

/*
¿Necesitas sincronizar entre dispositivos o con otros usuarios?
  ↓ SÍ → Firebase
  ↓ NO → Continúa

¿Tienes datos muy complejos con relaciones SQL?
  ↓ SÍ → SQLite
  ↓ NO → Continúa

¿Tienes lista pequeña de objetos (tareas, contactos)?
  ↓ SÍ → Hive (mejor) o SQLite (si quieres SQL)
  ↓ NO → Continúa

¿Solo necesitas guardar preferencias simples (strings, números)?
  ↓ SÍ → SharedPreferences ✅
  ↓ NO → Usa Hive o Firebase
*/

// ═══════════════════════════════════════════════════════════════════════════════
// PARA ESTE CURSO
// ═══════════════════════════════════════════════════════════════════════════════

/*
📌 DÍA 11: PERSISTENCIA CON SharedPreferences y demás

✅ Usamos SharedPreferences porque:
  • Es perfecto para aprender conceptos de persistencia
  • No necesita configuración compleja
  • Es la opción "más simple" y educativa
  • Muchas apps reales usan SharedPreferences para configuración
  • Es el punto de partida antes de bases de datos complejas


💡 REGLA DE ORO:
  "Empieza simple, escala cuando sea necesario"
*/
