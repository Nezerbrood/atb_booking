import 'package:flutter/material.dart';

final List<String> actsss = <String>['Yandex', 'Google', 'Роснефть'];
final List<String> valuta = <String>["RUB", "USD", 'RUB'];

class profilpage extends StatelessWidget {
  const profilpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Соберем эту страницу через центр
    //При этмо оберем ее в column and rows
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Тут инфо - профиль",
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
          ),
          const Text(
            "И что-то еще...",
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Добавлю отступы для 1 кнопки, чтобы не слипалась со 2.
              Padding(
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(

                    //Сюда кормим функцию по нажатию кнопки...
                    onPressed: () => sypfunc(),
                    child: const Text('Кнопка запуска асинхрона')),
              ),
              ElevatedButton(

                  //Сюда кормим функцию по нажатию кнопки...
                  onPressed: () => print("Button Event!"),
                  child: const Text('Линк')),
            ],
          ),
        ],
      ),
    );
  }
}

void sypfunc() async {


  //Прогресс бар

  // await


  
  //Возврат данных.
}
