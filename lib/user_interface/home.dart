import 'package:flutter/material.dart';
import '../constants/styles.dart';
import 'booking/booking_list_screen.dart';
import 'people/people_screen.dart';
import 'profile/profile_screen.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedIndex = 1;
  static final List<Widget> _widgetOptions = <Widget>[
    const BookingScreen(),
    const PeopleScreen(),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  build(BuildContext context) {
    return MaterialApp(
        theme: appThemeData,
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
                  indicatorColor: appThemeData.backgroundColor,
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