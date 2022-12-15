import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class User {
  int id;
  String login;
  String fullName;
  CachedNetworkImage avatar;
  String phone;
  String email;
  bool isFavorite;
  String role;

  User(this.id, this.login, this.fullName, this.avatar, this.phone, this.email,
      this.isFavorite,this.role);

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        json["id"] as int,
        json["login"] as String,
        json["fullName"] as String,
        CachedNetworkImage(
            imageUrl: (json["avatar"] == null || json["avatar"] == '?')
                ? "https://www.computerhope.com/jargon/b/black.jpg"
                // : json["avatar"],
                : "https://www.computerhope.com/jargon/b/black.jpg",
            placeholder: (context, url) => Container(),
            errorWidget: (context, url, error) => CachedNetworkImage(
                imageUrl:
                    "https://www.computerhope.com/jargon/b/black.jpg")),
        json["phone"] as String,
        json["email"] as String,
        json["favorite"] as bool,
        json["role"] as String);
  }
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "id": id,
      "login": login,
      "fullName": fullName,
      "avatar": avatar,
      "phone": phone,
      "email": email,
      "role": role,
    };
  }
}
