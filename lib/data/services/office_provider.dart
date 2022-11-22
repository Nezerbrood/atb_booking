import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/level_plan.dart';
import '../models/office.dart';

class OfficeProvider{
  Future<List<OfficeListItem>> getOfficesByCityId(int id) async {
    final response = await http.get( Uri.parse('http://45.67.58.123:8080/api/offices?cityId=$id'));
    if(response.statusCode == 200){
      final List<dynamic> officeListItemJson = json.decode(response.body);
      return officeListItemJson.map((json)=>OfficeListItem.fromJson(json)).toList();
    }else{
      throw Exception('Error fetching offices');
    }
  }
  Future<Office> getOfficeById(int id) async {
    final response = await http.get( Uri.parse('http://45.67.58.123:8080/api/offices/$id'));
    if(response.statusCode == 200){
      //final dynamic officeJson = json.decode(response.body);
      return Office.fromJson(jsonDecode(response.body));
      //return officeJson.map((json)=>Office.fromJson(json));
    }else{
      throw Exception('Error fetching office');
    }
  }
  Future<List<Level>> getLevelsByOfficeId(int id) async {
    final response = await http.get( Uri.parse('http://45.67.58.123:8080/api/offices/$id'));
    if(response.statusCode == 200){
      //final dynamic officeJson = json.decode(response.body);
      return Office.fromJson(jsonDecode(response.body)).levels;
      //return officeJson.map((json)=>Office.fromJson(json));
    }else{
      throw Exception('Error fetching office');
    }
  }
}