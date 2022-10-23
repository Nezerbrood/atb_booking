import 'package:flutter/material.dart';

class NewBooking extends StatefulWidget {
  const NewBooking({super.key});

  @override
  State<StatefulWidget> createState() {
    return _NewBookingState();
  }
}
class _NewBookingState extends State<NewBooking>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Бронирование")),
      body: Center(child: Text('NEW BOOKING SCREEN')),
    );
  }}