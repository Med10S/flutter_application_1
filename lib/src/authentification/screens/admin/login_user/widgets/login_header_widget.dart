import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/colors/colors.dart';
import 'package:flutter_application_1/utilities/dimention.dart';

class LoginHeaderWidget extends StatelessWidget {
  const LoginHeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Transform.rotate(
          angle: 0,
          child: Image(
              image: const AssetImage("images/Group2.png"),
              height: size.height * 0.3),
        ),
        Text("Welcome Back",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: Dimenssion.width24dp)),
        Text("Make it work, make it right, make it fast.",
            style: TextStyle(fontSize: Dimenssion.width16dp)),
      ],
    );
  }
}
