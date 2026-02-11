import 'package:flutter/material.dart';
import 'package:widget_basicos/widgets_basicos/dia11/dia_11_persistencia.dart';
import 'package:widget_basicos/widgets_basicos/dia11/hive_ejemplo.dart';
import 'package:widget_basicos/widgets_basicos/dia9/dia_9_2.dart';
import 'package:widget_basicos/widgets_basicos/dia9/my_images.dart';
import 'package:widget_basicos/widgets_basicos/dia9/my_images2.dart';
import 'package:widget_basicos/widgets_basicos/dia9/my_listview.dart';
import 'package:widget_basicos/widgets_basicos/dia9/my_scaffold.dart';
import 'package:widget_basicos/widgets_basicos/dia9/my_snackbar.dart';
import 'package:widget_basicos/widgets_basicos/my_col_row_stack.dart';
import 'package:widget_basicos/widgets_basicos/my_container.dart';
import 'package:widget_basicos/widgets_basicos/my_statefull.dart';
import 'package:widget_basicos/widgets_basicos/my_text.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AlmacenamientoHive.inicializar();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // ===== VERSIÓN DE MATERIAL =====
        useMaterial3: true, // Usa Material Design 3 (más moderno) si es true
        // https://docs.flutter.dev/cookbook/design/themes

        // ===== COLORES PRINCIPALES =====
        primaryColor:
            Colors.blue, // Color primario principal (AppBar, botones, etc)
        primarySwatch: Colors
            .blue, // Paleta de colores derivada del color primario (DEPRECATED, usa ColorScheme)
        // ===== COLOR SCHEME (Moderna, Material Design 3) =====
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.orange,
          brightness: Brightness.light,
        ),

        // ===== COLORES SECUNDARIOS =====
        // secondaryHeaderColor: Colors.orange,  // Color secundario

        // ===== FONDOS =====
        scaffoldBackgroundColor: Colors.white, // Fondo del Scaffold
        // backgroundColor: Colors.grey[100],  // Fondo general (deprecated)

        // ===== BRILLO (Claro/Oscuro) =====
        brightness: Brightness.light, // Claro (light) u Oscuro (dark)
        // ===== TIPOGRAFÍA (TextTheme) =====
        // Define todos los estilos de texto predefinidos para la app
        textTheme: TextTheme(
          // === ESTILOS DISPLAY (Muy grandes, para títulos principales) ===
          displayLarge: TextStyle(
            fontSize: 32, // Tamaño muy grande
            fontWeight: FontWeight.bold, // Peso: bold (700)
            // Uso: Títulos principales, pantallas de inicio
          ),
          displayMedium: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            // Uso: Títulos secundarios
          ),
          displaySmall: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            // Uso: Subtítulos importantes
          ),

          // === ESTILOS HEADLINE (Encabezados medianos) ===
          headlineLarge: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700, // 700 = bold
            // Uso: Encabezados de secciones principales
          ),
          headlineMedium: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600, // 600 = semibold
            // Uso: Encabezados de subsecciones, títulos de tarjetas
          ),
          headlineSmall: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            // Uso: Títulos pequeños, items importantes
          ),

          // === ESTILOS TITLE (Títulos para etiquetas y labels) ===
          titleLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500, // 500 = medium
            // Uso: Títulos de listas, botones grandes
          ),
          titleMedium: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            // Uso: Etiquetas, títulos de diálogos
          ),
          titleSmall: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            // Uso: Labels pequeños, avisos
          ),

          // === ESTILOS BODY (Cuerpo del texto, el más usado) ===
          bodyLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal, // 400 = normal/regular
            // Uso: Párrafos principales, texto descriptivo importante
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            // Uso: Texto general de la aplicación, párrafos normales
          ),
          bodySmall: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.normal,
            // Uso: Descripción pequeña, meta información, timestamps
          ),

          // === ESTILOS LABEL (Para etiquetas y botones pequeños) ===
          labelLarge: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            // Uso: Botones, etiquetas grandes
          ),
          labelMedium: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            // Uso: Chips, badges
          ),
          labelSmall: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            // Uso: Labels muy pequeños, indicadores
          ),
        ),

        // ===== BARRA SUPERIOR (AppBar) =====
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          elevation: 4,
          centerTitle: true,
        ),

        // ===== BOTONES ELEVADOS (ElevatedButton) =====
        // elevatedButtonTheme: ElevatedButtonThemeData(
        //   style: ElevatedButton.styleFrom(
        //     backgroundColor: Colors.blue,
        //     foregroundColor: Colors.white,
        //     padding: EdgeInsets.all(16),
        //   ),
        // ),

        // ===== BOTONES DE TEXTO (TextButton) =====
        // textButtonTheme: TextButtonThemeData(
        //   style: TextButton.styleFrom(
        //     foregroundColor: Colors.blue,
        //   ),
        // ),

        // ===== BOTONES CON BORDE (OutlinedButton) =====
        // outlinedButtonTheme: OutlinedButtonThemeData(
        //   style: OutlinedButton.styleFrom(
        //     foregroundColor: Colors.blue,
        //     side: BorderSide(color: Colors.blue),
        //   ),
        // ),

        // ===== BOTONES FLOTANTES (FAB) =====
        // floatingActionButtonTheme: FloatingActionButtonThemeData(
        //   backgroundColor: Colors.blue,
        //   foregroundColor: Colors.white,
        //   elevation: 8,
        // ),

        // ===== CAMPOS DE TEXTO (TextField) =====
        // inputDecorationTheme: InputDecorationTheme(
        //   border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        //   filled: true,
        //   fillColor: Colors.grey[100],
        //   contentPadding: EdgeInsets.all(16),
        // ),

        // ===== CHIPS =====
        // chipTheme: ChipThemeData(
        //   backgroundColor: Colors.blue,
        //   labelStyle: TextStyle(color: Colors.white),
        // ),

        // ===== DIÁLOGOS =====
        // dialogTheme: DialogTheme(
        //   backgroundColor: Colors.white,
        //   elevation: 8,
        // ),

        // ===== ICONOS =====
        // iconTheme: IconThemeData(
        //   color: Colors.blue,
        //   size: 24,
        // ),

        // ===== BARRAS DE PROGRESO =====
        // progressIndicatorTheme: ProgressIndicatorThemeData(
        //   color: Colors.blue,
        //   linearTrackColor: Colors.blue[100],
        // ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.orange,
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: Colors.black,
      ),
      themeMode: ThemeMode
          .system, // Usa el tema claro/oscuro según la configuración del sistema
      debugShowCheckedModeBanner: false, // Oculta el banner de debug
      title: 'Widgets Básicos', // No aparece directamente, pero es el título de la app
      //home: MyText(),
      // home: MyContainer()  //Error si MyContainer devuelve un Container sin Scaffold,
      //  porque MaterialApp espera un Scaffold como raíz
      // o CupertinoPageScaffold  o similar
      //home: MyColRowStack(),
      //home: MyFlex(),
      //home: MyBasicWidgets(),
      //home: StatisticsDashboard(),
      // home: Dia92(),
      // routes: { //Rutas nombradas
      //   '/' : (context) => Dia92(), //Donde entra la aplicacion. Incompatible con home
      //   '/snackbar' : (context) => MySnackBar(),
      //   '/scaffold' : (context) => MyScaffold(),
      //   '/images' : (context) => MyImages(),
      //   '/images1' : (context) => MyImages2(),
      //   '/listview' : (context) => MiListViewEjemplos()
      // },
      home: Dia11Persistencia(),
    );
  }
}
/*
      Scaffold(
        appBar: AppBar(title: Text(titulo ?? "Sin título")),
        body: Center(
          child: Container(
            //alignment: AlignmentGeometry.center,
            width: double.maxFinite,
            height: 200,
            // width: null, por defecto. Se adapta al contenido
            // height: null, por defecto. Se adapta al contenido
            decoration: BoxDecoration(color: Colors.blue, 
            border: Border.all(
              color:Colors.orange, width: 15, //Seguir aquí
            )),
            // color: Colors.yellow,
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.only(left: 20, right: 40),
            child: Text(
              "Hola mundo, lorem ipsum dsfasdfafadsfasdfdsafdsffasdf",
              textAlign: TextAlign.left, //Centrado del texto
              textDirection: TextDirection.ltr,
              textScaler: TextScaler.linear(0.5), //Escalar
              semanticsLabel: "Texto para lectores de pantalla", //Accesibilidad
              locale: Locale('es', 'ES'),
              //maxLines: 1, //Cantida máxima de líneas
              //Desbordamiento
              //overflow: TextOverflow.ellipsis, //Añade ...
              //overflow: TextOverflow.clip, //Corta el texto
              overflow: TextOverflow.fade,
              //style: miEstilo2,
              /*style: TextStyle(
                fontSize: 30,
              )*/
              style: estilo,
            ),
          ),
        ),
      ),
    );
  }
}

TextStyle miEstilo = TextStyle(
  fontSize: 30,
  fontWeight: FontWeight.w900,
  color: // Color(0xFF00FF00),
  Color.fromARGB(
    255,
    64,
    132,
    206,
  ),
  //Colors.orange.shade50,
  fontStyle: FontStyle.italic,
  decoration: TextDecoration.underline, //Situación de la línea
  decorationColor: Colors.red, //Color de la línea
  decorationStyle: TextDecorationStyle.wavy, //Tipo de línea
  decorationThickness: 3, //Grosor
  letterSpacing: 2, //Espacio entre letras
  wordSpacing: 10,
  height: 1.5, //Multiplicador de altura
  shadows: [
    Shadow(
      offset: Offset(4, 4), // x e y
      blurRadius: 4, //Desenfoque
      color: const Color.fromARGB(125, 236, 157, 157),
    ),
  ],
);

*/