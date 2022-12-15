class Role {
  int userId;
  String role;

  Role(this.userId, this.role);

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(json["userId"] as int, json["role"] as String);
  }
}
