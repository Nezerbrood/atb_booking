import 'level_plan.dart';

class Office {
  final int id;
  final String address;
  final int maxDuration;
  final DateTime? workStart;
  final DateTime? workEnd;
  final List<Level> levels;

  Office.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        address = json['address'],
        levels = (json['levels'] as List<dynamic>)
            .map((json) => Level.fromJson(json))
            .toList(),
        workStart = null,
        // DateTime.parse(json['workStart']),
        workEnd = null,
        //DateTime.parse(json['workEnd']),
        maxDuration = json['maxDuration'];

  Office.init()
      : id = -1,
        address = '',
        levels = [],
        maxDuration = 0,
        workStart = null,
        workEnd = null;

  Office(
      {required this.workStart,
      required this.workEnd,
      required this.id,
      required this.address,
      required this.levels,
      required this.maxDuration});
}

class OfficeListItem {
  final int id;
  final String address;

  OfficeListItem.init()
      : id = -1,
        address = '';

  OfficeListItem.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        address = json['address'];

  OfficeListItem({required this.id, required this.address});
}
