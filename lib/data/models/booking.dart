import 'package:flutter/material.dart';

import 'workspace.dart';

enum PLACETYPE {
  meetingRoom,
  workPlace,
}

class Booking {
  final int id;
  final String cityAddress;
  final String officeAddress;
  final int level;
  final Workspace workspace;
  final DateTimeRange dateTimeRange;

  Booking(
      {required this.id,
      required this.cityAddress,
      required this.officeAddress,
      required this.workspace,
      required this.dateTimeRange,
      required this.level});

  Booking.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        cityAddress = json['cityAddress'],
        officeAddress = json['officeAddress'],
        level = json['level'],
        workspace = json['workspace'],
        dateTimeRange = json['dateTimeRange'];
}
