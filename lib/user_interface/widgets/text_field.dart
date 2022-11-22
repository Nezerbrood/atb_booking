import 'package:atb_booking/user_interface/booking/booking_list_bloc/booking_list_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../presentation/constants/styles.dart';

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