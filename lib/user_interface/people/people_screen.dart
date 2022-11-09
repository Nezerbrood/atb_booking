import 'package:flutter/material.dart';
import '../../constants/styles.dart';
import '../../data/dataclasses/person.dart';
import 'all_people_page.dart';
import 'my_team_page.dart';

class PeopleScreen extends StatefulWidget {
  const PeopleScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _PeopleScreenState();
  }
}

class _PeopleScreenState extends State<PeopleScreen> {
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
      theme: appThemeData,
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
          body: const TabBarView(
            children: [MyTeamPage(), AllPeoplePage()],
          ),
        ),
      ),
    );
  }
}