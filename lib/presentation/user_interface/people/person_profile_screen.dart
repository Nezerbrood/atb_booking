import 'dart:io';
import 'package:atb_booking/util/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../data/models/workspace.dart';
import '../../../data/models/booking.dart';
import '../../../data/models/person.dart';
import 'package:intl/date_symbol_data_local.dart';
import '../booking/booking_card_widget.dart';



Workspace workspace = Workspace(
  id: 1,
  isActive: true,
  levelId: 1,
  name: "Рабочий стол 1",
  numberOfWorkspaces: 1, typeId: 1,
  positionOnPlan: {"x":1,"y":2},
);


class PersonProfileScreen extends StatelessWidget {
  final Person person;

  const PersonProfileScreen(this.person, {super.key});

  @override
  Widget build(BuildContext context) {
    bool todayItemIsAdd = false;
    bool tomorrowIsAdd = false;
    bool tomorrowEnd = false;
    var bookingList = <Booking>[
      Booking(
        id: 1,
        cityAddress: "Владивосток",
        officeAddress: "Ул пушкина, дом колотушкина",
        dateTimeRange: DateTimeRange(
            start: DateTime.now(), end: DateTime.utc(2229, 7, 20, 20, 18, 04)),
        workspace: workspace,
        level: 1,
      ),
      Booking(
        id: 1,
        cityAddress: "Владивосток",
        officeAddress: "Ул пушкина, дом колотушкина",
        dateTimeRange: DateTimeRange(
            start: DateTime.now().add(Duration(days: 1)), end: DateTime.utc(2229, 7, 20, 20, 18, 04)),
        workspace: workspace,
        level: 1,
      )
    ];
    List<BookingListItem> items = [];

    for (var i = 0; i < bookingList.length; i++) {
      if (bookingList[i].dateTimeRange.start.day == DateTime.now().day &&
          !todayItemIsAdd) {
        items.add(ListTitle("Сегодня"));
        items.add(BookingCard(bookingList[i].dateTimeRange,
            bookingList[i].workspace.name, "assets/workplacelogo.png","assets/workplace.png"));
        todayItemIsAdd = true;
      } else if (bookingList[i].dateTimeRange.start.day ==
              DateTime.now().day + 1 &&
          !tomorrowIsAdd) {
        items.add(ListTitle("Завтра"));
        items.add(BookingCard(bookingList[i].dateTimeRange,
            bookingList[i].workspace.name, "assets/workplacelogo.png",
            "assets/workplace.png"));
        tomorrowIsAdd = true;
      } else if (bookingList[i].dateTimeRange.start.day ==
          DateTime.now().day + 1) {
        items.add(BookingCard(bookingList[i].dateTimeRange,
            bookingList[i].workspace.name, "assets/workplacelogo.png",
            'assets/workplace.png'));
      } else {
        items.add(BookingCard(bookingList[i].dateTimeRange,
            bookingList[i].workspace.name, "assets/workplacelogo.png",
            "assets/workplace.png"));
      }
      if (bookingList[i].dateTimeRange.start.day != DateTime.now().day &&
          tomorrowEnd == false) {
        tomorrowEnd = true;
        initializeDateFormatting();
        items.add(ListTitle(DateFormat.MMMM(Platform.localeName)
            .format(bookingList[i].dateTimeRange.start)
            .capitalize()));
      } else {
        items.add(BookingCard(bookingList[i].dateTimeRange,
            bookingList[i].workspace.name, "assets/workplacelogo.png",
            "assets/workplace.png"));
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Профиль сотрудника"),
        actions: const [
          Center(
              child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.more_vert_sharp,
              size: 30,
            ),
          ))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Card(
            margin: EdgeInsets.zero,
            elevation: 1,
            shape: RoundedRectangleBorder(
                side: const BorderSide(width: 0.2, color: Colors.black38),
                borderRadius: BorderRadius.circular(0.0)),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                        child: Column(
                      children: [
                        Text(
                          person.name.replaceAll(RegExp(" "), "\n"),
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(fontSize: 20),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          person.jobTitle,
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(color: Colors.black54),
                        )
                      ],
                    )),
                  ),
                ),
                Image.network("https://i.pravatar.cc/200?img=1",
                    alignment: Alignment.center,
                    width: 160,
                    height: 160,
                    fit: BoxFit.fill),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Center(
                child: ListView.builder(
                  // Let the ListView know how many items it needs to build.
                  itemCount: items.length,
                  // Provide a builder function. This is where the magic happens.
                  // Convert each item into a widget based on the type of item it is.
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return Column(
                      children: [
                        item.buildListTitle(context),
                        item.buildCard(context)
                      ],
                    );
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
