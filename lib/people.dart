import 'package:atb_booking/person_profile.dart';
import 'package:flutter/material.dart';
import 'dataclasses/person.dart';

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
        cardTheme: Theme
            .of(context)
            .cardTheme
            .copyWith(
          color: const Color.fromARGB(255, 248, 240, 240),
        ),
        primaryColor: const Color.fromARGB(255, 239, 89, 90),
        backgroundColor: Colors.white,
        useMaterial3: true,
        colorScheme: const ColorScheme(
          primary: Color.fromARGB(255, 239, 89, 90),
          secondary: Color.fromARGB(255, 239, 89, 90),
          brightness: Brightness.light,
          onPrimary: Color.fromARGB(255, 239, 89, 90),
          onSecondary: Color.fromARGB(255, 239, 89, 90),
          background: Colors.white,
          error: Colors.red,
          onError: Colors.black,
          onBackground: Colors.black,
          surface: Color.fromARGB(255, 232, 76, 83),
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
            padding: const EdgeInsets.all(10.0),
            child: TabBarView(
              children: [
                ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return PersonCard(item, item.id, item.name, item.jobTitle);
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
