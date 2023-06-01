import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String description;
  final String buttonText;
  final Image ?image;
  final bool isDark;

  const CustomDialog({super.key, required this.title,required this.description,required this.buttonText,this.image, required this.isDark,});

  @override
  Widget build(BuildContext context) {
    final Brightness brightnessValue = MediaQuery.of(context).platformBrightness;
    bool isDark = brightnessValue == Brightness.dark;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 0,
      backgroundColor: isDark ? Colors.grey[900] : Colors.white,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding:const  EdgeInsets.only(
            top: 80,
            bottom: 16,
            left: 16,
            right: 16,
          ),
          margin: const EdgeInsets.only(top: 16),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: isDark ? const Color.fromARGB(255, 0, 0, 0) : Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const[
               BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                description,
                style: TextStyle(
                  fontSize: 14,
                  color: isDark ? Colors.white : Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    buttonText,
                    style:const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
       Positioned(
          top: 0,
          left: 16,
          right: 16,
          child: CircleAvatar(
            
            backgroundColor: Colors.transparent,
            radius: 60,
            child: ClipRRect(
              
              borderRadius: const BorderRadius.all(
                Radius.circular(60),
              ),
              child: image 
            ),
          ),
        ),
        ],
    );
  }
}
