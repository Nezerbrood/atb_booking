import 'package:atb_booking/data/dataclasses/workspace.dart';
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

Workspace workspace = Workspace(
  id: 1,
  isActive: true,
  levelId: 1,
  name: "Рабочий стол 1",
  numberOfWorkspaces: 1,
  typeId: 1,
  positionOnPlan: {"x": 1, "y": 2},
);

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
          start: DateTime.now().add(Duration(days: 1)),
          end: DateTime.utc(2229, 7, 20, 20, 18, 04)),
      workspace: workspace,
      level: 1,
    ),
    Booking(
      id: 1,
      cityAddress: "Владивосток",
      officeAddress: "Ул пушкина, дом колотушкина",
      dateTimeRange: DateTimeRange(
          start: DateTime.now().add(Duration(days: 31)),
          end: DateTime.utc(2229, 7, 20, 20, 18, 04)),
      workspace: workspace,
      level: 1,
    )
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
            bookingList[i].workspace.name, "assets/workplacelogo.png","assets/workplace.png"));
        todayItemIsAdd = true;
      } else if (bookingList[i].dateTimeRange.start.day ==
              DateTime.now().day + 1 &&
          !tomorrowIsAdd) {
        items.add(ListTitle("Завтра"));
        items.add(BookingCard(bookingList[i].dateTimeRange,
            bookingList[i].workspace.name, "assets/workplacelogo.png","assets/workplace.png"));
        tomorrowIsAdd = true;
      } else if (bookingList[i].dateTimeRange.start.day ==
          DateTime.now().day + 1) {
        items.add(BookingCard(bookingList[i].dateTimeRange,
            bookingList[i].workspace.name, "assets/workplacelogo.png","assets/workplace.png"));
      } else {
        items.add(BookingCard(bookingList[i].dateTimeRange,
            bookingList[i].workspace.name, "assets/workplacelogo.png","assets/workplace.png"));
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
            bookingList[i].workspace.name, "assets/workplacelogo.png","assets/workplace.png"));
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
          "Мои брони",
          style: appThemeData.textTheme.displayLarge?.copyWith(
              fontSize: 34,
              fontWeight: FontWeight.w500,
              color: appThemeData.colorScheme.onSurface),
        )),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
        child: Stack(children: <Widget>[
          Scrollbar(
            child: ListView.builder(
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
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const NewBookingScreen()));
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
