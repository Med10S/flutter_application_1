
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../view/fist_pages/page1.dart';
import '../../view/fist_pages/page2.dart';
import '../../view/fist_pages/page3.dart';
import 'routes.dart';

Route<dynamic> onGenerate(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.page2Routes:
      return CupertinoPageRoute(builder: (_) => const Page2(),);
    case AppRoutes.page3Routes:
      return CupertinoPageRoute(builder: (_) => const Page3(),);
       case AppRoutes.page1Routes:
    default:
      return CupertinoPageRoute(builder: (_) => Page1());
    
  }
}
