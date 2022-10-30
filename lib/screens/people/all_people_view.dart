
import 'package:flutter/material.dart';

import '../../dataclasses/person.dart';
import 'person_card_widget.dart';

class AllPeopleView extends StatefulWidget {
  const AllPeopleView({super.key});

  @override
  State<StatefulWidget> createState() {
    return AllPeopleViewState();
  }
}

class AllPeopleViewState extends State<AllPeopleView> {
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
        onPressed: () {
        },
        child: const Icon(Icons.search, color: Colors.white),
      ),
    );
  }
}
