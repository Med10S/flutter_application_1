import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/firebase_options.dart';
import 'package:flutter_application_1/src/fist_pages/pageDePassage.dart';
import 'package:flutter_application_1/src/repository/authentification_repository/authentification_repository.dart';
import 'package:flutter_application_1/utilities/routes_router/router.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) => Get.put(AuthentificationRepository()));
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      onGenerateRoute: onGenerate,
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData(
          canvasColor: const Color.fromRGBO(14, 77, 89, 1),
          brightness: Brightness.dark,
          primaryColorDark: const Color.fromARGB(255, 194, 194, 194),
          primaryColor: const Color.fromRGBO(26, 98, 114, 1),
          cardColor: const Color.fromRGBO(14, 77, 89, 1)),
      themeMode: ThemeMode.system,
      theme: ThemeData(
        brightness: Brightness.light,
        canvasColor: const Color.fromARGB(255, 236, 236, 236),
        scaffoldBackgroundColor: const Color(0xFFE5E5E5),
        primaryColor: const Color.fromRGBO(47, 103, 23, 1),
        primaryColorDark: const Color.fromARGB(255, 216, 216, 216),
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
      home: const MyScreen(),
    );
  }
}
