import 'package:atb_booking/data/models/feedback.dart';
import 'package:atb_booking/presentation/constants/styles.dart';
import 'package:flutter/material.dart';

class FeedbackCard extends StatelessWidget {
  FeedbackItem feedbackItem;
  FeedbackCard(this.feedbackItem, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: GestureDetector(
            onTap: () async {
              // PeopleProfileBookingBloc()
              //     .add(PeopleProfileBookingLoadEvent(id: user.id));
              // await Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (context) => PersonProfileScreen(user),
              //   ),
              // );
            },
            child: Card(
              semanticContainer: true,
              elevation: 1,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                  side: BorderSide(
                      width: 1, color: appThemeData.colorScheme.tertiary),
                  borderRadius: BorderRadius.circular(12.0)),
              child: Column(children: [
                ListTile(
                  title: Text(feedbackItem.date,
                      style: appThemeData.textTheme.titleMedium),
                  subtitle: Text(
                    "User id: ${feedbackItem.id.toString()}",
                    style: appThemeData.textTheme.titleSmall,
                  ),
                  trailing: Text(feedbackItem.id.toString(),
                      style: appThemeData.textTheme.titleMedium),
                ),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  alignment: Alignment.centerLeft,
                  child: Text(feedbackItem.comment),
                )
              ]),
            )));
  }
}
