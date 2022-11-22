import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/level_plan.dart';

class LevelPlanProvider{
  Future<LevelPlan> getPlanByLevelId(int id) async {
    final response = await http.get( Uri.parse('http://45.67.58.123:8080/api/cities'));
    if(response.statusCode == 200){
      return LevelPlan.fromJson(json.decode(response.body));
    }else{
      throw Exception('Error fetching users');
    }
  }
  Future<LevelPlan> getLevelsByOfficeId(int id) async {
    final response = await http.get( Uri.parse('http://45.67.58.123:8080/api/cities'));
    if(response.statusCode == 200){
      return LevelPlan.fromJson(json.decode(response.body));
    }else{
      throw Exception('Error fetching users');
    }
  }
}