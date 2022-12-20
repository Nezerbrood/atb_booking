import 'package:atb_booking/presentation/interface/app_in.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart';
void main() async {
  // можно сделать проверку для авторизации
  initializeDateFormatting();
  runApp(Application());
}
