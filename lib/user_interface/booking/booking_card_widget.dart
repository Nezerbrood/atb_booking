
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

abstract class BookingListItem {
  Widget buildListTitle(BuildContext context);

  Widget buildCard(BuildContext context);
}

class BookingCard implements BookingListItem {
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
            elevation: 1,
            shape: RoundedRectangleBorder(
                side: const BorderSide(
                    width: 0.3, color: Color.fromARGB(255, 200, 194, 207)),
                borderRadius: BorderRadius.circular(12.0)),
            color: Colors.white,
            child: ListTile(
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image(
                  image: AssetImage(asset),
                ),
              ),
              title: Text(placeName),
              subtitle: Text(DateFormat('hh:mm').format(dateTimeRange.start) +
                  " - " +
                  DateFormat('hh:mm').format(dateTimeRange.end) +
                  ' ' +
                  DateFormat('dd:MM:yyyy').format(dateTimeRange.start)),
              //trailing: trailing ? Icon(Icons.cancel, color: Colors.black) : null,
            )));
  }

  @override
  Widget buildListTitle(BuildContext context) {
    return const SizedBox.shrink();
  }
}

class ListTitle implements BookingListItem {
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
