import 'package:flutter/material.dart';
import '../../../data/models/booking.dart';
import '../../../data/models/person.dart';
import '../../../data/models/workspace.dart';
import '../booking/booking_card_widget.dart';

Workspace workspace =
    Workspace(1, 1, 'description', true, 20, 20, 1, 1, [], 40, 40);

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
            start: DateTime.now().add(Duration(days: 1)),
            end: DateTime.utc(2229, 7, 20, 20, 18, 04)),
        workspace: workspace,
        level: 1,
      )
    ];
    List<BookingListItem> items = [];

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
