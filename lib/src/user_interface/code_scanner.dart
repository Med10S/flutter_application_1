// ignore_for_file: slash_for_doc_comments

import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/utilities/dimention.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'package:flutter/material.dart';

import '../repository/authentification_repository/authentification_repository.dart';
import '../welcome.dart';
import 'main_page.dart';

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
                    Text(textAlign:TextAlign.center,
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
                            await controller?.pauseCamera();
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

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  //modifier la fonction precedente par se code pour l'adapter a l'esp
  /**Notez que dans ce code, nous utilisons la bibliothèque WiFi
   * pour se connecter au réseau WiFi généré par ESP, 
   * et la bibliothèque http pour envoyer les données à l'ESP. 
   * Vous devrez remplacer "ESP-WIFI-SSID", 
   * "ESP-WIFI-PASSWORD" et "IP_ADDRESS" avec vos propres valeurs. */
/**
   import 'package:wifi/wifi.dart';
   void _onQRViewCreated(QRViewController controller) async {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      await Wifi.connection('ESP-WIFI-SSID', 'ESP-WIFI-PASSWORD');
      await sendUserIdToESP('USER_ID');
      controller.pauseCamera();
    });
  }

  Future<void> sendUserIdToESP(String userId) async {
    // Connexion à l'ESP en utilisant la bibliothèque http
    final response = await http.post(Uri.parse('http://IP_ADDRESS:PORT'),
        body: {'userId': userId});
    if (response.statusCode == 200) {
      // Les données ont été envoyées avec succès à l'ESP
      print('Données envoyées avec succès à l\'ESP');
    } else {
      // La connexion à l'ESP a échoué
      throw Exception('Impossible de se connecter à l\'ESP');
    }
  } 
  */
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
