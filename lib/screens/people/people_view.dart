
import 'package:atb_booking/screens/people/all_people_view.dart';
import 'package:atb_booking/screens/people/my_team_view.dart';
import 'package:flutter/material.dart';

import '../../dataclasses/person.dart';
class People extends StatefulWidget {
  const People({super.key});

  @override
  State<StatefulWidget> createState() {
    return _PeopleState();
  }
}

class _PeopleState extends State<People> {
  List<Person> items = [
    Person(
      1,
      "Алексеев Александр Александров",
      "Менеджер по подбору персонала",
    ),
    Person(
      2,
      "Алексеев Александр Александров",
      "Менеджер по подбору персонала",
    ),
    Person(
      3,
      "Алексеев Александр Александров",
      "Менеджер по подбору персонала",
    ),
    Person(
      4,
      "Алексеев Александр Александров",
      "Менеджер по подбору персонала",
    ),
    Person(
      5,
      "Алексеев Александр Александров",
      "Менеджер по подбору персонала",
    ),
    Person(
      6,
      "Алексеев Александр Александров",
      "Менеджер по подбору персонала",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Theme.of(context).copyWith(
        cardTheme: Theme.of(context).cardTheme.copyWith(
          color: const Color.fromARGB(255, 248, 240, 240),
        ),
        primaryColor: const Color.fromARGB(255, 252, 79, 1),
        backgroundColor: Colors.white,
        useMaterial3: true,
        colorScheme: const ColorScheme(
          primary: Color.fromARGB(255, 252, 79, 1),
          secondary: Color.fromARGB(255, 252, 79, 1),
          brightness: Brightness.light,
          onPrimary: Color.fromARGB(255, 252, 79, 1),
          onSecondary: Color.fromARGB(255, 252, 79, 1),
          background: Colors.white,
          error: Colors.red,
          onError: Colors.black,
          onBackground: Colors.black,
          surface: Color.fromARGB(255, 252, 79, 1),
          onSurface: Colors.white,
        ),
      ),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50.0), // here the desired height
            child: AppBar(
              bottom: const TabBar(
                tabs: [
                  Tab(text: "Моя команда"),
                  Tab(text: "Все сотрудники"),
                ],
              ),
            ),
          ),
          body: TabBarView(
            children: [
              MyTeamView(),
              AllPeopleView()
            ],
          ),
        ),
      ),
    );
  }
}