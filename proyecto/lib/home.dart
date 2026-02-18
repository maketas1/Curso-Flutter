import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:nfc_manager/ndef_record.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:nfc_manager_ndef/nfc_manager_ndef.dart';
import 'package:url_launcher/url_launcher.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String texto = "Esperando lectura NFC...";
  String errores = "";
  late TextEditingController mandar;
  late TextEditingController tipo;
  String url = "";

  @override
  void initState() {
    super.initState();
    mandar = TextEditingController();
    tipo = TextEditingController();
  }

  @override
  void dispose() {
    mandar.dispose();
    tipo.dispose();
    super.dispose();
  }

  // ---------------- NFC LECTURA ----------------
  Future<void> leer() async {
    final availability = await NfcManager.instance.checkAvailability();
    if (availability != NfcAvailability.enabled) {
      setState(() => errores = "NFC no disponible");
      return;
    }

    NfcManager.instance.startSession(
      pollingOptions: {NfcPollingOption.iso14443},
      onDiscovered: (NfcTag tag) async {
        final ndef = Ndef.from(tag);
        if (ndef == null) {
          setState(() => errores = "Etiqueta no compatible");
          return;
        }

        final message = await ndef.read();
        if (message == null) {
          setState(() => errores = "Etiqueta vacía");
          return;
        }

        final record = message.records.first;
        final content =
            String.fromCharCodes(record.payload).substring(3);

        if (content.toLowerCase().startsWith("enlace:")) {
          url = content.replaceFirst("enlace: ", "");
          openGoogle();
        } else {
          setState(() => texto = content);
        }

        NfcManager.instance.stopSession();
      },
    );
  }

  // ---------------- NFC ESCRITURA ----------------
  Future<void> escribir() async {
    final text = mandar.text.isEmpty ? "Prueba" : mandar.text;
    final tipo1 = tipo.text.isEmpty ? "Mensaje" : tipo.text;

    mandar.clear();
    tipo.clear();

    final availability = await NfcManager.instance.checkAvailability();
    if (availability != NfcAvailability.enabled) {
      setState(() => errores = "NFC no disponible");
      return;
    }

    await NfcManager.instance.startSession(
      pollingOptions: {NfcPollingOption.iso14443},
      onDiscovered: (NfcTag tag) async {
        try {
          final ndef = Ndef.from(tag);
          if (ndef == null || !ndef.isWritable) return;

          final textoFinal = "$tipo1: $text";
          final payload = Uint8List.fromList([
            0x02,
            ...utf8.encode('es'),
            ...utf8.encode(textoFinal),
          ]);

          final record = NdefRecord(
            typeNameFormat: TypeNameFormat.wellKnown,
            type: Uint8List.fromList('T'.codeUnits),
            identifier: Uint8List(0),
            payload: payload,
          );

          await ndef.write(message: NdefMessage(records: [record]));
          setState(() => texto = "Mensaje escrito correctamente");
        } finally {
          await NfcManager.instance.stopSession();
        }
      },
    );
  }

  Future<void> openGoogle() async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception("No se pudo abrir el enlace");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Proyecto NFC"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _infoCard(),
            const SizedBox(height: 16),
            _actionButtons(),
            const SizedBox(height: 16),
            _inputCard(),
          ],
        ),
      ),
    );
  }

  Widget _infoCard() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Estado",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(texto),
            if (errores.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                errores,
                style: const TextStyle(color: Colors.red),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _actionButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            icon: const Icon(Icons.nfc),
            label: const Text("Leer NFC"),
            onPressed: leer,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton.icon(
            icon: const Icon(Icons.edit),
            label: const Text("Escribir NFC"),
            onPressed: escribir,
          ),
        ),
      ],
    );
  }

  Widget _inputCard() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: mandar,
              decoration: const InputDecoration(
                labelText: "Mensaje",
                prefixIcon: Icon(Icons.message),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: tipo,
              decoration: const InputDecoration(
                labelText: "Tipo",
                prefixIcon: Icon(Icons.category),
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}