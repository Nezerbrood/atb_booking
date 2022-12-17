import 'dart:convert';

import 'package:atb_booking/data/services/network/network_controller.dart';
import 'package:atb_booking/logic/admin_role/offices/LevelPlanEditor/level_plan_editor_bloc.dart';
import 'package:http/http.dart' as http;
import '../models/workspace.dart';

class WorkspaceProvider {
  Future<Workspace> fetchWorkspaceById(int id) async {
    print("PROVIDER fetchWorkspaceById");
    Map<String, dynamic> queryParameters = {};
    var baseUrl = NetworkController().getUrl();
    Map<String, String> headers = {};
    var token = await NetworkController().getAccessToken();
    headers["Authorization"] = 'Bearer $token';
    headers["Content-type"] = 'application/json; charset=utf-8';
    headers["Accept"] = "application/json";
    var uri = Uri.http(baseUrl, '/api/workspaces/$id', queryParameters);
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      return Workspace.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else if (response.statusCode == 401) {
      /// Обновление access токена
      await NetworkController().updateAccessToken();
      return fetchWorkspaceById(id);
    } else {
      throw Exception('Error fetching workspace');
    }
  }

  Future<int> createWorkspaceByLevelPlanEditorElementData(
      LevelPlanElementData element) async {
    print("PROVIDER create workspace");
    var jsonOfElement = element.toJson();
    var body = jsonEncode(jsonOfElement);
    print(body);
    Map<String, dynamic> queryParameters = {};
    var baseUrl = NetworkController().getUrl();
    Map<String, String> headers = {};
    var token = await NetworkController().getAccessToken();
    headers["Authorization"] = 'Bearer $token';
    headers["Content-type"] = 'application/json; charset=utf-8';
    headers["Accept"] = "application/json";
    var uri = Uri.http(baseUrl, '/api/workspaces', queryParameters);
    var response = await http.post(uri, headers: headers, body: body);
    if (response.statusCode == 201) {
      int id = (json.decode(utf8.decode(response.bodyBytes)))["id"]!;
      print("successful create workspace, id: $id");
      return (id);
    } else if (response.statusCode == 401) {
      /// Обновление access токена
      await NetworkController().updateAccessToken();
      return createWorkspaceByLevelPlanEditorElementData(element);
    } else {
      print("error create workspace, status code: ${response.statusCode}");
      throw Exception('Error create workspace');
    }
  }

  Future<void> deleteById(int workspaceId) async {
    print("PROVIDER create workspace");
    Map<String, dynamic> queryParameters = {};
    var baseUrl = NetworkController().getUrl();
    Map<String, String> headers = {};
    var token = await NetworkController().getAccessToken();
    headers["Authorization"] = 'Bearer $token';
    headers["Content-type"] = 'application/json; charset=utf-8';
    headers["Accept"] = "application/json";
    var uri =
        Uri.http(baseUrl, '/api/workspaces/$workspaceId', queryParameters);
    var response = await http.delete(
      uri,
      headers: headers,
    );
    if (response.statusCode == 200) {
      print("successful delete workspace id:${workspaceId}");
    } else if (response.statusCode == 401) {
      /// Обновление access токена
      await NetworkController().updateAccessToken();
      return deleteById(workspaceId);
    } else if (response.statusCode == 404) {
      print("already deleted");
    } else {
      print("error delete workspace, status code: ${response.statusCode}");
      throw Exception('Error create workspace');
    }
  }
  Future<void> sendWorkspacesChangesByLevelId(List<LevelPlanElementData> listOfChangedWorkspaces) async {
    var baseUrl = NetworkController().getUrl();
    Map<String, String> headers = {};
    var list = <dynamic>[];
    for (var elem in listOfChangedWorkspaces) {
      var jsonElem = elem.toJson();
      list.add((jsonElem));
    }
    var body = jsonEncode(list);
    var token = await NetworkController().getAccessToken();
    headers["Authorization"] = 'Bearer $token';
    headers["Content-type"] = 'application/json; charset=utf-8';
    headers["Accept"] = "application/json";
    var uri = Uri.http(baseUrl, '/api/workspaces');
    final response = await http.put(uri, headers: headers, body: body);
    if (response.statusCode == 200) {
      print("successful put workspaces!");
    } else if (response.statusCode == 401) {
      /// Обновление access токена
      await NetworkController().updateAccessToken();
      return sendWorkspacesChangesByLevelId(listOfChangedWorkspaces);
    } else {
      print("response code: ${response.statusCode}");
      throw Exception('Error fetching level');
    }
  }
}
