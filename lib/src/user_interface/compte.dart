import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_application_1/utilities/dimention.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../main.dart';

class compte extends StatelessWidget {
  const compte({super.key});

  @override
  Widget build(BuildContext context) {

    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return  Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {}, icon: const Icon(LineAwesomeIcons.angle_left)),
            title: Text(
              "Profile",
              style: Theme.of(context).textTheme.headlineSmall,
            )
          ),
          body: SingleChildScrollView(
            child: Container(
                color: Theme.of(context).primaryColor,
                padding: const EdgeInsets.all(10),
                child: Column(
              children: [SizedBox(height: Dimenssio.height250dp,width: Dimenssio.width250dp/2,)

              ],
            )),
          ),
        );
  }
    
  
}
