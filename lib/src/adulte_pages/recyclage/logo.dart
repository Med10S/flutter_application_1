import 'package:flutter/material.dart';
import 'package:flutter_application_1/utilities/string.dart';

import '../../../colors/colors.dart';
import '../../../utilities/custum_dialog.dart';
import '../../../utilities/dimention.dart';

class CustomButton2 extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final Image image;
  final bool? icon;

 const CustomButton2({
    Key? key,
    required this.buttonText,
    required this.onPressed,
    required this.image,
    this.icon,

}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Brightness brightnessValue =
        MediaQuery.of(context).platformBrightness;
    bool isDark = brightnessValue == Brightness.dark;
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context)
            .cardColor), // Définir la couleur de fond du bouton
      ),
      onPressed: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          if(icon==true)
            Container(alignment: Alignment.topRight,child: Text("❌"),),
          if (image != null) // Vérifie si l'image a été fournie
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: image
            ),
          Text(
            buttonText, 
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isDark ? Colors.white : Colors.black,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class LogoRecyclage extends StatelessWidget {

  final List<String> buttonTitles = [
    'Triman',
    'Triangle de Mobius',
    'Consignes Intro-Tri',
    'Poubelle barrée',
    'Point Vert',
    'Tidyman'
  ];
   final List<String> interpretation = [
    Strings.triman,
    Strings.triangledeMobius,
    Strings.consignesIntroTri,
    Strings.poubellebarree,
    Strings.pointVert,
    Strings.tidyman
      ];
  final List<String> buttonImages =  [
    'images/triman.png',
    'images/recycle.png',
    'images/consignes_intro_tri.png',
    'images/poubelle-barree.png',
    'images/point-vert.png',
    'images/Tidyman.png',
  ];

  @override
  Widget build(BuildContext context) {
    final Brightness brightnessValue =
        MediaQuery.of(context).platformBrightness;
    bool isDark = brightnessValue == Brightness.dark;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                      height: Dimenssion.FirstPagesImageHeight / 2.5,
                      alignment: Alignment.topRight,
                      child: Image.asset('images/terre.png')),
                  Image.asset('images/logo.png')
                ],
              ),
              Text('Logo recyclage',
                  style: TextStyle(
                    fontSize: Dimenssion.width24dp,
                    color: Mcolors.couleurSecondaire,
                  )),
              Text("❌ Les faux-amis des symboles de recyclage*",style: TextStyle(color: Colors.red),),

              SizedBox(
                height: Dimenssion.height45dp * 10,
                child: GridView.builder(
                  padding: EdgeInsets.all(Dimenssion.height20dp),
                  itemCount: buttonTitles.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                    mainAxisSpacing: 16.0,
                    crossAxisSpacing: 16.0,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return CustomButton2(
                      buttonText: buttonTitles[index],
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CustomDialog(
                                title: buttonTitles[index],
                                description: interpretation[index],
                                buttonText: 'Close',
                                image:  Image.asset(buttonImages[index],height: Dimenssion.height55dp,color:isDark ? Colors.white : null,),
                                isDark: isDark);
                          },
                        );
                      },
                      image: Image.asset(buttonImages[index],height: Dimenssion.height55dp,),
                      icon:  index==4||index==5 ? true:false ,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
