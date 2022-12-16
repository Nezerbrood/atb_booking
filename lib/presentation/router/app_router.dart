
import 'package:atb_booking/presentation/interface/admin_role/adminHome.dart';
import 'package:atb_booking/presentation/interface/admin_role/offices/level_editor.dart';
import 'package:atb_booking/presentation/interface/auth/auth_screen.dart';
import 'package:atb_booking/presentation/interface/user_role/home/home.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/adminHome':
        return MaterialPageRoute(builder: (_) => const LevelEditor());
      case '/home':
        return MaterialPageRoute(builder: (_) => const Home());
      case '/auth':
        return MaterialPageRoute(builder: (_) => const Auth());

      default:
        return MaterialPageRoute(builder: (_) => const Auth());
    }
  }
}
