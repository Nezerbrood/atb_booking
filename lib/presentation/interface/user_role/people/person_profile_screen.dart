import 'package:atb_booking/data/models/booking.dart';
import 'package:atb_booking/data/models/user.dart';
import 'package:atb_booking/data/models/workspace_type.dart';
import 'package:atb_booking/logic/user_role/people_profile_bloc/people_profile_booking_bloc.dart';
import 'package:atb_booking/presentation/constants/styles.dart';
import 'package:atb_booking/presentation/interface/user_role/booking/booking_details/booking_details_screen.dart';
import 'package:atb_booking/presentation/interface/user_role/booking/booking_list/booking_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonProfileScreen extends StatelessWidget {
  final User user;
  const PersonProfileScreen(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Профиль сотрудника"),
        centerTitle: true,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(user.avatar.imageUrl,
                      alignment: Alignment.center,
                      width: 120,
                      height: 120,
                      fit: BoxFit.fill),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.fullName,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                  fontSize: 25,
                                  color: appThemeData.colorScheme.primary),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              "Логин:",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(
                                      color: Colors.black54, fontSize: 18),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                user.login,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.copyWith(
                                        color: appThemeData.colorScheme.primary,
                                        fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "email:",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(
                                      color: Colors.black54, fontSize: 18),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                user.email,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.copyWith(
                                        color: appThemeData.colorScheme.primary,
                                        fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Тел:",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(
                                      color: Colors.black54, fontSize: 18),
                            ),
                            const SizedBox(width: 34),
                            Expanded(
                              child: Text(
                                user.phone,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.copyWith(
                                        color: appThemeData.colorScheme.primary,
                                        fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          BlocConsumer<PeopleProfileBookingBloc, PeopleProfileBookingState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              return Expanded(
                child: (state is PeopleProfileBooking_LoadingState)
                    ? const Padding(
                        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ))
                    : (state is PeopleProfileBooking_LoadedState)
                        ? Padding(
                            padding:
                                const EdgeInsets.fromLTRB(10.0, 00.0, 10.0, 0),
                            child: Stack(children: <Widget>[
                              Scrollbar(
                                child: ListView.builder(
                                  controller: scrollController,
                                  itemCount: state.bookingList.length,
                                  itemBuilder: (context, index) {
                                    final item = state.bookingList[index];
                                    return GestureDetector(
                                      onTap: () {
                                        PeopleProfileBookingBloc().add(
                                            PeopleProfileBookingCardTapEvent(
                                                item.id));
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    BookingDetailsScreen()));
                                      },
                                      child: getBookingCard(
                                          state.bookingList[index],
                                          state.mapOfTypes),
                                    );
                                  },
                                ),
                              ),
                            ]),
                          )
                        : (state is PeopleProfileBooking_EmptyState)
                            ? Padding(
                                padding:
                                    EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0),
                                child: Center(
                                  child: Text(
                                    "Броней пока нет",
                                    textAlign: TextAlign.center,
                                    style: appThemeData.textTheme.titleLarge,
                                  ),
                                ))
                            : Center(
                                child: ErrorWidget(
                                    "ErrorStatePeopleProfileBookingBloc"),
                              ),
              );
            },
          )
        ],
      ),
    );
  }
}

BookingCard getBookingCard(
  Booking bookingData,
  Map<int, WorkspaceType> mapOfTypes,
) {
  return BookingCard(
      bookingData.reservationInterval,
      bookingData.workspace.type.type,
      "assets/workplacelogo.png",
      (bookingData.workspace.photos.isEmpty)
          ? null
          : bookingData.workspace.photos[0].photo);
}
