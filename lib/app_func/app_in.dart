
import 'package:atb_booking/constants/styles.dart';
import 'package:atb_booking/user_interface/auth/auth_screen.dart';
import 'package:flutter/material.dart';
import '../user_interface/home.dart';

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
      theme: appThemeData,
      routes: {
        '/auth': (context) => const Auth(),
        '/home':(context) => const Home(),
      },
      //Наше наполнение приложения - основаня страница с навигацией.
      initialRoute: '/home',
    );
  }
}