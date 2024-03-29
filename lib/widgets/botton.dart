import 'package:flutter/material.dart';

import '../colors/colors.dart';
import '../utilities/dimention.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final String root;

  final Widget? widget;
  const CustomButton(
      {super.key, required this.text, required this.root, this.widget});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: Dimenssion.height55dp,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, root);
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Mcolors.Cbackground,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
            child: Container(
              padding:
                  EdgeInsets.symmetric(horizontal: Dimenssion.width30dp / 2),
              child: widget == null
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          text,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: Dimenssion.width16dp),
                        ),
                        const Icon(Icons.arrow_forward_ios,
                            color: Colors.black),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        widget!,
                        Text(
                          text,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: Dimenssion.width16dp),
                        ),
                        const Icon(Icons.arrow_forward_ios,
                            color: Colors.black),
                      ],
                    ),
            ),
          ),
        ),
        SizedBox(
          height: Dimenssion.height20dp / 2,
        )
      ],
    );
  }
}
