import 'package:flutter/material.dart';
import 'package:flutter_application_1/utilities/dimention.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class CustomPopup {
  static Future<String?> show(BuildContext context) async {
    String? location;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Lieu de livraison',
            textAlign: TextAlign.center,
          ),
          content: SizedBox(
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
                          location =
                              "${position.latitude};${position.longitude}";
                          Navigator.of(context).pop();
                        } else {
                          debugPrint(
                              'L\'autorisation d\'accès à la localisation a été refusée.');
                        }
                      },
                      child: const Icon(
                        Icons.gps_fixed,
                        color: Colors.blue,
                      ),
                    ),
                    const Text('automatique')
                  ],
                ),
                const Column(
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
    return location;
  }

  static Future<bool> _requestPermission() async {
    PermissionStatus status = await Permission.location.request();
    return status == PermissionStatus.granted;
  }
}
