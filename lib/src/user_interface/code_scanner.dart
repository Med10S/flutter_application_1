// ignore_for_file: slash_for_doc_comments

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/utilities/dimention.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../repository/authentification_repository/authentification_repository.dart';
import 'main_page.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:connectivity/connectivity.dart';

class QRScan extends StatefulWidget {
  const QRScan({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRScanState();
}

class _QRScanState extends State<QRScan> {
  Barcode? result;
  String? wifiSSID;
  String? wifiPassword;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  var _isSucceed = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
            onPressed: () async {
              await controller?.toggleFlash();
              setState(() {});
            },
            backgroundColor: Theme.of(context).primaryColor,
            child: FutureBuilder(
              future: controller?.getFlashStatus(),
              builder: (context, snapshot) {
                return InkWell(
                    child: Image.asset(
                  snapshot.data == true
                      ? "images/flash_on.png"
                      : "images/no-flash.png",
                  height: 40,
                  color: const Color.fromRGBO(230, 198, 84, 1),
                ));
              },
            )),
        bottomNavigationBar: BottomAppBar(
          notchMargin: 5,
          shape: const CircularNotchedRectangle(),
          color: Theme.of(context).primaryColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (_) => User_Main_Page(),
                              ));
                        },
                        child: Image.asset("images/home.png")),
                    const Text(
                      "home",
                      style: TextStyle(color: Color.fromRGBO(230, 198, 84, 1)),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20, top: 10, bottom: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset("images/chart.png"),
                    const Text(
                      "Statistique",
                      style: TextStyle(color: Color.fromRGBO(230, 198, 84, 1)),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset("images/info_client.png"),
                    const Text(
                      "Compte",
                      style: TextStyle(color: Color.fromRGBO(230, 198, 84, 1)),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                        onTap: () {
                          AuthentificationRepository.instance.logout();
                        },
                        child: Image.asset("images/EXIT.png")),
                    const Text(
                      "Sortir",
                      style: TextStyle(color: Color.fromRGBO(230, 198, 84, 1)),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        body: Column(
          children: <Widget>[
            Image.asset('images/logo.png'),
            Expanded(flex: 3, child: _buildQrView(context)),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  if (result != null)
                    Text(
                      textAlign: TextAlign.center,
                      'wifiSSID ${result!.code!.split(';')[0].substring(5)},\npassword ${result!.code!.split(';')[1].substring(4)}\npoubelle ${result!.code!.split(';')[2].substring(9)}',
                    )
                  else
                    const Text('Scan a code'),
                  Container(
                    padding: EdgeInsets.all(Dimenssion.height20dp),
                    width: Dimenssion.screenWidth,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        InkWell(
                          onTap: () async {
                             
                           // await controller?.pauseCamera();
                          },
                          child: Image.asset('images/pause.png',
                              height: Dimenssion.height5dp * 5),
                        ),
                        InkWell(
                          onTap: () async {
                            await controller?.resumeCamera();
                          },
                          child: Image.asset(
                            'images/resume.png',
                            height: Dimenssion.height5dp * 5,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = Dimenssion.FirstPagesImageHeight;
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 20,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

 /* void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }*/

  

  //modifier la fonction precedente par se code pour l'adapter a l'esp
  /**Notez que dans ce code, nous utilisons la bibliothèque WiFi
   * pour se connecter au réseau WiFi généré par ESP, 
   * et la bibliothèque http pour envoyer les données à l'ESP. 
   * Vous devrez remplacer "ESP-WIFI-SSID", 
   * "ESP-WIFI-PASSWORD" et "IP_ADDRESS" avec vos propres valeurs. */

  void _onQRViewCreated(QRViewController controller) async {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      String ESP_WIFI_SSID = scanData.code!.split(';')[0].substring(5);
      String ESPWIFIPASSWORD = scanData.code!.split(';')[1].substring(4);
      String USER_ID = "Admin";
      print("ESP_WIFI_SSID " +
          ESP_WIFI_SSID +
          " ESPWIFIPASSWORD " +
          ESPWIFIPASSWORD); //mzn
     /* setState(() => _isSucceed = false);
     final isSucceed = await WifiConnector.connectToWifi(
          ssid: ESP_WIFI_SSID, password: ESPWIFIPASSWORD);
      setState(() => _isSucceed = isSucceed);*/

       // Appel de la méthode _sendData() avec await
      //controller.pauseCamera();
    });
  }

void sendData(String message) async {
  const ipAddress = '192.168.4.1'; // Adresse IP de votre ESP32
  final socket = await Socket.connect(ipAddress, 80);

  final request = 'POST /message HTTP/1.1\r\n'
      'Host: $ipAddress\r\n'
      'Content-Type: application/json\r\n'
      'Content-Length: ${utf8.encode(message).length}\r\n'
      '\r\n'
      '${json.encode({'message': message})}';

  socket.write(request);

  final completer = Completer<String>();
  socket.listen((data) {
    final response = utf8.decode(data);
    completer.complete(response);
    socket.destroy();
  }, onError: (error) {
    completer.completeError(error);
    socket.destroy();
  });

  final response = await completer.future;
  print(response);
}





 /* Future<void> sendData(String data) async {
    var url = Uri.parse(
        'http://192.168.1.100:80'); // Replace with your ESP32 device IP address and port
    var response = await http.post(url, body: json.encode({'data': data}));
    if (response.statusCode == 200) {
      print('Data sent successfully.');
    } else {
      print('Failed to send data. Error code: ${response.statusCode}');
    }
  }*/

 /* Future<void> _sendData() async {
    // Vérification de la connexion Wi-Fi
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.wifi) {
      // Si l'appareil n'est pas connecté au Wi-Fi, affichez un message d'erreur
      print('Veuillez vous connecter au réseau Wi-Fi de l\'ESP32.');
      return;
    }

    // Envoi des données à l'ESP32
    final url = Uri.parse('http://192.168.4.1/data');
    final request = http.Request('POST', url);
    request.headers['Content-Type'] = 'application/x-www-form-urlencoded';
    request.bodyFields = {'message': 'Bonjour'}; // Corps de la requête
    final response = await request.send();
    print('Status code: ${response.statusCode}');
    final responseText = await response.stream.bytesToString();
    Get.snackbar(
        "Status code: ${response.statusCode}", "Response body: $responseText");
  }*/

  /*Future<void> sendUserIdToESP(String userId) async {
    // Connectez-vous au réseau WiFi de l'ESP32

    // Adresse IP de l'ESP32
    const String ipAddress = '192.168.4.1';
    // Port à utiliser pour la communication
    const int port = 80;
    // URL pour envoyer les données
    const String url = 'http://$ipAddress:$port';

    // Connexion à l'ESP en utilisant la bibliothèque http
    final response = await http.post(Uri.parse(url), body: {'userId': userId});
    if (response.statusCode == 200) {
      // Les données ont été envoyées avec succès à l'ESP
      print('Données envoyées avec succès à l\'ESP');
      Get.snackbar("conection", 'Données envoyées avec succès à l\'ESP');
    } else {
      // La connexion à l'ESP a échoué
      print('Impossible de se connecter à l\'ESP');
      //throw Exception('Impossible de se connecter à l\'ESP');
    }

    // Déconnectez-vous du réseau WiFi de l'ESP32
  }*/

  /* Future<void> sendUserIdToESP(String userId) async {
    // Connexion à l'ESP en utilisant la bibliothèque http
    final response = await http.post(Uri.parse('http://IP_ADDRESS:PORT'),
        body: {'userId': userId});
    if (response.statusCode == 200) {
      // Les données ont été envoyées avec succès à l'ESP
      print('Données envoyées avec succès à l\'ESP');
    } else {
      // La connexion à l'ESP a échoué
      print('Impossible de se connecter à l\'ESP');
      //throw Exception('Impossible de se connecter à l\'ESP');
    }
  } */

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
