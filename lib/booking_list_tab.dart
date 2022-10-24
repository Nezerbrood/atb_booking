import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'dart:io';

import 'new_booking.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}

enum PLACETYPE {
  meetingRoom,
  workPlace,
}

class Booking {
  int officeId;
  int level;
  int placeId;
  PLACETYPE placeType;
  String placeName;
  DateTimeRange dateTimeRange;

  Booking(this.officeId, this.level, this.placeId, this.placeType,
      this.placeName, this.dateTimeRange);
}

class BookingListWidget extends StatefulWidget {
  const BookingListWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return _BookingListWidgetState();
  }
}

class _BookingListWidgetState extends State<BookingListWidget> {
  var bookingList = <Booking>[
    Booking(
        233,
        1,
        1,
        PLACETYPE.workPlace,
        "Рабочий стол №1",
        DateTimeRange(
            start: DateTime.now(), end: DateTime.utc(2229, 7, 20, 20, 18, 04))),
    Booking(
        233,
        1,
        1,
        PLACETYPE.workPlace,
        "Рабочий стол №2",
        DateTimeRange(
            start: DateTime.now(), end: DateTime.utc(2229, 7, 20, 20, 18, 04))),
    Booking(
        233,
        1,
        1,
        PLACETYPE.workPlace,
        "Рабочий стол №3",
        DateTimeRange(
            start: DateTime.now(), end: DateTime.utc(2229, 7, 20, 20, 18, 04))),
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

  @override
  void initState() {
    bool todayItemIsAdd = false;
    bool tomorrowIsAdd = false;
    bool tomorrowEnd = false;
    for (var i = 0; i < bookingList.length; i++) {
      if (bookingList[i].dateTimeRange.start.day == DateTime.now().day &&
          !todayItemIsAdd) {
        items.add(ListTitle("Сегодня"));
        items.add(BookingCard(bookingList[i].dateTimeRange,
            bookingList[i].placeName, "assets/workplacelogo.png"));
        todayItemIsAdd = true;
      } else if (bookingList[i].dateTimeRange.start.day ==
              DateTime.now().day + 1 &&
          !tomorrowIsAdd) {
        items.add(ListTitle("Завтра"));
        items.add(BookingCard(bookingList[i].dateTimeRange,
            bookingList[i].placeName, "assets/workplacelogo.png"));
        tomorrowIsAdd = true;
      } else if (bookingList[i].dateTimeRange.start.day ==
          DateTime.now().day + 1) {
        items.add(BookingCard(bookingList[i].dateTimeRange,
            bookingList[i].placeName, "assets/workplacelogo.png"));
      } else {
        items.add(BookingCard(bookingList[i].dateTimeRange,
            bookingList[i].placeName, "assets/workplacelogo.png"));
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
            bookingList[i].placeName, "assets/workplacelogo.png"));
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScrollController _scrollController = ScrollController();
    var atbLogo = const ATBLogo();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 0),
        child: Stack(children: <Widget>[
          atbLogo,
          ListView.builder(
            controller: _scrollController,
            itemCount: items.length,
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
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const NewBooking()));
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

abstract class ListItem {
  Widget buildListTitle(BuildContext context);

  Widget buildCard(BuildContext context);
}

class BookingCard implements ListItem {
  final DateTimeRange dateTimeRange;
  final String placeName;
  final String asset;
  bool trailing = true;

  BookingCard(this.dateTimeRange, this.placeName, this.asset,
      {this.trailing = true});

  @override
  Widget buildCard(BuildContext context) {
    return Center(
        child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
                side: const BorderSide(
                    width: 1, color: Color.fromARGB(255, 200, 194, 207)),
                borderRadius: BorderRadius.circular(12.0)),
            color: Colors.white,
            child: ListTile(
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image(image: AssetImage(asset)),
              ),
              title: Text(placeName),
              subtitle: Text(DateFormat('hh:mm').format(dateTimeRange.start) +
                  " - " +
                  DateFormat('hh:mm').format(dateTimeRange.end) +
                  ' ' +
                  DateFormat('dd:MM:yyyy').format(dateTimeRange.start)),
              trailing:
                  trailing ? Icon(Icons.cancel, color: Colors.black) : null,
            )));
  }

  @override
  Widget buildListTitle(BuildContext context) {
    return const SizedBox.shrink();
  }
}

class ListTitle implements ListItem {
  final String message;

  ListTitle(this.message);

  @override
  Widget buildCard(BuildContext context) {
    return const SizedBox.shrink();
  }

  @override
  Widget buildListTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: Align(
          alignment: Alignment.bottomRight,
          child: Text(
            message,
            style: Theme.of(context).textTheme.headlineMedium,
          )),
    );
  }
}

class ATBLogo extends StatefulWidget {
  const ATBLogo({super.key});

  @override
  State<StatefulWidget> createState() {
    return ATBLogoState();
  }
}

class ATBLogoState extends State<ATBLogo> {
  bool logoshow = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 33.0, horizontal: 3.5),
      child: Text("ATB-BOOKING",
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: Colors.red, fontSize: 36)),
    );
  }
}
