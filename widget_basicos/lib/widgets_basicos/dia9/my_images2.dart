import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class MyImages2 extends StatelessWidget {
  const MyImages2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Formas de crear imagenes"),),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            FlutterLogo(size: 100,),
            SizedBox(height: 10,),
            //Imagen desde local
            Image.asset(
              'assets/images/foto.png',
              height: 200,
              width: 200,
              //Propiedades de ajuste
              // fit: BoxFit.cover, //Escala la imagen para que cubra todo el espacio disponible
              fit: BoxFit.contain, //Mantiene el aspecto, imagen completa
              // fit: BoxFit.fill, //Estira para llenar (deforma la imagen)
              // fit: BoxFit.fitWidth, //Ajusta el ancho
              // fit: BoxFit.fitHeight, //Ajusta el alto
              // fit: BoxFit.scaleDown, //Reduce si es necesario
              // fit: BoxFit.none, //Sin ajuste

              //alineacion
              // alignment: Alignment.center, //por defecto
              alignment: Alignment.topCenter,

              //Repeticion
              // repeat: ImageRepeat.noRepeat, //Valor por defecto, sin repeticion
              // repeat: ImageRepeat.repeat, //Repite la imagen en x e y
              repeat: ImageRepeat.repeatX, //Repite en el eje x
              // repeat: ImageRepeat.repeatY, //Repite en el eje y

              //Renderizado
              filterQuality: FilterQuality.medium, //low, high. la calidad de la imagen

              isAntiAlias: false, //Sin suavizado de bordes

              semanticLabel: 'Descripcion imagen', //accesibilidad

              //Manejo de errores
              errorBuilder: (context, error, stackTrace) {
                return Placeholder();
              },
            ),
            SizedBox(
              height: 20,
            ),
            //Imagenes desde la red.
            Image.network(
              'https://www.sdpnoticias.com/resizer/v2/ZTJEY7FNDROU5IKDBNVKPIBMGU.jpg?smart=true&auth=4ae88efee55546562032df13dccd4f61d4571267790d7bebd77e4e2e8be0f56e&width=1440&height=810',
              height: 200,
              width: 200,
              fit: BoxFit.cover,

              //Indicador carga
              loadingBuilder: (context, child, loadingProgress) {
                if(loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(),
                );
              },

              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 200,
                  width: 200,
                  color: Colors.grey[300],
                  child: Icon(Icons.error_outline),
                );
              },
              cacheHeight: 300, //cache con altura maxima de 300
              cacheWidth: 300, //cache con ancho maximo de 300

              //headers: {Autorization: "BakerToken"}
            ),
            SizedBox(
              height: 20,
            ),

            //Codigos qr con flutter
            //Libreria qr_flutter
            QrImageView(
              data: 'https://google.com',
              version: QrVersions.auto,
              size: 200.0,
              backgroundColor: Colors.orange,
            ),

            SizedBox(
              height: 20,
            ),

            CircleAvatar(
              radius: 100,
              backgroundImage: AssetImage('assets/images/placeholder.png'),
            ),

            SizedBox(
              height: 20,
            ),

            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset('assets/images/producto.png', width: 150, height: 150,fit: BoxFit.cover,),
            ),

            SizedBox(
              height: 20,
            ),

            ClipOval(
              child: Image.asset('assets/images/producto.png', width: 150, height: 150,fit: BoxFit.cover,),
            ),

            SizedBox(
              height: 20,
            ),

            //Container con boxdecoration
            Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(color: Colors.black.withAlpha(50), blurRadius: 10)
                ],
                image: DecorationImage(image: AssetImage('assets/images/avatar.png'),
                fit: BoxFit.cover)
              ),
            ),

            SizedBox(
              height: 20,
            ),

            //Iconodesde una imagen
            ImageIcon( //No funciona por algun motivo
              AssetImage('assets/images/avatar.png'),
              size: 80,
              color: Colors.blueAccent,
            ),

            Stack(
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  height: 150,
                  width: 150,
                  fit: .cover,
                ),
                Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(100)
                  ),
                  child: Center(child: Text("Overlay", style: TextStyle(color: Colors.white, fontSize: 20)),),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}