import 'package:flutter/material.dart';

import '../constants/styles.dart';
import '../router/app_router.dart';
class Application extends StatelessWidget {
  Application({Key? key}) : super(key: key);
  final AppRouter _appRouter = AppRouter();

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //Заголовок и тема
      title: 'ATB Flutter Demo',
      theme: appThemeData,
      // initialRoute: jwt == null ? "login" : "/",  /*******/
      onGenerateRoute: _appRouter.onGenerateRoute,
    );
  }
}
