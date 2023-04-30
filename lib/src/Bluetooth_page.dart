import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:get/get.dart';

import 'authentification/controllers/profil_controller.dart';
import 'authentification/models/user_model.dart';

class BluetoothPage extends StatefulWidget {
  final String desiredAddress;

  const BluetoothPage({super.key, required this.desiredAddress});
  @override
  _BluetoothPageState createState() => _BluetoothPageState();
}
class _BluetoothPageState extends State<BluetoothPage> {

  // Adresse MAC de l'appareil recherché
  BluetoothConnection? connection;
  bool connected = false;
  bool searching = false;
  StreamSubscription<BluetoothDiscoveryResult>? _discoveryStreamSubscription;
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _taskCompleted = false;

  @override
  void initState() {

    super.initState();
    FlutterBluetoothSerial.instance.state.then((state) {
      if(mounted) {
        setState(() {
          _bluetoothState = state;
        });
      }
    });

    FlutterBluetoothSerial.instance.onStateChanged().listen((state) {
      if(mounted) {
        setState(() {
          _bluetoothState = state;
        });
      }
    });
    _requestBluetooth();

    connectToDevice();
    
  }

  Future<void> _requestBluetooth() async {
    if (_bluetoothState == BluetoothState.STATE_OFF) {
      await FlutterBluetoothSerial.instance.requestEnable();
    }
    await _requestPermission();
  }

  Future<bool> _requestPermission() async {
    final isGranted = await FlutterBluetoothSerial.instance.requestEnable();

    if (isGranted == null || !mounted) {
      return false;
    }

    if (isGranted) {
      return true;
    } else {
      final confirmed = await showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: const Text('Activer le Bluetooth'),
            content: const Text(
                'L\'application a besoin du Bluetooth pour fonctionner. Voulez-vous l\'activer ?'),
            actions: [
              TextButton(
                child: const Text('Non'),
                onPressed: () {
                  Navigator.of(dialogContext).pop(false);
                },
              ),
              TextButton(
                child: const Text('Oui'),
                onPressed: () {
                  Navigator.of(dialogContext).pop(true);
                },
              ),
            ],
          );
        },
      );

      if (confirmed) {
        await FlutterBluetoothSerial.instance.requestEnable();
        return true;
      } else {
        if(mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Le Bluetooth n\'est pas activé.'),
            ),
          );
        }
        return false;
      }
    }
  }

 void connectToDevice() async {
  if (!mounted) return;

  setState(() {
    searching = true;
  });

  try {
    // Recherche des appareils Bluetooth disponibles
    List<BluetoothDevice> devices = [];
    _discoveryStreamSubscription =
        FlutterBluetoothSerial.instance.startDiscovery().listen((r) {
      if (r.device.address ==widget.desiredAddress) {
        devices.add(r.device);
      }
    });

    // Attente de 10 secondes pour permettre la détection de l'appareil
    await Future.delayed(const Duration(seconds: 10));

    // Arrêt de la recherche d'appareils
    _discoveryStreamSubscription?.cancel();

    if (devices.isEmpty) {
      // Aucun appareil trouvé, afficher une snackbar avec un message d'erreur
      ScaffoldMessenger.of(_scaffoldKey.currentContext!).showSnackBar(SnackBar(
        content: Text(
            'Aucun appareil Bluetooth trouvé avec l\'adresse ${widget.desiredAddress}'),
      ));
    } else {
      // Connexion à l'appareil trouvé
      connection = await BluetoothConnection.toAddress(widget.desiredAddress);
      setState(() {
        searching = false;
        connected = true;
        _taskCompleted=true;
      
      _sendMessage("hello from here");

      });
    }
  } catch (ex) {
    // Erreur lors de la connexion, afficher une snackbar avec un message d'erreur
    ScaffoldMessenger.of(_scaffoldKey.currentContext!).showSnackBar(SnackBar(
      content: Text('Erreur de connexion Bluetooth: $ex'),
    ));
  }
}

void _sendMessage(String text) async {
    text = text.trim();

    if (text.length > 0) {
      try {
        connection!.output.add(Uint8List.fromList(utf8.encode(text + "\r\n")));
        await connection!.output.allSent;

      } catch (e) {
        // Ignore error, but notify state
        setState(() {});
      }
    }
  }

  @override
  void dispose() {
    connection?.dispose();
    _discoveryStreamSubscription
        ?.cancel(); // Annuler la recherche des appareils Bluetooth

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (!_taskCompleted) {
          // Afficher une boîte de dialogue pour informer l'utilisateur que la tâche est en cours
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Tâche en cours'),
                content: Text('Veuillez attendre que la tâche soit terminée.'),
                actions: [
                  ElevatedButton(
                    child: Text('OK'),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              );
            },
          );
        }

        // Retourner true si la tâche est terminée, false sinon
        return _taskCompleted;
      }, child: Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: const Text('Bluetooth')),

      body: Center(
        child: searching
            ? const CircularProgressIndicator()
            : connected
                ? Text(
                    'Connecté à l\'appareil Bluetooth avec l\'adresse ${widget.desiredAddress}')
                : Text(
                    'Recherche de l\'appareil Bluetooth avec l\'adresse ${widget.desiredAddress}'),
      ),
    ));
  }
}
