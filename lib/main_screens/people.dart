import 'package:atb_booking/main_screens/person_profile.dart';
import 'package:flutter/material.dart';

import '../dataclasses/person.dart';
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
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: TabBarView(
              children: [
                ListView.builder(
                    itemCount: items.length+1,
                    itemBuilder: (context, index) {
                      if(index==0){
                        return TeamCard();
                      }else{
                        final item = items[index-1];
                        return PersonCard(item, item.id, item.name, item.jobTitle);
                      }

                    }),
                ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return PersonCard(item, item.id, item.name, item.jobTitle);
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TeamCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Image.asset("assets/team_card.png",alignment: Alignment.center,
              fit: BoxFit.fill),
          Container(
            padding: EdgeInsets.all(10),
            width: double.infinity,
            child: Text(
              "Team Cringers",
              style: Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.copyWith(color: Colors.black),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            width: double.infinity,
            child: Text(
              "Офис: г. Владивосток, ул Алеутская 24",
              style: Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.copyWith(color: Colors.black45),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            width: double.infinity,
            child: Text(
              "Мы делаем вид что работаем в банке, но на самом деле мы скрываемся от миграционной полиции, чтобы нас не отправили назад в Уганду",
              style: Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.copyWith(color: Colors.black54),
            ),
          )
        ],
      ),
    );
  }

}

class PersonCard extends StatelessWidget {
  final Person person;
  final int id;
  final String name;
  final String jobTitle;

  const PersonCard(this.person, this.id, this.name, this.jobTitle, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PersonProfile(person),
                ),
              );
            },
            child: Card(
            semanticContainer: true,
            elevation: 5,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
        side: BorderSide(
        width: 1, color: Color.fromARGB(255, 200, 194, 207)),
    borderRadius: BorderRadius.circular(12.0)),
    color: Colors.white,
    child: Row(
    children: <Widget>[
    Image.network("https://i.pravatar.cc/200?img=$id",
    alignment: Alignment.center,
    width: 85,
    height: 85,
    fit: BoxFit.fill),
    Expanded(
    child: ListTile(
    title: Text(name),
    subtitle: Text(jobTitle),
    trailing:
    const Icon(Icons.more_vert, color: Colors.black),
    dense: true,
    minLeadingWidth: 100,
    ))
    ],
    ))));
  }
}
