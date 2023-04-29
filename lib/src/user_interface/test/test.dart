import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';




class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  StreamSubscription? subscription;

  List<BluetoothDevice> devices = [];

  @override
  void initState() {
    super.initState();
    subscription = flutterBlue.scan().listen((scanResult) {
      if (!devices.contains(scanResult.device)) {
        setState(() {
          devices.add(scanResult.device);
        });
      }
    });
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bluetooth Example"),
      ),
      body: ListView.builder(
        itemCount: devices.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(devices[index].name),
            subtitle: Text(devices[index].id.toString()),
            onTap: () {
              connectToDevice(devices[index]);
            },
          );
        },
      ),
    );
  }

  Future<void> connectToDevice(BluetoothDevice device) async {
    await device.connect();
    await device.discoverServices();
    // Code pour synchroniser les messages entre les deux appareils
  }
}