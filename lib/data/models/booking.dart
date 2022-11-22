import 'package:flutter/material.dart';

import 'workspace.dart';

enum PLACETYPE {
  meetingRoom,
  workPlace,
}

class Booking {
  int id;
  String cityAddress;
  String officeAddress;
  int level;
  Workspace workspace;
  DateTimeRange dateTimeRange;
  Booking({required this.id,required this.cityAddress, required this.officeAddress, required this.workspace, required this.dateTimeRange, required this.level});
}