import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/booking.dart';
class BookingProvider{
  Future<List<Booking>> getBookingByUserId(int id) async {
    final response = await http.get( Uri.parse('http://google.com'));
    if(response.statusCode == 200){
      final List<dynamic> bookingJson = json.decode(response.body);
      return bookingJson.map((json)=>Booking.fromJson(json)).toList();
    }else{
      throw Exception('Error fetching users');
    }
  }


  Future<List<Booking>> getBookingById(int id) async {
    final response = await http.get( Uri.parse('http://google.com'+id.toString()));
    if(response.statusCode == 200){
      final List<dynamic> bookingJson = json.decode(response.body);
      return bookingJson.map((json)=>Booking.fromJson(json)).toList();
    }else{
      throw Exception('Error fetching users');
    }
  }
}