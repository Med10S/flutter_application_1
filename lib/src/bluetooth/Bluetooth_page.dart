import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/src/user_interface/main_page.dart';
import 'package:flutter_application_1/utilities/dimention.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import '../admin_interface/updateData.dart';
import '../authentification/controllers/profil_controller.dart';
import '../authentification/models/user_model.dart';
import '../repository/user_repository/user_repository.dart';

class BluetoothPage extends StatefulWidget {
  final String desiredAddress;
  final String poubelleNum;
  final String userid;
  final bool extraction;

  const BluetoothPage(
      {super.key,
      required this.desiredAddress,
      required this.poubelleNum,
      required this.userid,
      required this.extraction});
  @override
  _BluetoothPageState createState() => _BluetoothPageState();
}

class _BluetoothPageState extends State<BluetoothPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  // Adresse MAC de l'appareil recherché
  BluetoothConnection? connection;
  bool connected = false;
  bool searching = false;
  StreamSubscription<BluetoothDiscoveryResult>? _discoveryStreamSubscription;
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _taskCompleted = false;
  late String message;
  late String _buffer = '';
  List<String> lines = [];
  final _Update = Get.put(Updatedata());
  final userRepo = Get.put(UserRepository());

  final _db = FirebaseFirestore.instance;

  Future<String> getRoleUser() async {
    Future<dynamic> clientinfo = ProfileController().getUserData();
    UserModel user2 = await clientinfo;
    String role = user2.role!;
    return role;
  }

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
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _animation = Tween(begin: 0.0, end: 2.0 * pi).animate(_animationController);
  }

// la fonction de demande d'autorisation de connexion vers le peripherique
  Future<void> _requestBluetooth() async {
    if (_bluetoothState == BluetoothState.STATE_OFF) {
      await FlutterBluetoothSerial.instance.requestEnable();
    }
    await _requestPermission();
  }

//requestPermission to enabele bluetooth
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
      /* // Recherche des appareils Bluetooth disponibles
     List <BluetoothDevice> devices=[] ;
      _discoveryStreamSubscription =
          FlutterBluetoothSerial.instance.startDiscovery().listen((r) {
            debugPrint("devise adress is :${r.device.address}");
        if (r.device.address == widget.desiredAddress) {
          devices.add(r.device);
           // Arrêt de la recherche d'appareils
      _discoveryStreamSubscription?.cancel();    

        }
      });
       await Future.delayed(const Duration(seconds: 10));*/
      connection = await BluetoothConnection.toAddress(widget.desiredAddress);
      setState(() {
        searching = false;
        connected = true;
        sendMessage();
        _taskCompleted = true;
      });
      Future<String> role = getRoleUser();
      print("role ::$role");
      role.then((value) {
        String rolVal = value;
        print("role ::$role");
        // valeur résolue de l'ID utilisateur
        if (rolVal == "user") {
          connection!.input!.listen(_onDataReceivedUser).onDone(() {
            if (!connected) {
              print('Disconnecting locally!');
            } else {
              print('Disconnected remotely!');
            }
            if (mounted) {
              setState(() {});
            }
          });
        } else if (rolVal == "admin") {
          connection!.input!.listen(_onDataReceivedAdmin).onDone(() {
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
      });
    } catch (ex) {
      Fluttertoast.showToast(
        msg: "vous êtes trés loin...",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      Navigator.pop(context);
    }
  }

  void sendMessage() async {
    Future<dynamic>? clientinfo = ProfileController().getUserData();
    if (clientinfo != null) {
      UserModel user2 = await clientinfo;
      if (user2 != null) {
        String role = user2.role!;
        String fullName = user2.fullName;
        print("client_info$role");
        print("user_id $widget.userid");
        try {
          if (widget.userid != null) {
            String message =
                "$fullName;$role;${widget.poubelleNum.trim()};${widget.userid};${widget.extraction}";
            connection!.output
                .add(Uint8List.fromList(utf8.encode("$message\n")));
            await connection!.output.allSent;
          }
        } catch (e) {
          // Ignore error, but notify state
          Get.snackbar("erreur", "connection interempue");
          _taskCompleted = true;

          //setState(() {});
        }
      } else {
        // Handle error, clientinfo was null or getUserData() failed
      }
    } else {
      // Handle error, clientinfo was null or getUserData() failed
    }
  }

  Future<void> _onDataReceivedUser(Uint8List data) async {
    String dataString = String.fromCharCodes(data);
    _buffer += dataString;
    if (_buffer.contains('&')) {
      final message = _buffer.replaceAll('\r', '').replaceAll('\n', '');
      _buffer = '';
      Get.snackbar("Message", message,
          borderRadius: 20,
          snackPosition: SnackPosition.TOP,
          backgroundColor: const Color.fromARGB(255, 151, 255, 154),
          colorText: Colors.black);
      try {
        int points = int.parse(message.split(";")[1]);
        // Passer la valeur résolue à la classe BluetoothPage
        // Modifiez la valeur
        SharedPreferences prefs = await SharedPreferences.getInstance();
        int myIntValue = prefs.getInt('points_loacal') ??
            0; // 0 est une valeur par défaut si la clé n'existe pas
        int newResult = myIntValue + points;
        await prefs.setInt('points_loacal', newResult);
        await storeValueWithDate(points);
        await FlutterBluetoothSerial.instance
            .removeDeviceBondWithAddress(widget.desiredAddress);
        //_taskCompleted = true;

        Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (_) => const UserMainPage(),
            ));
        print("points 1:$points");
      } catch (e) {
        print("convetisement impossible");
      }
      int points = int.parse(message.split(";")[1]);
      print("points2 :$points");
    }
  }

  Future<void> storeValueWithDate(int points) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Obtenir la date actuelle
    DateTime currentDate = DateTime.now();
    // Obtenir la liste de valeurs à partir des préférences partagées
    List<Map<String, dynamic>> valueList =
        (prefs.getStringList('value_list') ?? [])
            .map((json) => Map<String, dynamic>.from(jsonDecode(json)))
            .toList();
    // Créer un nouveau Map avec la date et la valeur
    Map<String, dynamic> newValueMap = {
      'date': DateFormat('yyyy-MM-dd').format(currentDate),
      'value': points,
    };

    // Ajouter le nouveau Map à la liste
    valueList.add(newValueMap);

    // Convertir la liste en JSON
    List<String> valueListJson =
        valueList.map((map) => jsonEncode(map)).toList();

    // Enregistrer la liste mise à jour dans les préférences partagées
    await prefs.setStringList('value_list', valueListJson);
  }

  Future<void> _onDataReceivedAdmin(Uint8List data) async {
    String dataString = String.fromCharCodes(data);
    _buffer += dataString;
    print("donne dans 1:$_buffer");
    if (_buffer.contains("vide")) {
      Get.snackbar("info", "aucun client pour aujourd'hui");
      await FlutterBluetoothSerial.instance
          .removeDeviceBondWithAddress(widget.desiredAddress);
      Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (_) => const UserMainPage(),
          ));
    }
    if (_buffer.contains('\n')) {
      final message = _buffer.replaceAll('\r', '').replaceAll('\n', '');
      print(message);
      _buffer = '';
      if (widget.extraction == true) {
        Get.snackbar("Message", "extraction en cours ....",
            borderRadius: 20,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: const Color.fromARGB(255, 109, 118, 247),
            colorText: Colors.black);
        List<String> chunks = message.split("&"); // Séparer les lignes
        for (var chunk in chunks) {
          if (chunk.isNotEmpty) {
            // Vérifier que la ligne n'est pas vide
            lines.add(chunk); // Ajouter la ligne à la liste
          }
        }

/**apres que je recuper les ligne de donne depuis l'esp32
*je donne cette liste de donne a la class updateDataProgress  */

        if (lines[0] != "vide") {
          await _Update.updateDataProgress(context, lines);
          await FlutterBluetoothSerial.instance
              .removeDeviceBondWithAddress(widget.desiredAddress);
        } else {
          Get.snackbar("info", "aucun client pour aujourd'hui");
        }

        //_taskCompleted = true;

        for (int i = 0; i < lines.length; i++) {
          print("recieve${lines[i]}");
        }
        /*Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (_) => const User_Main_Page(),
              ));*/
      } else if (widget.extraction == false) {
        Get.snackbar("Message", message,
            borderRadius: 20,
            snackPosition: SnackPosition.TOP,
            backgroundColor: const Color.fromARGB(255, 151, 255, 154),
            colorText: Colors.black);

        try {
          debugPrint("points 9bele : ${message.split(";")[1]}");

          int points = int.parse(message.split(";")[1]);
          await storeValueWithDate(points);

          // Passer la valeur résolue à la classe BluetoothPage
          // Modifiez la valeur
          double quantite = double.parse(message.split(";")[3]);
          debugPrint(": ${message.split(";")[5]}");

//Bonjour mohammed vous avez recu ;12;points quatite :;2.2;poubelle:;3
          int position = int.parse(message.split(";")[5]);
          debugPrint("position $position quatite $quantite");
          _updatedata(quantite, position);
          SharedPreferences prefs = await SharedPreferences.getInstance();
          int myIntValue = prefs.getInt('points_loacal') ??
              0; // 0 est une valeur par défaut si la clé n'existe pas
          int newResult = myIntValue + points;

          await prefs.setInt('points_loacal', newResult);
          //_taskCompleted = true;

          await FlutterBluetoothSerial.instance
              .removeDeviceBondWithAddress(widget.desiredAddress);

          Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (_) => const UserMainPage(),
              ));
          print("points 1:$points");
        } catch (e) {
          print("convetisement impossible");
        }
        int points = int.parse(message.split(";")[1]);
        print("points2 :$points");
      } else {
        print("errreeeuuuurrrr");
      }
    }
  }
//-------------update des statistique --------------------

  void _updatedata(double quatite, int poubelle) async {
    Future<String> usedId = getdata_from_here();
    usedId.then((value) async {
      String userIdFinal = value;
      //debugPrint('user id : $userIdFinal');
// valeur résolue de l'ID utilisateur
      await userRepo.createStatsCollection(userIdFinal, quatite, poubelle);
    });
  }

  Future<String> getdata_from_here() async {
    Future<dynamic> clientinfo = ProfileController().getUserData();
    UserModel user2 = await clientinfo;
    String id = user2.id!;
    // print("user id is :$id");
    return id;
  }
//--------------------------------------------------------------------------------------

  @override
  Future<void> dispose() async {
    connection?.dispose();
    _discoveryStreamSubscription
        ?.cancel(); // Annuler la recherche des appareils Bluetooth
    _animationController.dispose(); // Disposer du AnimationController ici.

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
                  title: const Text('Tâche en cours'),
                  content: const Text(
                      'Veuillez attendre que la tâche soit terminée.'),
                  actions: [
                    ElevatedButton(
                      child: const Text('OK'),
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
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "searching...".toUpperCase(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              height: 300,
                              width: 300,
                              child: AnimatedBuilder(
                                animation: _animation,
                                builder: (context, child) {
                                  return CustomPaint(
                                    painter: ColorCirclePainter(
                                      animationValue: _animation.value,
                                      startColor: Colors.green,
                                      endColor: const Color.fromARGB(
                                          255, 39, 180, 223),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Image.asset(
                              'images/bluetooth(1).png',
                              scale: 4,
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                : connected
                    ? Dialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                        backgroundColor: Theme.of(context).primaryColor,
                        child: contentBox(context),
                      )
                    : Text(
                        'Recherche de l\'appareil Bluetooth avec l\'adresse ${widget.desiredAddress}'),
          ),
        ));
  }
}

contentBox(context) {
  return Stack(
    children: <Widget>[
      Container(
          padding: const EdgeInsets.only(
            top: 16,
            bottom: 16,
            left: 16,
            right: 16,
          ),
          margin: const EdgeInsets.only(top: 50),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: Offset(0.0, 10.0),
              ),
            ],
          ),
          child: const Text(
            "connection avec succé",
            textAlign: TextAlign.center,
          )),
      Positioned(
        top: -Dimenssion.height32dp,
        left: 16,
        right: 16,
        child: const CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 60,
          child: ClipRRect(
            child: Icon(
              Icons.check_circle,
              color: Colors.blue,
            ),
          ),
        ),
      ),
    ],
  );
}

class ColorCirclePainter extends CustomPainter {
  final double animationValue;
  final Color startColor;
  final Color endColor;

  ColorCirclePainter({
    required this.animationValue,
    required this.startColor,
    required this.endColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final radius = min(centerX, centerY) * 1.5;

    final startColorOpacity = (1 - animationValue / (2 * pi)).clamp(0.0, 1.0);
    final endColorOpacity = (0.5 - animationValue / (2 * pi)).clamp(0.0, 1.0);

    final startColorWithOpacity = startColor.withOpacity(startColorOpacity);
    final endColorWithOpacity = endColor.withOpacity(endColorOpacity);

    final gradient = RadialGradient(
      colors: [startColorWithOpacity, endColorWithOpacity],
    );

    final rect =
        Rect.fromCircle(center: Offset(centerX, centerY), radius: radius);

    final paint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(centerX, centerY), radius, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
