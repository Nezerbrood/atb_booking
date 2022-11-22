import 'package:flutter/material.dart';
import '../../../data/models/person.dart';
import 'person_card_widget.dart';

class AllPeoplePage extends StatefulWidget {
  const AllPeoplePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return AllPeoplePageState();
  }
}

class AllPeoplePageState extends State<AllPeoplePage> {
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
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return PersonCard(item, item.id, item.name, item.jobTitle);
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.search, color: Colors.white),
      ),
    );
  }
}
