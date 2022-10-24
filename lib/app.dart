import 'package:atb_booking/people.dart';
import 'package:atb_booking/person_profile.dart';
import 'package:flutter/material.dart';
import 'booking_list_tab.dart';
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
    ThemeData appTheme = Theme.of(context).copyWith(
      cardTheme: Theme.of(context).cardTheme.copyWith(
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
    );
    return MaterialApp(
        theme: appTheme,
        home: Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 00),
              child: Center(
                child: _widgetOptions.elementAt(selectedIndex),
              ),
            ),
            bottomNavigationBar: NavigationBarTheme(
                data: NavigationBarThemeData(
                  indicatorColor: appTheme.backgroundColor,
                ),
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
                )
            )
        )
    );
  }
}