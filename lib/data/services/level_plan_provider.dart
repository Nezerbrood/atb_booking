import 'dart:convert';

import 'package:atb_booking/data/models/workspace.dart';
import 'package:atb_booking/data/services/network/network_controller.dart';
import 'package:http/http.dart' as http;
import '../models/level_plan.dart';

class LevelPlanProvider {
  Future<LevelPlan> getPlanByLevelId(int id) async {
    var baseUrl = NetworkController().getUrl();
    Map<String, String> headers = {};
    var token = await NetworkController().getAccessToken();
    headers["Authorization"] = 'Bearer $token';
    headers["Content-type"] = 'application/json; charset=utf-8';
    headers["Accept"] = "application/json";
    var uri = Uri.http(baseUrl, '/api/officeLevels/levelWithWorkplaces/$id');
    final response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      return LevelPlan.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else if (response.statusCode == 401) {
      /// Обновление access токена
      await NetworkController().updateAccessToken();
      return getPlanByLevelId(id);
    } else {
      throw Exception('Error fetching level');
    }
  }
}
