import 'dart:convert';

import 'package:atb_booking/data/services/network/network_controller.dart';
import 'package:http/http.dart' as http;
import '../models/level_plan.dart';

class LevelPlanProvider{
  Future<LevelPlan> getPlanByLevelId(int id) async {
    var baseUrl = NetworkController().getUrl();
    Map<String, String> headers = {};
    var token = await NetworkController().getAccessToken();
    headers["Authorization"] = 'Bearer $token';
    var uri = Uri.http(baseUrl, '/api/offices/levelWithWorkplaces/$id');
    final response = await http.get( uri,headers: headers);
    if(response.statusCode == 200){
      return LevelPlan.fromJson(json.decode(response.body));
    } else if (response.statusCode == 401) {
      /// Обновление access токена
      await NetworkController().updateAccessToken();
      return getPlanByLevelId(id);
    }else{
      throw Exception('Error fetching level');
    }
  }
}