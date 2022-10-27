import 'package:flutter/material.dart';

//заглушка для вывода инфы - динамическое построение Лист-вьюв.
final List<String> actsss = <String>['Yandex', 'Google', 'Роснефть'];
final List<String> valuta = <String>["RUB", "USD", 'RUB'];

//Стэйтлес виджет, генерится только 1 раз при запуске.
class actpage extends StatelessWidget {
  const actpage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: actsss.length,
        separatorBuilder: (BuildContext context, int index) => Divider(),
        itemBuilder: (BuildContext context, int index) {
          //Собираю красиво лист через ЛистТайтл.
          //Задаю разметку для сборки строки и внее иконки заголовки и т.д.
          return ListTile(
              title: Text(actsss[index], style:TextStyle(fontSize: 22)),
              leading: Icon(Icons.sell),
              trailing: Icon(Icons.shopping_basket),
              subtitle: Text("Валюта акции: ${valuta[index]}")
          );
        }
    );
  }
}


