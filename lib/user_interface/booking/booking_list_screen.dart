import 'package:atb_booking/util/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'dart:io';
import '../../constants/styles.dart';
import '../../data/dataclasses/booking.dart';
import 'booking_card_widget.dart';
import 'booking_details_screen.dart';
import 'new_booking_screen.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _BookingScreenState();
  }
}

class _BookingScreenState extends State<BookingScreen> {
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
  List<BookingListItem> items = [];

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
    ScrollController scrollController = ScrollController();
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          "ATB BOOKING",
          style: appThemeData.textTheme.displayLarge?.copyWith(
              fontSize: 34,
              fontWeight: FontWeight.w500,
              color: appThemeData.colorScheme.onSurface),
        )),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
        child: Stack(children: <Widget>[
          ListView.builder(
            controller: scrollController,
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => BookingDetailsScreen()));
                },
                child: Column(
                  children: [
                    item.buildListTitle(context),
                    item.buildCard(context)
                  ],
                ),
              );
            },
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const NewBookingScreen()));
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}