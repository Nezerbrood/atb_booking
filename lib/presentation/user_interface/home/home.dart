import 'package:atb_booking/data/services/booking_repository.dart';
import 'package:atb_booking/data/services/workspace_type_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../user_interface/booking/booking_list_bloc/booking_list_bloc.dart';
import '../../constants/styles.dart';
import '../booking/booking_list_screen.dart';
import '../people/people_screen.dart';
import '../profile/profile_screen.dart';
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
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 00),
              child: Center(
                child: MultiBlocProvider(providers: [
                  BlocProvider<BookingListBloc>(
                    lazy: false,
                    create: (context) => BookingListBloc(
                        bookingRepository: BookingRepository(),
                        workspaceTypeRepository: WorkspaceTypeRepository())
                      ..add(BookingListLoadEvent()),
                  ),
                ], child: _widgetOptions.elementAt(selectedIndex)),
              ),
            ),
            bottomNavigationBar: NavigationBarTheme(
                data: NavigationBarThemeData(
                  iconTheme: MaterialStateProperty.resolveWith((states) {
                    if (states.contains(MaterialState.selected)) {
                      return IconThemeData(
                        color: Colors.white,
                      );
                    } else {
                      return IconThemeData(color: appThemeData.primaryColor);
                    }
                  }),
                  indicatorColor: appThemeData.primaryColor,
                  //surfaceTintColor: Colors.lightGreen,
                ),
                child: Container(
                  color: appThemeData.colorScheme.secondary,
                  child: NavigationBar(
                    selectedIndex: selectedIndex,
                    onDestinationSelected: (index) => setState(() {
                      selectedIndex = index;
                    }),
                    destinations: const [
                      NavigationDestination(
                        icon: Icon(Icons.cases_outlined),
                        label: 'Бронирование',
                      ),
                      NavigationDestination(
                        icon: Icon(Icons.people_outline_rounded),
                        label: 'Люди',
                      ),
                      NavigationDestination(
                          icon: Icon(Icons.person), label: 'Профиль')
                    ],
                  ),
                ))));
  }
}
