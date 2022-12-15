import 'package:flutter/material.dart';

class Office {
  final int id;
  final String address;
  final int maxBookingRangeInDays; //дальность бронирования в днях
  final DateTimeRange workTimeRange;

  Office.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        address = json['address'],
        maxBookingRangeInDays = json['maxDuration'],
        workTimeRange = DateTimeRange(
            start: DateTime.parse(json['workStart']).toLocal(),
            end: DateTime.parse(json['workEnd']).toLocal());

  Office({
    required this.id,
    required this.address,
    required this.maxBookingRangeInDays,
    required this.workTimeRange,
  });
}
