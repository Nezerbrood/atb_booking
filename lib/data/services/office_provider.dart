import 'dart:convert';

import 'package:atb_booking/data/services/network/network_controller.dart';
import 'package:http/http.dart' as http;
import '../models/level_plan.dart';
import '../models/office.dart';

class OfficeProvider {
  Future<List<Office>> getOfficesByCityId(int id) async {
    print("PROVIDER getOfficesByCityId");

    var baseUrl = NetworkController().getUrl();
    Map<String, String> headers = {};
    Map<String, dynamic> queryParameters = {};
    var token = await NetworkController().getAccessToken();
    headers["Authorization"] = 'Bearer $token';
    queryParameters["cityId"] = id.toString();
    var uri = Uri.http(baseUrl, '/api/offices/city/$id');
    final response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      final List<dynamic> officeListItemJson =
          json.decode(utf8.decode(response.bodyBytes));
      return officeListItemJson
          .map((json) => Office.fromJson(json))
          .toList();
    } else if (response.statusCode == 401) {
      /// Обновление access токена
      await NetworkController().updateAccessToken();
      return getOfficesByCityId(id);
    } else {
      throw Exception('Error fetching offices');
    }
  }

  Future<List<Level>> getLevelsByOfficeId(int id) async {
    print("PROVIDER getLevelsByOfficeId");
    var baseUrl = NetworkController().getUrl();
    Map<String, String> headers = {};
    var token = await NetworkController().getAccessToken();
    headers["Authorization"] = 'Bearer $token';
    var uri = Uri.http(baseUrl, '/api/offices/levels/$id');
    final response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      print('successful fetching levels');
      final List<dynamic> levelsJson =
          json.decode(utf8.decode(response.bodyBytes));
      return levelsJson.map((json) => Level.fromJson(json)).toList();
    } else if (response.statusCode == 401) {
      /// Обновление access токена
      await NetworkController().updateAccessToken();
      return getLevelsByOfficeId(id);
    } else {
      throw Exception('Error fetching office');
    }
  }
  Future<Office> getOfficeById(int id) async {
    print("PROVIDER getOfficeById");
    var baseUrl = NetworkController().getUrl();
    Map<String, String> headers = {};
    var token = await NetworkController().getAccessToken();
    headers["Authorization"] = 'Bearer $token';
    var uri = Uri.http(baseUrl, '/api/offices/info/${id}');
    final response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      print('successful fetching office');
      final dynamic officeJson =
      json.decode(utf8.decode(response.bodyBytes));
      return Office.fromJson(officeJson);
    } else if (response.statusCode == 401) {
      /// Обновление access токена
      await NetworkController().updateAccessToken();
      return getOfficeById(id);
    } else {
      throw Exception('Error fetching office');
    }
  }
}
