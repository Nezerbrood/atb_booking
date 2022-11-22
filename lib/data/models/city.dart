class City {
  final int id;
  final String name;
  City({required this.id,required this.name});
  City.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'];
  City.init():
    id = -1,
    name = '';
}