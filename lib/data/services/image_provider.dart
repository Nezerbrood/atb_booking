import 'package:atb_booking/data/services/network/network_controller.dart';
class AppImageProvider{
  static String getImageUrlFromImageId(int id){

    var baseUrl = NetworkController().getUrl();
    var uri = Uri.http(baseUrl, "/api/images/$id");
    return uri.toString();
  }
}