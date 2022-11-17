import 'package:atb_booking/constants/styles.dart';
import 'package:flutter/material.dart';

import '../../data/dataclasses/person.dart';
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
                  builder: (context) => PersonProfileScreen(person),
                ),
              );
            },
            child: Card(
                semanticContainer: true,
                elevation: 1,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                        width: 1, color: appThemeData.colorScheme.tertiary),
                    borderRadius: BorderRadius.circular(12.0)),
                //color: Colors.white,
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ClipOval(
                        child: Image.network(
                          "https://i.pravatar.cc/200?img=$id",
                          alignment: Alignment.center,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
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
