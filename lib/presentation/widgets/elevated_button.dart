import 'package:flutter/material.dart';

import '../constants/styles.dart';

class AtbElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Widget? icon;

  const AtbElevatedButton(
      {super.key, required this.onPressed, required this.text, this.icon});

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: appThemeData.copyWith(
            colorScheme: appThemeData.colorScheme
                .copyWith(surface: appThemeData.primaryColor)),
        child: ElevatedButton(
          style: const ButtonStyle(),
          onPressed: onPressed,
          child: SizedBox(
              width: 240,
              height: 60,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                        child: Text(
                      text,
                      style: appThemeData.textTheme.displayLarge
                          ?.copyWith(color: Colors.white, fontSize: 20),
                    )),
                    icon ?? const SizedBox.shrink(),
                  ],
                ),
              )),
        ));
  }
}
