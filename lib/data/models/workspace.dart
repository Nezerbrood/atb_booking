import 'package:atb_booking/data/models/workspace_type.dart';
import 'package:atb_booking/data/services/image_provider.dart';
import 'package:atb_booking/data/services/network/network_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Workspace {
  final int id;
  final int numberOfWorkspaces;
  final String description;
  final bool isActive;
  final double positionX;
  final double positionY;
  final double sizeX;
  final double sizeY;
  final WorkspaceType type;
  final int level;
  final List<Photo> photos;

  Workspace.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        numberOfWorkspaces = json['numberOfWorkspaces'],
        description = json['description'],
        isActive = json['isActive'],
        positionX = (json['positionX'] as int).toDouble(),
        positionY = (json['positionY'] as int).toDouble(),
        sizeX = (json['sizeX'] as int).toDouble(),
        sizeY = (json['sizeY'] as int).toDouble(),
        type = WorkspaceType.fromJson(json['type']),
        level = json['level'],
        photos = //getRandomPhotoList();
        (json['photos'] as List<dynamic>)
            .map((json) => Photo.fromJson(json))
            .toList();

  Workspace(
      this.id,
      this.numberOfWorkspaces,
      this.description,
      this.isActive,
      this.positionX,
      this.positionY,
      this.level,
      this.photos,
      this.sizeX,
      this.sizeY,
      this.type);

  static getRandomPhotoList(
      ) {
    List<Photo> listPhoto = [];
    for(int i=0 ;i<1;i++){
      listPhoto.add(Photo(id: i, photo: CachedNetworkImage(
        fit: BoxFit.cover,
        imageUrl: 'https://iili.io/HKq6S3P.webp',
        placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      )));
    }
    return listPhoto;
  }
}

class WorkspaceOnPlan {
  final int id;
  final bool isActive;
  final double positionX;
  final double positionY;
  final double sizeX;
  final double sizeY;
  final int typeId;

  WorkspaceOnPlan(
      {required this.id,
      required this.isActive,
      required this.positionX,
      required this.positionY,
      required this.sizeX,
      required this.sizeY,
      required this.typeId});

  WorkspaceOnPlan.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        isActive = json['isActive'],
        positionX = (json['positionX'] as int).toDouble(),
        positionY = (json['positionY'] as int).toDouble(),
        sizeX = (json['sizeX'] as int).toDouble(),
        sizeY = (json['sizeY'] as int).toDouble(),
        typeId = json['typeId'];
}

class Photo {
  final int id;
  final CachedNetworkImage photo;
  Photo.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        photo = CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl: AppImageProvider.getImageUrlFromImageId(json['imageId']),
          httpHeaders: NetworkController().getAuthHeader(),
          placeholder: (context, url) => const Center(),
          errorWidget: (context, url, error) => const Icon(Icons.error),

        );

  Photo({required this.id, required this.photo});
}
