import 'dart:convert';

import 'package:atb_booking/data/services/network/network_controller.dart';
import 'package:atb_booking/logic/secure_storage_api.dart';
import 'package:http/http.dart' as http;

class FeedbackProvider {
  var uri = Uri.http(
    '85.192.32.12:8080',
    '/api/feedbacks',
  );

  Future<void> createFeedbackMessage(String message, int feedbackTypeId,
      int? officeId, int? workplaceId, int? guiltyId) async {
    int userId = await SecurityStorage().getIdStorage();
    DateTime date = DateTime.now();

    /// Создание тела запроса
    var newJson = <String, dynamic>{};
    newJson["comment"] = message;
    newJson["feedbackTypeId"] = feedbackTypeId.toString();
    newJson["officeId"] = officeId.toString();
    newJson["workplaceId"] = workplaceId.toString();
    newJson["guiltyId"] = guiltyId.toString();
    newJson["userId"] = userId.toString();
    newJson["date"] = date.toUtc().toIso8601String();
    var encoded = jsonEncode(newJson);
    print("newJson: $newJson");

    /// Создание headers запроса
    Map<String, String> headers = {};
    headers = await NetworkController().getAuthHeader();
    headers["Content-type"] = 'application/json';

    /// Вызов POST запроса
    var response = await http.post(uri, headers: headers, body: encoded);

    if (response.statusCode == 401) {
      await NetworkController().updateAccessToken();
      createFeedbackMessage(
          message, feedbackTypeId, officeId, workplaceId, guiltyId);
    } else if (response.statusCode != 201) {
      throw Exception("Error Feedback Creating In Provider");
    }
  }
}
