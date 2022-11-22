import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/city.dart';
class CityProvider{
  // Future<List<City>> getCityById(int id) async {
  //
  //   final response = await http.get( Uri.parse('http://google.com'));
  //   if(response.statusCode == 200){
  //     final List<dynamic> cityJson = json.decode(response.body);
  //     return cityJson.map((json)=>City.fromJson(json)).toList();
  //   }else{
  //     throw Exception('Error fetching users');
  //   }
  // }


  Future<List<City>> getAllCities() async {
    final response = await http.get( Uri.parse('http://45.67.58.123:8080/api/cities'));
    if(response.statusCode == 200){
      final List<dynamic> cityJson = json.decode(utf8.decode(response.bodyBytes));
      return cityJson.map((json)=>City.fromJson(json)).toList();
    }else{
      throw Exception('Error fetching users');
    }
  }
}