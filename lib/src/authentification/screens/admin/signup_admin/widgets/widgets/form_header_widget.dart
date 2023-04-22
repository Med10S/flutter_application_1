import 'package:flutter/material.dart';
import 'package:flutter_application_1/utilities/dimention.dart';


class FormHeaderWidget extends StatelessWidget {
  const FormHeaderWidget({
    Key? key,
    this.imageColor,
    this.heightBetween,
    required this.image,
    required this.title,
    required this.subTitle,
    this.textAlign,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  }) : super(key: key);

  //Variables -- Declared in Constructor
  final Color? imageColor;
  final double? heightBetween;
  final String image, title, subTitle;
  final CrossAxisAlignment crossAxisAlignment;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Image(image: AssetImage(image), color: imageColor, height: size.height * 0.3),
        SizedBox(height: heightBetween),
        Text(title, style:TextStyle(fontWeight: FontWeight.bold,fontSize: Dimenssio.width24dp)),
        Text(subTitle, textAlign: textAlign,style: TextStyle(fontSize: Dimenssio.width16dp)),
      ],
    );
  }
}