import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:nfc_manager/ndef_record.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:nfc_manager_ndef/nfc_manager_ndef.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String texto = "Hola";
  String errores = "Errores";
  late TextEditingController mandar;
  late TextEditingController tipo;

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

  Future<void> leer() async{
    NfcAvailability availability = await NfcManager.instance.checkAvailability();

    if (availability != NfcAvailability.enabled) {
      setState(() {
        errores = 'NFC may not be supported or may be temporarily disabled.';
      });
      return;
    }

    // Start the session.
    NfcManager.instance.startSession(
      pollingOptions: {NfcPollingOption.iso14443},
      onDiscovered: (NfcTag tag) async {
      Ndef? ndef = Ndef.from(tag);
      if (ndef != null) {
        // Read message from tag
        NdefMessage? message = await ndef.read();
        
        setState(() {
          if(message != null) {
            var rawData = message.records;
            String textData = "";
            int longitud = rawData.length;
            if(longitud > 1) {
              for(int i = 0; i < longitud; i++) {
                textData = "Texto$i: ${String.fromCharCodes(rawData[i].payload).substring(3)}, ";
              }
            } else {
              textData = String.fromCharCodes(rawData.first.payload).substring(3);
            }
            texto = textData; 
          } else {
            if(ndef.toString().contains("NdefPlatformAndroid")) {
              texto = "null";
            } else {
              errores = ndef.toString();
            }
          } 
        });
      } else {
        setState(() {
          errores = ndef.toString();
        });
      }
      NfcManager.instance.stopSession();
      }
    );
  }

  Future<void> escribir() async {
    String text = "Prueba";
    String tipo1 = "Mensaje";
    if(mandar.text.isNotEmpty ) {
      text = mandar.text;
      mandar.clear();
    }
    if(tipo.text.isNotEmpty ) {
      tipo1 = tipo.text;
      tipo.clear();
    }
    NfcAvailability availability = await NfcManager.instance.checkAvailability();

    if (availability != NfcAvailability.enabled) {
      setState(() {
        errores = 'NFC may not be supported or may be temporarily disabled.';
      });
      return;
    }
    await NfcManager.instance.startSession(
      pollingOptions: {NfcPollingOption.iso14443},
      onDiscovered: (NfcTag tag) async {
        try {
          final ndef = Ndef.from(tag);
          if (ndef == null) {
            return;
          }
          if (!ndef.isWritable) {
            return;
          }
          String texto = "$tipo1: $text";
          final languageCode = 'es';
          final langBytes = utf8.encode(languageCode);
          final textBytes = utf8.encode(texto);
          final statusByte = langBytes.length & 0x3F;

          final payload = Uint8List.fromList([
            statusByte,
            ...langBytes,
            ...textBytes,
          ]);

          final textRecord = NdefRecord(
            typeNameFormat: TypeNameFormat.wellKnown,
            type: Uint8List.fromList('T'.codeUnits),
            identifier: Uint8List(0),
            payload: payload,
          );

          final message = NdefMessage(records: [textRecord]);
          await ndef.write(message: message);
        } finally {
          await NfcManager.instance.stopSession();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Proyecto"),
      ),
      body: Center(
        child: Column(
          children: [
            Text(errores),
            Text(texto),
            ElevatedButton(onPressed: leer, child: Text("Leer")),
            TextField(
              controller: mandar,
              decoration: InputDecoration(
                hintText: "Mensaje",
                border: OutlineInputBorder()
              ),
            ),
            TextField(
              controller: tipo,
              decoration: InputDecoration(
                hintText: "Tipo",
                border: OutlineInputBorder()
              ),
            ),
            ElevatedButton(onPressed: escribir, child: Text("Escribir")),
          ],
        ),
      ),
    );
  }
}