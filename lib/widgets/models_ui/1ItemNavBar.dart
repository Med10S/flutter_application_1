import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OneItemNavBar extends StatelessWidget {
  final String? imagepath;
  final Widget? widget;
  final double left, top, right, bottom;
  final Widget page;
  final bool push;
  OneItemNavBar({
    super.key,
    this.widget,
    this.imagepath,
    required this.page,
    required this.left,
    required this.top,
    required this.right,
    required this.bottom,
    required this.push,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(left, top, right, bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
              onTap: () {
                push
                    ? Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (_) => page,
                        ))
                    : Navigator.pop(
                        context,
                        CupertinoPageRoute(
                          builder: (_) => page,
                        ));
              },
              child: imagepath != null ? Image.asset(imagepath!) : widget),
        ],
      ),
    );
  }
}
