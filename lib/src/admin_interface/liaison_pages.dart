import 'package:flutter/material.dart';
import 'package:flutter_application_1/utilities/dimention.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../widgets/botton.dart';

class LiaisonPages extends StatelessWidget {
  const LiaisonPages({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Theme.of(context).cardColor, body: corp(context)));
  }

  Widget corp(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: Dimenssion.height20dp / 2),
          height: Dimenssion.height55dp,
          decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
            ),
          ),
          child: Container(
            width: Dimenssion.screenWidth,
            alignment: Alignment.center,
            child: Text(
              "Hello Admin",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: Dimenssion.width16dp * 1.5,
              ),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(4.0),
          child: CustomButton(
            text: "Tout les statistiques",
            root: "/AllDataLevel",
            widget: Icon(
              FontAwesomeIcons.database,
              color: Colors.black,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(4.0),
          child: CustomButton(
            text: "nouveaux produit",
            root: "/ProductEntryPage",
            widget: Icon(
              FontAwesomeIcons.circlePlus,
              color: Colors.black,
            ),
          ),
        )
      ],
    );
  }
}
