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
      return officeListItemJson.map((json) => Office.fromJson(json)).toList();
    } else if (response.statusCode == 401) {
      /// Обновление access токена
      await NetworkController().updateAccessToken();
      return getOfficesByCityId(id);
    } else {
      print("Error fetching offices");
      throw Exception('Error fetching offices');
    }
  }

  Future<List<LevelListItem>> getLevelsByOfficeId(int id) async {
    print("PROVIDER getLevelsByOfficeId");
    var baseUrl = NetworkController().getUrl();
    Map<String, String> headers = {};
    var token = await NetworkController().getAccessToken();
    headers["Authorization"] = 'Bearer $token';
    var uri = Uri.http(baseUrl, '/api/officeLevels/$id');
    final response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      print('successful fetching levels');
      final List<dynamic> levelsJson =
          json.decode(utf8.decode(response.bodyBytes));
      return levelsJson.map((json) => LevelListItem.fromJson(json)).toList();
    } else if (response.statusCode == 401) {
      /// Обновление access токена
      await NetworkController().updateAccessToken();
      return getLevelsByOfficeId(id);
    } else {
      print("Error fetching levels");
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
      final dynamic officeJson = json.decode(utf8.decode(response.bodyBytes));
      return Office.fromJson(officeJson);
    } else if (response.statusCode == 401) {
      /// Обновление access токена
      await NetworkController().updateAccessToken();
      return getOfficeById(id);
    } else {
      throw Exception('Error fetching office');
    }
  }

  Future<void> changeOffice(Office office) async {
    var baseUrl = NetworkController().getUrl();
    Map<String, String> headers = {};
    var token = await NetworkController().getAccessToken();
    headers["Authorization"] = 'Bearer $token';
    headers["Content-type"] = 'application/json; charset=utf-8';
    headers["Accept"] = "application/json";

    var body = jsonEncode(office.toJson());
    print(body);
    var uri = Uri.http(baseUrl, '/api/offices/${office.id}');
    final response = await http.put(uri, headers: headers, body: body);
    if (response.statusCode == 200) {
      print("successful editing office");
    } else if (response.statusCode == 401) {
      /// Обновление access токена
      await NetworkController().updateAccessToken();
      return changeOffice(office);
    } else {
      var responseDecodedBody = json.decode(utf8.decode(response.bodyBytes));
      print(responseDecodedBody);
      print("'Error editing office, status code: ${response.statusCode}");
      throw Exception('Error editing office');
    }
  }

  Future<int> createOffice(Office office)async {
    var baseUrl = NetworkController().getUrl();
    Map<String, String> headers = {};
    var token = await NetworkController().getAccessToken();
    headers["Authorization"] = 'Bearer $token';
    headers["Content-type"] = 'application/json; charset=utf-8';
    headers["Accept"] = "application/json";

    var body = jsonEncode(office.toJson());
    var uri = Uri.http(baseUrl, '/api/offices');
    final response = await http.post(uri, headers: headers, body: body);
    if (response.statusCode == 201) {
      var jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      int id = jsonResponse['id'];
      print("successful create office");
      print("_________________");
      print("Создание офиса ${office.address} с временем работы:");
      print("start: ${office.workTimeRange.start.toLocal().toIso8601String()}");
      print("end: ${office.workTimeRange.end.toLocal().toIso8601String()}");
      return id;
    } else if (response.statusCode == 401) {
      /// Обновление access токена
      await NetworkController().updateAccessToken();
      return createOffice(office);
    } else {
      //print(json.decode(utf8.decode(response.bodyBytes)));
      print("'Error create office, status code: ${response.statusCode}");
      throw Exception('Error create office');
    }
  }

  Future<void> deleteOfficeById(int officeId) async {
    var baseUrl = NetworkController().getUrl();
    Map<String, String> headers = {};
    var token = await NetworkController().getAccessToken();
    headers["Authorization"] = 'Bearer $token';
    headers["Content-type"] = 'application/json; charset=utf-8';
    headers["Accept"] = "application/json";
    var uri = Uri.http(baseUrl, '/api/offices/$officeId');
    final response = await http.delete(uri, headers: headers,);
    if (response.statusCode == 200) {
      print("successful delete office");
    } else if (response.statusCode == 401) {
      /// Обновление access токена
      await NetworkController().updateAccessToken();
      return deleteOfficeById(officeId);
    } else {
      //print(json.decode(utf8.decode(response.bodyBytes)));
      print("'Error delete office, status code: ${response.statusCode}");
      throw Exception('OfficeProvider: Error delete office');
    }
  }
}
