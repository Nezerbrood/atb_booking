import 'package:atb_booking/logic/admin_role/offices/LevelPlanEditor/level_plan_editor_bloc.dart';
import 'package:atb_booking/logic/admin_role/offices/new_office_page/new_office_page_bloc.dart';
import 'package:atb_booking/logic/admin_role/offices/offices_screen/admin_offices_bloc.dart';
import 'package:atb_booking/logic/admin_role/offices/office_page/admin_office_page_bloc.dart';
import 'package:atb_booking/logic/admin_role/people/admin_people_bloc.dart';
import 'package:atb_booking/presentation/constants/styles.dart';
import 'package:atb_booking/presentation/interface/admin_role/feedback/feedback_screen.dart';
import 'package:atb_booking/presentation/interface/admin_role/offices/offices_list_screen.dart';
import 'package:atb_booking/presentation/interface/admin_role/people/people_screen.dart';
import 'package:atb_booking/presentation/interface/admin_role/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  State<AdminHome> createState() => _HomeState();
}

class _HomeState extends State<AdminHome> {
  int selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    const AdminOfficesScreen(),
    const AdminPeopleScreen(),
    const AdminFeedbackScreen(),
    const AdminProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  build(BuildContext context) {
    return MaterialApp(
        theme: appThemeData,
        home: MultiBlocProvider(
          providers: [
            BlocProvider<AdminOfficesBloc>(
              create: (context) => AdminOfficesBloc(),
            ),
            BlocProvider<AdminPeopleBloc>(
              create: (context) => AdminPeopleBloc(),
            ),
            BlocProvider<AdminOfficePageBloc>(
              create: (context) => AdminOfficePageBloc(),
            ),
            BlocProvider<NewOfficePageBloc>(
                          create: (context){
                            return NewOfficePageBloc();},
                        ),
            BlocProvider<LevelPlanEditorBloc>(
              create: (context)=>LevelPlanEditorBloc(),
            )
          ],
          child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 00),
                child: Center(
                  child: _widgetOptions.elementAt(selectedIndex),
                ),
              ),
              bottomNavigationBar: NavigationBarTheme(
                  data: NavigationBarThemeData(
                    iconTheme: MaterialStateProperty.resolveWith((states) {
                      if (states.contains(MaterialState.selected)) {
                        return const IconThemeData(
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
                          icon: Icon(Icons.apartment_rounded),
                          label: 'Офисы',
                        ),
                        NavigationDestination(
                          icon: Icon(Icons.people_outline_rounded),
                          label: 'Люди',
                        ),
                        NavigationDestination(
                          icon: Icon(Icons.feed),
                          label: 'Фидбек',
                        ),
                        NavigationDestination(
                            icon: Icon(Icons.person), label: 'Профиль')
                      ],
                    ),
                  ))),
        ));
  }
}
