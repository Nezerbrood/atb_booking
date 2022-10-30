
import 'package:atb_booking/screens/booking/booking_list_tab.dart';
import 'package:atb_booking/screens/people/people_view.dart';
import 'package:atb_booking/screens/people/person_profile_screen.dart';
import 'package:flutter/material.dart';

import 'constants/styles.dart';
import 'dataclasses/person.dart';

class Application extends StatefulWidget {
  const Application({Key? key}) : super(key: key);
  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  int selectedIndex = 1;
  static final List<Widget> _widgetOptions = <Widget>[
    const BookingListWidget(),
    const People(),
    PersonProfile(Person(1,"Алексеев Александр Александров","Заместитель деректора по воспитательной работе с джунами"))
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  build(BuildContext context) {
    return MaterialApp(
        theme: materialAppTheme,
        home: Scaffold(
          resizeToAvoidBottomInset: false,
            body: Container(
              color: Colors.green,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 00),
                child: Center(
                  child: _widgetOptions.elementAt(selectedIndex),
                ),
              ),
            ),
            bottomNavigationBar: NavigationBarTheme(
                data: NavigationBarThemeData(
                  indicatorColor: materialAppTheme.backgroundColor,
                  surfaceTintColor: Colors.lightGreen,
                ),
                child: Container(
                  color: Theme.of(context).primaryColor,
                  child: NavigationBar(
                    selectedIndex: selectedIndex,
                    onDestinationSelected: (index)=>setState(() {
                      selectedIndex = index;
                    }),
                    destinations: const [
                      NavigationDestination(icon: Icon(Icons.cases_outlined),
                        label: 'Бронирование',),
                      NavigationDestination(icon: Icon(Icons.people_outline_rounded),
                        label: 'Люди',),
                      NavigationDestination(icon: Icon(Icons.person),
                        label: 'Профиль')
                    ],
                  ),
                )
            )
        )
    );
  }
}