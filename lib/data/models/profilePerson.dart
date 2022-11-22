class profilePerson {
  String firstName;
  String lastName;
  String maidenName;
  String email;
  String number;

  profilePerson(
      this.firstName, this.lastName, this.maidenName, this.email, this.number);

  factory profilePerson.fromJson(Map<String, dynamic> json) {
    return profilePerson(
        json['firstName'] as String,
        json["lastName"] as String,
        json["maidenName"] as String,
        json["email"] as String,
        json["phone"] as String);
  }
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "firstName": firstName,
      "lastName": lastName,
      "maidenName": maidenName,
      "email": email,
      "number": number
    };
  }
}
