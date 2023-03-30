import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/colors/colors.dart';
import 'package:flutter_application_1/utilities/router.dart';
import 'package:flutter_application_1/utilities/routes.dart';
import 'package:flutter_application_1/view/fist_pages/page1.dart';
import 'package:flutter_application_1/view/fist_pages/pageDePassage.dart';
import 'package:flutter_application_1/view/user_interface/main_page.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
 // mohammed sbihi
  //pour changer la couleur le la bar de notification de la même couleur de notre théme
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color.fromRGBO(47, 103, 23, 1)));
  // WidgetsFlutterBinding.ensureInitialized();
  //debugPaintSizeEnabled = true;
  runApp(const MyApp());
}
//tesr245
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFE5E5E5),
        primaryColor: Color.fromRGBO(247, 191, 95, 1),
        inputDecorationTheme: InputDecorationTheme(
          
            labelStyle: Theme.of(context).textTheme.labelLarge,
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide:
                    const BorderSide(color: Color.fromRGBO(47, 103, 23, 1))),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide:
                    const BorderSide(color: Color.fromRGBO(47, 103, 23, 1))),
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide:
                    const BorderSide(color: Color.fromRGBO(47, 103, 23, 1)))),
      ),
      home: MyScreen(),
    );
  }
}
