import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/src/adulte_pages/pollution/nature.dart';
import 'package:flutter_application_1/src/adulte_pages/recyclage/duree_recyclage.dart';
import 'package:flutter_application_1/src/adulte_pages/recyclage/poubelle.dart';
import 'package:flutter_application_1/src/adulte_pages/recyclage/whyRecycle.dart';
import 'package:flutter_application_1/utilities/routes_router/routes.dart';

import '../../src/adulte_pages/first_page.dart';
import '../../src/adulte_pages/pollution/Sources.dart';
import '../../src/adulte_pages/pollution/definition.dart';
import '../../src/adulte_pages/pollution/types.dart';
import '../../src/adulte_pages/recyclage/3R.dart';
import '../../src/adulte_pages/recyclage/definition.dart';
import '../../src/adulte_pages/recyclage/logo.dart';

Route<dynamic> onGenerate(RouteSettings settings) {
  switch (settings.name) {
  //------------------pollution-----------------------
    case AppRoutes.defintionPollution:
      return CupertinoPageRoute(builder: (_) => const definitionPolution());
    case AppRoutes.naturePollution:
      return CupertinoPageRoute(builder: (_) => const naturePollution());
    case AppRoutes.sourcePolution:
      return CupertinoPageRoute(builder: (_) => const sources());
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
      return CupertinoPageRoute(builder: (_) => const Poubelle());
    case AppRoutes.dureeRecyclage:
      return CupertinoPageRoute(builder: (_) => const DureeRecyclage());
    case AppRoutes.whyRecyclage:
      return CupertinoPageRoute(builder: (_) => const WhyRecyclage());

    default:
      return CupertinoPageRoute(
        builder: (_) => const firstPage(),
      );
  }
}