import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import '../dataclasses/person.dart';
import 'booking_list_tab.dart';

class PersonProfile extends StatelessWidget {
  final Person person;

  const PersonProfile(this.person, {super.key});

  @override
  Widget build(BuildContext context) {
    bool todayItemIsAdd = false;
    bool tomorrowIsAdd = false;
    bool tomorrowEnd = false;
    var bookingList = <Booking>[
      Booking(
          233,
          1,
          1,
          PLACETYPE.workPlace,
          "Рабочий стол №1",
          DateTimeRange(
              start: DateTime.now(),
              end: DateTime.utc(2229, 7, 20, 20, 18, 04))),
      Booking(
          233,
          1,
          1,
          PLACETYPE.workPlace,
          "Рабочий стол №2",
          DateTimeRange(
              start: DateTime.now(),
              end: DateTime.utc(2229, 7, 20, 20, 18, 04))),
      Booking(
          233,
          1,
          1,
          PLACETYPE.workPlace,
          "Рабочий стол №3",
          DateTimeRange(
              start: DateTime.now(),
              end: DateTime.utc(2229, 7, 20, 20, 18, 04))),
      Booking(
          233,
          1,
          1,
          PLACETYPE.workPlace,
          "Рабочий стол №4",
          DateTimeRange(
              start: DateTime.utc(2022, 10, 25, 10, 18, 04),
              end: DateTime.utc(2023, 7, 20, 20, 18, 04))),
      Booking(
          233,
          1,
          1,
          PLACETYPE.workPlace,
          "Рабочий стол №5",
          DateTimeRange(
              start: DateTime.utc(1969, 7, 20, 20, 18, 04),
              end: DateTime.utc(1969, 7, 20, 20, 18, 04))),
      Booking(
          233,
          1,
          1,
          PLACETYPE.workPlace,
          "Рабочий стол №4",
          DateTimeRange(
              start: DateTime.utc(2022, 10, 24, 10, 18, 04),
              end: DateTime.utc(2023, 7, 20, 20, 18, 04))),
      Booking(
          233,
          1,
          1,
          PLACETYPE.workPlace,
          "Рабочий стол №4",
          DateTimeRange(
              start: DateTime.utc(2022, 10, 24, 10, 18, 04),
              end: DateTime.utc(2023, 7, 20, 20, 18, 04))),
      Booking(
          233,
          1,
          1,
          PLACETYPE.workPlace,
          "Рабочий стол №4",
          DateTimeRange(
              start: DateTime.utc(2022, 10, 24, 10, 18, 04),
              end: DateTime.utc(2023, 7, 20, 20, 18, 04))),
      Booking(
          233,
          1,
          1,
          PLACETYPE.workPlace,
          "Рабочий стол №4",
          DateTimeRange(
              start: DateTime.utc(2022, 10, 24, 10, 18, 04),
              end: DateTime.utc(2023, 7, 20, 20, 18, 04))),
      Booking(
          233,
          1,
          1,
          PLACETYPE.workPlace,
          "Рабочий стол №4",
          DateTimeRange(
              start: DateTime.utc(2022, 10, 24, 10, 18, 04),
              end: DateTime.utc(2023, 7, 20, 20, 18, 04))),
      Booking(
          233,
          1,
          1,
          PLACETYPE.workPlace,
          "Рабочий стол №4",
          DateTimeRange(
              start: DateTime.utc(2022, 10, 24, 10, 18, 04),
              end: DateTime.utc(2023, 7, 20, 20, 18, 04))),
    ];
    List<ListItem> items = [];

    for (var i = 0; i < bookingList.length; i++) {
      if (bookingList[i].dateTimeRange.start.day == DateTime.now().day &&
          !todayItemIsAdd) {
        items.add(ListTitle("Сегодня"));
        items.add(BookingCard(bookingList[i].dateTimeRange,
            bookingList[i].placeName, "assets/workplacelogo.png",trailing: false));
        todayItemIsAdd = true;
      } else if (bookingList[i].dateTimeRange.start.day ==
              DateTime.now().day + 1 &&
          !tomorrowIsAdd) {
        items.add(ListTitle("Завтра"));
        items.add(BookingCard(bookingList[i].dateTimeRange,
            bookingList[i].placeName, "assets/workplacelogo.png",trailing: false));
        tomorrowIsAdd = true;
      } else if (bookingList[i].dateTimeRange.start.day ==
          DateTime.now().day + 1) {
        items.add(BookingCard(bookingList[i].dateTimeRange,
            bookingList[i].placeName, "assets/workplacelogo.png",trailing: false));
      } else {
        items.add(BookingCard(bookingList[i].dateTimeRange,
            bookingList[i].placeName, "assets/workplacelogo.png",trailing: false));
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
            bookingList[i].placeName, "assets/workplacelogo.png",trailing: false));
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Профиль сотрудника"),
        actions:  const [
          Center(child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.more_vert_sharp,size: 30,),
          ))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Card(
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
                side: BorderSide(
                    width: 1, color: Color.fromARGB(255, 200, 194, 207)),
                borderRadius: BorderRadius.circular(0.0)),
            child: Container(
              color: const Color.fromARGB(255, 255, 236, 236),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(
                          child: Column(
                        children: [
                          Text(
                            person.name.replaceAll(RegExp(" "), "\n"),
                            style: Theme.of(context).textTheme.headlineSmall,
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
                      width: 200,
                      height: 200,
                      fit: BoxFit.fill),
                ],
              ),
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
