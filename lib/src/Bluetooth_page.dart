import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/src/repository/authentification_repository/authentification_repository.dart';
import 'package:flutter_application_1/src/repository/user_repository/user_repository.dart';
import 'package:flutter_application_1/src/user_interface/main_page.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utilities/changeNotifier.dart';
import 'authentification/controllers/profil_controller.dart';
import 'authentification/models/user_model.dart';

class BluetoothPage extends StatefulWidget {
  final String desiredAddress;
  final String Scandata;
  final String userid;

  const BluetoothPage(
      {super.key,
      required this.desiredAddress,
      required this.Scandata,
      required this.userid});
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
  String _messageBuffer = '';
  late String message;
  late String _buffer = '';

  @override
  void initState() {
    super.initState();

    FlutterBluetoothSerial.instance.state.then((state) {
      if (mounted) {
        setState(() {
          _bluetoothState = state;
        });
      }
    });

    FlutterBluetoothSerial.instance.onStateChanged().listen((state) {
      if (mounted) {
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
        if (mounted) {
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
        if (r.device.address == widget.desiredAddress) {
          devices.add(r.device);
        }
      });

      // Attente de 10 secondes pour permettre la détection de l'appareil
      await Future.delayed(const Duration(seconds: 10));

      // Arrêt de la recherche d'appareils
      _discoveryStreamSubscription?.cancel();

      if (devices.isEmpty) {
        // Aucun appareil trouvé, afficher une snackbar avec un message d'erreur
        ScaffoldMessenger.of(_scaffoldKey.currentContext!)
            .showSnackBar(SnackBar(
          content: Text(
              'Aucun appareil Bluetooth trouvé avec l\'adresse ${widget.desiredAddress}'),
        ));
      } else {
        // Connexion à l'appareil trouvé
        connection = await BluetoothConnection.toAddress(widget.desiredAddress);
        setState(() {
          searching = false;
          connected = true;
          _taskCompleted = true;
          // Future<String?> userId2 = getdata_from_here();
          //String?  user_id_utlisable = await userId2;
          _sendMessage();
        });

        connection!.input!.listen(_onDataReceived).onDone(() {
          if (!connected) {
            print('Disconnecting locally!');
          } else {
            print('Disconnected remotely!');
          }
          if (mounted) {
            setState(() {});
          }
        });
      }
    } catch (ex) {
      // Erreur lors de la connexion, afficher une snackbar avec un message d'erreur
      /*ScaffoldMessenger.of(_scaffoldKey.currentContext!).showSnackBar(SnackBar(
        content: Text('Erreur de connexion Bluetooth: $ex'),
      ));*/
      connectToDevice();

    }
  }

  void _sendMessage() async {
    Future<dynamic>? clientinfo = ProfileController().getUserData();
    if (clientinfo != null) {
      UserModel user2 = await clientinfo;
      if (user2 != null) {
        String role = user2.role;
        String fullName = user2.fullName;
        print("client_info$role");
        print("user_id $widget.userid");
        try {
          if (widget.userid != null) {
            String message =
                "$fullName;$role;${widget.Scandata};${widget.userid}";
            connection!.output
                .add(Uint8List.fromList(utf8.encode("$message\r\n")));
            await connection!.output.allSent;
          }
        } catch (e) {
          // Ignore error, but notify state
          Get.snackbar("erreur", "connection interempue");
          //setState(() {});
        }
      } else {
        // Handle error, clientinfo was null or getUserData() failed
      }
    } else {
      // Handle error, clientinfo was null or getUserData() failed
    }
  }

  Future<void> _onDataReceived(Uint8List data) async {
    String dataString = String.fromCharCodes(data);
    _buffer += dataString;
    if (_buffer.contains('\n')) {
      final message = _buffer.replaceAll('\r', '').replaceAll('\n', '');
      _buffer = '';
      Get.snackbar("Message", message,
          borderRadius: 20,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Color.fromARGB(255, 151, 255, 154),
          colorText: Colors.black);
      try {
        
          int points = int.parse(message.split(";")[1]);
          // Passer la valeur résolue à la classe BluetoothPage
          // Modifiez la valeur
          SharedPreferences prefs = await SharedPreferences.getInstance();
          int myIntValue = prefs.getInt('points_loacal') ?? 0; // 0 est une valeur par défaut si la clé n'existe pas
          int new_result = myIntValue+points;
          await prefs.setInt('points_loacal', new_result);
          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (_) => const User_Main_Page(),
                            ));
          print("points 1:$points");
         
        
      } catch (e) {
        print("convetisement impossible");
      }
      int points = int.parse(message.split(";")[1]);
      print("points2 :$points");
    }
  }

  late void Function(int) onPointsUpdated;

  // Cette fonction doit être appelée lorsque la valeur des points est mise à jour

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
                  content:
                      Text('Veuillez attendre que la tâche soit terminée.'),
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
        },
        child: Scaffold(
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

class ESP32 {}
