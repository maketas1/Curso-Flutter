import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

//https://medium.com/@mjbsit1/open-whatsapp-directly-from-flutter-using-a-phone-number-message-3f1e9d01a009

class Paso2Llamada extends StatelessWidget {
  const Paso2Llamada({super.key});

  Future<void> enviarWhatsApp() async {
    const String numero = "34675070417"; // Cambia por el número con código país
    const String mensaje = "Este es un mensaje enviado desde mi app Flutter";

    final Uri url = Uri.parse(
        "https://wa.me/$numero?text=${Uri.encodeComponent(mensaje)}");

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw "No se pudo abrir WhatsApp";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          FloatingActionButton(
            onPressed: enviarWhatsApp,
            child: const Text(
              "Enviar mensaje",
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
    );
  }
}