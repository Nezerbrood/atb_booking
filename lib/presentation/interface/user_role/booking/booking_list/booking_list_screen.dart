import 'package:atb_booking/data/models/booking.dart';
import 'package:atb_booking/data/models/workspace_type.dart';
import 'package:atb_booking/logic/user_role/booking/booking_list_bloc/booking_list_bloc.dart';
import 'package:atb_booking/presentation/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../booking_details/booking_details_screen.dart';
import '../new_booking/new_booking_screen.dart';
import 'booking_card_widget.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    return BlocConsumer<BookingListBloc, BookingListState>(
        listener: (context, state) {
      // TODO: implement listener
    }, builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: Center(
              child: Text(
            "Мои бронирования",
            style: appThemeData.textTheme.displayLarge?.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: appThemeData.colorScheme.onSurface),
          )),
        ),
        body: (state is BookingListLoadingState)
            ? const Padding(
                padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0),
                child: Center(
                  child: CircularProgressIndicator(),
                ))
            : (state is BookingListLoadedState)
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 00.0, 10.0, 0),
                    child: Stack(children: <Widget>[
                      Scrollbar(
                        child: ListView.builder(
                          controller: scrollController,
                          itemCount: state.bookingList.length,
                          itemBuilder: (context, index) {
                            final item = state.bookingList[index];
                            return GestureDetector(
                              onTap: () {
                                BookingListBloc().add(BookingCardTapEvent(item.id));
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const BookingDetailsScreen()));
                              },
                              child:
                                  getBookingCard(state.bookingList[index], state.mapOfTypes),
                            );
                          },
                        ),
                      ),
                    ]),
                  )
                : (state is BookingListEmptyState)
                    ? Padding(
                        padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0),
                        child: Center(
                          child: Text("Добавьте бронь с помощью кнопки ниже",textAlign: TextAlign.center,
                          style:appThemeData.textTheme.titleLarge,),
                        ))
                    : const Center(
                        child: CircularProgressIndicator(),
                      ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // NewBookingBloc().add(NewBookingReloadCitiesEvent());
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const NewBookingScreen()));
          },
          child: const Icon(Icons.add, color: Colors.white),
        ),
      );
    });
  }
}

BookingCard getBookingCard(Booking bookingData, Map<int, WorkspaceType> mapOfTypes,) {
  return BookingCard(
      bookingData.reservationInterval,
      bookingData.workspace.type.type,
      "assets/workplacelogo.png",
      (bookingData.workspace.photos.isEmpty)?null:bookingData.workspace.photos[0].photo);
}