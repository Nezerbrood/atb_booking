
import 'package:flutter/material.dart';

import '../../dataclasses/person.dart';
import 'person_profile_screen.dart';

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
                elevation: 1,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                        width: 1, color: Color.fromARGB(255, 200, 194, 207)),
                    borderRadius: BorderRadius.circular(12.0)),
                //color: Colors.white,
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
