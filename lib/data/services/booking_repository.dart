import 'package:flutter/material.dart';

import '../models/booking.dart';
import '../models/workspace.dart';
//
// class BookingRepository{
//   final BookingProvider _bookingProvider = BookingProvider();
//   Future<List<Booking>> getBookingByUserId(int id) => _bookingProvider.getBookingByUserId(id);
//   Future<List<Booking>> getBookingById(int id)=>_bookingProvider.getBookingById(id);
// }


Workspace workspace = Workspace(1, 1, 'description', true, 20, 20, 1, 1, [], 40,40);
class BookingRepository{
  Future<List<Booking>> getBookingByUserId(int id) async {
    return await List.of([
      Booking(id: 1, cityAddress: "gfdgdgsrgs", officeAddress:"gfdgdgsrgs", workspace: workspace, dateTimeRange: DateTimeRange(start:DateTime.now(),end:DateTime.now().add( Duration(hours: 4))), level: 1),
      Booking(id: 1, cityAddress: "gfdgdgsrgs", officeAddress:"gfdgdgsrgs", workspace: workspace, dateTimeRange: DateTimeRange(start:DateTime.now(),end:DateTime.now().add( Duration(hours: 4))), level: 1),
      Booking(id: 1, cityAddress: "gfdgdgsrgs", officeAddress:"gfdgdgsrgs", workspace: workspace, dateTimeRange: DateTimeRange(start:DateTime.now(),end:DateTime.now().add( Duration(hours: 4))), level: 1),
      Booking(id: 1, cityAddress: "gfdgdgsrgs", officeAddress:"gfdgdgsrgs", workspace: workspace, dateTimeRange: DateTimeRange(start:DateTime.now(),end:DateTime.now().add( Duration(hours: 4))), level: 1),
      Booking(id: 1, cityAddress: "gfdgdgsrgs", officeAddress:"gfdgdgsrgs", workspace: workspace, dateTimeRange: DateTimeRange(start:DateTime.now(),end:DateTime.now().add( Duration(hours: 4))), level: 1),
    ]);
  }
  //Future<List<Booking>> getBookingById(int id)=>_bookingProvider.getBookingById(id);
}