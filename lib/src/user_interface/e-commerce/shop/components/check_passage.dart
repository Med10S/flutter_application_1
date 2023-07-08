import 'package:flutter/material.dart';
import 'package:flutter_application_1/utilities/dimention.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class CustomPopup {
  static Future<void> show(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Lieu de livraison',
            textAlign: TextAlign.center,
          ),
          content: Container(
            height: Dimenssion.height40dp,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    InkWell(
                      onTap: () async {
                        if (await _requestPermission()) {
                          Position position =
                              await Geolocator.getCurrentPosition(
                            desiredAccuracy: LocationAccuracy.high,
                          );
                          print('Latitude: ${position.latitude}');
                          print('Longitude: ${position.longitude}');
                        } else {
                          print(
                              'L\'autorisation d\'accès à la localisation a été refusée.');
                        }
                      },
                      child: Icon(
                        Icons.gps_fixed,
                        color: Colors.blue,
                      ),
                    ),
                    Text('automatique')
                  ],
                ),
                Column(
                  children: [
                    InkWell(
                      child: Icon(
                        Icons.edit,
                        color: Colors.blue,
                      ),
                    ),
                    Text('manuel')
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  static Future<bool> _requestPermission() async {
    PermissionStatus status = await Permission.location.request();
    return status == PermissionStatus.granted;
  }
}
