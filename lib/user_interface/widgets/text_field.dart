import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants/styles.dart';

class AtbTextField extends StatelessWidget{
  final String text;

  const AtbTextField({super.key, required this.text});
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: appThemeData.colorScheme.tertiary,
          borderRadius:
          BorderRadius.circular(10).copyWith(),
        ),
        child: TextField(
            obscureText: false,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: text,
            )));
  }

}