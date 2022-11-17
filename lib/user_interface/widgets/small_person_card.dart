import 'package:atb_booking/constants/styles.dart';
import 'package:flutter/material.dart';

import '../../data/dataclasses/person.dart';

class AtbSmallPersonCard extends StatefulWidget {
  final Person person;
  final int id;
  final String name;
  final String jobTitle;
  final bool isSelect;

  const AtbSmallPersonCard({super.key, required this.person, required this.id, required this.name, required this.jobTitle, required this.isSelect});

  @override
  State<StatefulWidget> createState() {
    return AtbSmallPersonCardState(person,id,name,jobTitle,isSelect);
  }
}

class AtbSmallPersonCardState extends State<AtbSmallPersonCard> {
  final Person person;
  final int id;
  final String name;
  final String jobTitle;
  bool isSelect;

  AtbSmallPersonCardState(this.person, this.id, this.name, this.jobTitle, this.isSelect);
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Card(
            semanticContainer: true,
            elevation: 1,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: RoundedRectangleBorder(
                side: BorderSide(
                    width: 1, color: appThemeData.colorScheme.tertiary),
                borderRadius: BorderRadius.circular(12.0)),
            //color: Colors.white,
            child: Center(
              child: CheckboxListTile(
                secondary: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: SizedBox(
                    width: 50,
                    height: 50,
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
                ),
                title: Text(name),
                subtitle: Text(jobTitle),
                dense: true,
                value: isSelect,
                onChanged: (bool? value) {
                  setState(() {
                    isSelect = value!;
                  });
                },
              ),
            )));
  }
}
