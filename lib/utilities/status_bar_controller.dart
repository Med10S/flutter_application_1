import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Statusbarcontroller{
  Future<Brightness> getPlatformBrightness() async {
    Brightness brightness;
    try {
      brightness = WidgetsBinding.instance.window.platformBrightness;
    } on PlatformException {
      brightness = Brightness.light;
    }
    return brightness;
  }

  void setStatusBarColor(Brightness platformBrightness,Color light,Color dark){
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: platformBrightness,
        statusBarColor: platformBrightness == Brightness.dark
            ? dark // Couleur de la barre d'état en mode nuit
            : light, // Couleur de la barre d'état en mode jour
      ),
    );
  }
}