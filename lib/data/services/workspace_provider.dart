import 'dart:convert';

import 'package:atb_booking/data/services/network/network_controller.dart';
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
    var uri =
        Uri.http(baseUrl, '/api/workspaces/$id', queryParameters);
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
}
