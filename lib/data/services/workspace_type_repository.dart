//
// class WorkspaceTypeRepository{
//   final WorkspaceTypeProvider _wokspaceTypeProvider = WorkspaceTypeProvider();
//   Future<List<WorkspaceType>> getBookingByUserId(int id) => _workspaceTypeProvider.getBookingByUserId(id);
//   Future<List<WorkspaceType>> getBookingById(int id)=>_workspaceTypeProvider.getBookingById(id);
// }

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../models/workspace_type.dart';

class WorkspaceTypeRepository {
  Future<Map<int,WorkspaceType>> getMapOfTypes() async {
    var list = List.of([
      WorkspaceType(
          1,
          "Стол с компьютером",
          CachedNetworkImage(
            imageUrl: "https://cdn-icons-png.flaticon.com/512/198/198163.png",
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          )),
      WorkspaceType(
          2,
          "Переговорка",
          CachedNetworkImage(
            imageUrl: "http://clipart-library.com/img/1997756.png",
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          )),
    ]);
    var result = { for (var v in list) v.id: v};
    return result;
  }
}
