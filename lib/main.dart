import 'package:flutter/material.dart';

import 'presentation/user_interface/app_in.dart';

//Стандартная точка входа нашего приложения
//Вызываем функцию запуска
//Точка входа описана в отдельном файле в app_func.

void main() {
  //Парсинг JSON
  runApp(const Application());
}
