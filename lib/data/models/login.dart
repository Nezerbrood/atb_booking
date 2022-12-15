class Login {
  final int userId;
  final String type;
  final String access;
  final String refresh;

  Login({required this.userId, required this.access,required this.type, required this.refresh});

  Login.fromJson(Map<String, dynamic> json)
      : userId = json['userId'],
        type = json['role'],
        access = json['accessToken'],
        refresh = json['refreshToken'];
}
