import 'package:flutter/material.dart';

class Office {
  final int id;
  final String address;
  final int maxBookingRangeInDays; //дальность бронирования в днях
  final DateTimeRange workTimeRange;
  int? cityId;
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
    required this.workTimeRange, this.cityId,
  });
  Map<String, dynamic> toJson() {
    var json = <String, dynamic>{};
    //json['id'] = id;
    json["id"] = id;
    json["cityId"] = cityId;
    json["address"] = address;
    json["maxDuration"] = maxBookingRangeInDays;
    json["workStart"] = workTimeRange.start.toUtc().toIso8601String();
    json["workEnd"] = workTimeRange.end.toUtc().toIso8601String();
    return json;
  }

}
