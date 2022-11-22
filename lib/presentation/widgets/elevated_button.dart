import 'package:flutter/material.dart';

import '../constants/styles.dart';

class AtbElevatedButton extends StatelessWidget{
  final VoidCallback onPressed;
  final String text;
  const AtbElevatedButton({super.key, required this.onPressed,required this.text});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: SizedBox(
          width: 240,
          height: 60,
          child: Center(
              child: Text(
                text,
                style: appThemeData.textTheme.displayLarge
                    ?.copyWith(color: Colors.white, fontSize: 20),
              ))),
      onPressed: onPressed,
    );
  }
  
}