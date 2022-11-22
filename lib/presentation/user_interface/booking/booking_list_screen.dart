import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../user_interface/booking/booking_list_bloc/booking_list_bloc.dart';
import '../../../user_interface/booking_details/booking_details_screen.dart';
import '../../../user_interface/new_booking/new_booking_screen.dart';
import '../../constants/styles.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    return BlocConsumer<BookingListBloc, BookingListState>(
        listener: (context, state) {
      // TODO: implement listener
    }, builder: (context, state) {
      print("state is: " + state.toString());
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
                          itemCount: state.loadedList.length,
                          itemBuilder: (context, index) {
                            final item = state.loadedList[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        BookingDetailsScreen()));
                              },
                              child: Column(
                                children: [
                                  //item
                                  item.buildListTitle(context),
                                  item.buildCard(context)
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ]),
                  )
                : (state is BookingListEmptyState)
                    ? const Padding(
                        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0),
                        child: Center(
                          child: Text("Добавьте бронь с помощью кнопки ниже"),
                        ))
                    : Center(
                        child: ErrorWidget("ErrorStateBookingListBloc"),
                      ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => NewBookingScreen()));
          },
          child: const Icon(Icons.add, color: Colors.white),
        ),
      );
    });
  }
}
