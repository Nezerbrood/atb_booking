import 'package:flutter/material.dart';

enum PLACETYPE {
  meetingRoom,
  workPlace,
}

class Booking {
  int officeId;
  int level;
  int placeId;
  PLACETYPE placeType;
  String placeName;
  DateTimeRange dateTimeRange;

  Booking(this.officeId, this.level, this.placeId, this.placeType,
      this.placeName, this.dateTimeRange);
}