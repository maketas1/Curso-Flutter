import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String prueba1 = "Hola";

  Future<void> prueba() async{
    NfcAvailability availability = await NfcManager.instance.checkAvailability();

    if (availability != NfcAvailability.enabled) {
      setState(() {
        prueba1 = 'NFC may not be supported or may be temporarily disabled.';
      });
      return;
    }

    // Start the session.
    NfcManager.instance.startSession(
      pollingOptions: {NfcPollingOption.iso14443}, // You can also specify iso18092 and iso15693.
      onDiscovered: (NfcTag tag) async {
        // Do something with an NfcTag instance...
        setState(() {
          prueba1 = tag.toString();
        });

        // Stop the session when no longer needed.
        await NfcManager.instance.stopSession();
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
            Text(prueba1),
            ElevatedButton(onPressed: prueba, child: Text("Prueba")),
          ],
        ),
      ),
    );
  }
}