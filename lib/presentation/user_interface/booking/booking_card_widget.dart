import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../constants/styles.dart';

abstract class BookingListItem {
  Widget buildListTitle(BuildContext context);

  Widget buildCard(BuildContext context);
}

class BookingCard implements BookingListItem {
  final DateTimeRange dateTimeRange;
  final String placeName;
  final String asset;
  final String image;
  bool trailing = true;

  BookingCard(this.dateTimeRange, this.placeName, this.asset, this.image,
      {this.trailing = true});

  @override
  Widget buildCard(BuildContext context) {
    return Center(
        child: Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            elevation: 1,
            shape: RoundedRectangleBorder(
                side: const BorderSide(
                    width: 0.3, color: Color.fromARGB(255, 200, 194, 207)),
                borderRadius: BorderRadius.circular(12.0)),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: Text(
                      placeName,
                      style: appThemeData.textTheme.titleMedium,
                    ),
                    subtitle: Text(
                      'c ' +
                          DateFormat('hh:mm').format(dateTimeRange.start) +
                          " до " +
                          DateFormat('hh:mm').format(dateTimeRange.end) +
                          '\n' +
                          DateFormat.yMMMMd("ru_RU").format(dateTimeRange.start),
                      style: appThemeData.textTheme.titleMedium,
                    ),
                    //trailing: trailing ? Icon(Icons.cancel, color: Colors.black) : null,
                  ),
                ),
                Image.asset("assets/workplace.png",
                    alignment: Alignment.center,
                    width: 120,
                    height: 120,
                    fit: BoxFit.fill)
              ],
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
      padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
      child: Align(
          alignment: Alignment.bottomRight,
          child: Text(
            message,
            style: Theme.of(context).textTheme.headlineMedium,
          )),
    );
  }
}
