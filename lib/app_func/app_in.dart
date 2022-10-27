import 'package:flutter/material.dart';
import 'package:atb_flutter_demo/user_interface/forms/HomePage.dart';

//Запускаем наше приложение
//Базовая конструкция для приложения.

//Общие классы нашего приложения.
class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Все должно быть оернуто в Material App читать доки Material App
    return MaterialApp(
      //Заголовок и тема
      title: 'ATB Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //Наше наполнение приложения - основаня страница с навигацией.
      home: Home(),
    );
  }
}