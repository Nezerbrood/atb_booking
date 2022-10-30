import 'package:atb_booking/screens/people/person_card_widget.dart';
import 'package:flutter/cupertino.dart';
import '../../dataclasses/person.dart';
import 'team_card_widget.dart';

class MyTeamView extends StatefulWidget {
  const MyTeamView({super.key});

  @override
  State<StatefulWidget> createState() {
    return TeamViewState();
  }
}
class TeamViewState extends State<MyTeamView> {
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: ListView.builder(
          itemCount: items.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return const TeamCard();
            } else {
              final item = items[index - 1];
              return PersonCard(item, item.id, item.name, item.jobTitle);
            }
          }),
    );
  }
}
