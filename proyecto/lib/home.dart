import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
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

  Future<void> leer() async{
    NfcAvailability availability = await NfcManager.instance.checkAvailability();

    if (availability != NfcAvailability.enabled) {
      setState(() {
        texto = 'NFC may not be supported or may be temporarily disabled.';
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
            var rawData = message!.records.first.payload; 
            String textData = String.fromCharCodes(rawData); 
            texto = textData.substring(3); 
          } else {
            if(ndef.toString().contains("NdefPlatformAndroid")) {
              texto = "null";
            } else {
              texto = ndef.toString();
            }
          } 
        });
      } else {
        setState(() {
          texto = ndef.toString();
        });
      }
      NfcManager.instance.stopSession();
      }
    );
  }

  Future<void> escribir() async {
    final text = "Pruebas 1";
    NfcAvailability availability = await NfcManager.instance.checkAvailability();

    if (availability != NfcAvailability.enabled) {
      setState(() {
        texto = 'NFC may not be supported or may be temporarily disabled.';
      });
      return;
    }
    await NfcManager.instance.startSession(
      pollingOptions: {NfcPollingOption.iso14443},
      onDiscovered: (NfcTag tag) async {
        try {
          final ndef = Ndef.from(tag);
          if (ndef == null) {
            throw Exception('This tag does not support NDEF');
          }
          if (!ndef.isWritable) {
            throw Exception('This tag is not writable');
          }

          // Build an NDEF Text Record (type 'T') using NFC Forum Text RTD
          final languageCode = 'en';
          final langBytes = utf8.encode(languageCode);
          final textBytes = utf8.encode(text);
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
            Text("prueba"),
            Text(texto),
            ElevatedButton(onPressed: leer, child: Text("Leer")),
            ElevatedButton(onPressed: escribir, child: Text("Escribir")),
          ],
        ),
      ),
    );
  }
}