import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:get/get.dart';

import './BluetoothDeviceListEntry.dart';

class DiscoveryPage extends StatefulWidget {
  /// If true, discovery starts on page start, otherwise user must press action button.
  final bool start;

  const DiscoveryPage({this.start = true});

  @override
  _DiscoveryPage createState() => new _DiscoveryPage();
}

class _DiscoveryPage extends State<DiscoveryPage> {
  StreamSubscription<BluetoothDiscoveryResult>? _streamSubscription;
  List<BluetoothDiscoveryResult> results =
      List<BluetoothDiscoveryResult>.empty(growable: true);
  bool isDiscovering = false;

  _DiscoveryPage();

  @override
  void initState() {
    super.initState();

    isDiscovering = widget.start;
    if (isDiscovering) {
      _startDiscovery("78:21:84:A0:19:CE");
    }
  }

  void _restartDiscovery() {
    setState(() {
      results.clear();
      isDiscovering = true;
    });

    _startDiscovery("78:21:84:A0:19:CE");
  }

  void _startDiscovery(String address) {
    _streamSubscription =
        FlutterBluetoothSerial.instance.startDiscovery().listen((r) {
      setState(() {
        if (r.device.address == address) {
          results.add(r);
          if (results.isNotEmpty) {
            _connectAuto();
          }
        } else {
          Get.snackbar("connection",
              "vous ete tres loi de la poubelle si le probleme percicte contact l'admin");
        }
      });
    });

    _streamSubscription!.onDone(() {
      setState(() {
        isDiscovering = false;
      });
    });
  }

  Future<void> _connectAuto() async {
    BluetoothDiscoveryResult result = results[0];
    final device = result.device;
    final address = device.address;
    try {
      bool bonded = false;
      if (device.isBonded) {
        print('Unbonding from ${device.address}...');
        await FlutterBluetoothSerial.instance
            .removeDeviceBondWithAddress(address);
        print('Unbonding from ${device.address} has succed');
      } else {
        print('Bonding with ${device.address}...');
        bonded = (await FlutterBluetoothSerial.instance
            .bondDeviceAtAddress(address))!;
        print(
            'Bonding with ${device.address} has ${bonded ? 'succed' : 'failed'}.');
        bonded
            ? Get.snackbar("conection reusite",
                "bien connecter a ${results[0].device.name}")
            : Get.snackbar("erreur de connection",
                "vous ete tres loi de la poubelle si le probleme percicte contact l'admin");
      }
      setState(() {
        results[results.indexOf(result)] = BluetoothDiscoveryResult(
            device: BluetoothDevice(
              name: device.name ?? '',
              address: address,
              type: device.type,
              bondState:
                  bonded ? BluetoothBondState.bonded : BluetoothBondState.none,
            ),
            rssi: result.rssi);
      });
    } catch (ex) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error occured while bonding'),
            content: Text("${ex.toString()}"),
            actions: <Widget>[
              new TextButton(
                child: new Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  // @TODO . One day there should be `_pairDevice` on long tap on something... ;)

  @override
  void dispose() {
    // Avoid memory leak (`setState` after dispose) and cancel discovery
    _streamSubscription?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: isDiscovering
              ? const Text('Discovering device')
              : const Text('Discovered device'),
          actions: <Widget>[
            isDiscovering
                ? FittedBox(
                    child: Container(
                      margin: const EdgeInsets.all(16.0),
                      child: const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                  )
                : IconButton(
                    icon: const Icon(Icons.replay),
                    onPressed: _restartDiscovery,
                  )
          ],
        ),
        body: ListView.builder(
        itemCount: results.length,
        itemBuilder: (BuildContext context, index) {
          BluetoothDiscoveryResult result = results[index];
          final device = result.device;
          final address = device.address;
          return BluetoothDeviceListEntry(
            device: device,
            rssi: result.rssi,
            onTap: () {
              Navigator.of(context).pop(result.device);
            },
            onLongPress: () async {
              try {
                bool bonded = false;
                if (device.isBonded) {
                  print('Unbonding from ${device.address}...');
                  await FlutterBluetoothSerial.instance
                      .removeDeviceBondWithAddress(address);
                  print('Unbonding from ${device.address} has succed');
                } else {
                  print('Bonding with ${device.address}...');
                  bonded = (await FlutterBluetoothSerial.instance
                      .bondDeviceAtAddress(address))!;
                  print(
                      'Bonding with ${device.address} has ${bonded ? 'succed' : 'failed'}.');
                }
                setState(() {
                  results[results.indexOf(result)] = BluetoothDiscoveryResult(
                      device: BluetoothDevice(
                        name: device.name ?? '',
                        address: address,
                        type: device.type,
                        bondState: bonded
                            ? BluetoothBondState.bonded
                            : BluetoothBondState.none,
                      ),
                      rssi: result.rssi);
                });
              } catch (ex) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Error occured while bonding'),
                      content: Text("${ex.toString()}"),
                      actions: <Widget>[
                        new TextButton(
                          child: new Text("Close"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              }
            },
          );
        },
      ),);
  }
}
