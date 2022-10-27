import 'package:flutter/material.dart';

final List<String> actsss = <String>['Yandex', 'Google', 'Роснефть'];
final List<String> valuta = <String>["RUB", "USD", 'RUB'];

class settingpage extends StatelessWidget {
  const settingpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Тут Могут быть настройки...",
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
    ));
  }
}
