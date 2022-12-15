import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class WorkspaceType {
  final int id;
  final String type;
  final CachedNetworkImage? cachedNetworkImage;

  WorkspaceType(this.id, this.type, this.cachedNetworkImage);

  WorkspaceType.fromJson(Map<String, dynamic> json)
      :
        id = json['id'],
        type = json['type'],
        cachedNetworkImage = (json['image'] != null) ? CachedNetworkImage(
            imageUrl: json['image']) : getCachedNetworkImage(json['id']);


}

var image1 = CachedNetworkImage(
imageUrl: "https://cdn-icons-png.flaticon.com/512/198/198163.png",
placeholder: (context, url) => Container(),
errorWidget: (context, url, error) => const Icon(Icons.error),
);

var image2 = CachedNetworkImage(
  imageUrl: "http://clipart-library.com/img/1997756.png",
  placeholder: (context, url) => Container(),
  errorWidget: (context, url, error) => const Icon(Icons.error),
);
CachedNetworkImage getCachedNetworkImage(int typeId) {
  if (typeId == 1) {
    return image1;
  } else {
      return image2;
    }
}

