import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/src/adulte_pages/pollution/nature_pollution/nature.dart';
import 'package:flutter_application_1/src/adulte_pages/recyclage/duree_recyclage.dart';
import 'package:flutter_application_1/src/adulte_pages/recyclage/poubelle.dart';
import 'package:flutter_application_1/src/adulte_pages/recyclage/whyRecycle.dart';
import 'package:flutter_application_1/src/user_interface/main_page.dart';
import 'package:flutter_application_1/utilities/routes_router/routes.dart';

import '../../src/Apropos_Pages/pageDePassage.dart';
import '../../src/adulte_pages/first_page.dart';
import '../../src/adulte_pages/pollution/sourse_pollution/Sources.dart';
import '../../src/adulte_pages/pollution/definition/definition.dart';
import '../../src/adulte_pages/pollution/type_pollution/types.dart';
import '../../src/adulte_pages/recyclage/3R.dart';
import '../../src/adulte_pages/recyclage/definiton_R/definition.dart';
import '../../src/adulte_pages/recyclage/logo.dart';
import '../../src/user_interface/code_scanner.dart';

Route<dynamic> onGenerate(RouteSettings settings) {
  switch (settings.name) {
  //------------------pollution-----------------------
    case AppRoutes.defintionPollution:
      return CupertinoPageRoute(builder: (_) => const definitionPolution());
    case AppRoutes.naturePollution:
      return CupertinoPageRoute(builder: (_) => const naturePollution());
    case AppRoutes.sourcePolution:
      return CupertinoPageRoute(builder: (_) => const Sources());
    case AppRoutes.typePolution:
      return CupertinoPageRoute(builder: (_) => const TypesPollution());
  //------------------recyclage-----------------------
    case AppRoutes.defintionREcyclage:
      return CupertinoPageRoute(builder: (_) => const DefRecyclage());
    case AppRoutes.recyclage_3R:
      return CupertinoPageRoute(builder: (_) => const R_3());
    case AppRoutes.logoRecyclage:
      return CupertinoPageRoute(builder: (_) => LogoRecyclage());
    case AppRoutes.poubelle:
      return CupertinoPageRoute(builder: (_) => const PoubelleRecyclage());
    case AppRoutes.dureeRecyclage:
      return CupertinoPageRoute(builder: (_) => const DureeRecyclage());
    case AppRoutes.whyRecyclage:
      return CupertinoPageRoute(builder: (_) => const WhyRecyclage());
    case AppRoutes.mainuserpage:
      return CupertinoPageRoute(builder: (_) => const User_Main_Page());
    case AppRoutes.apropos:
      return CupertinoPageRoute(builder: (_) =>  Apropos());
    case AppRoutes.education:
      return CupertinoPageRoute(builder: (_) => const Education());
    
    default:
      return CupertinoPageRoute(
        builder: (_) => const Education(),
      );
  }
}