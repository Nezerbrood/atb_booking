import 'package:atb_booking/logic/user_role/booking/booking_details_bloc/booking_delete_confirmation_bloc.dart';
import 'package:atb_booking/logic/user_role/booking/booking_list_bloc/booking_list_bloc.dart';
import 'package:atb_booking/presentation/constants/styles.dart';
import 'package:atb_booking/presentation/widgets/elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class BookingDeleteConfirmationPopup extends StatelessWidget {
  const BookingDeleteConfirmationPopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(vertical: 250),
      content: BlocConsumer<BookingDeleteConfirmationBloc,
          BookingDeleteConfirmationState>(builder: (context, state) {
        if (state is BookingDeleteConfirmationLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is BookingDeleteConfirmationErrorState) {
          return Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "Упс, что-то пошло не так...",
                textAlign: TextAlign.center,
                style: appThemeData.textTheme.titleLarge!.copyWith(
                    color: const Color.fromARGB(255, 49, 41, 0), fontSize: 30),
              ),
              AtbElevatedButton(
                  onPressed: () {
                    var popCounter = 2;
                    Navigator.of(context).popUntil((route) {
                      if (popCounter > 0) {
                        popCounter--;
                        return false;
                      }
                      return true;
                    });
                    // Navigator.of(context).push(
                    //     MaterialPageRoute(builder: (context) => NewBookingScreen()));
                    ///back to BookingListScreen
                  },
                  text: "Назад"),
            ],
          ));
        }
        if (state is BookingDeleteConfirmationSuccessState) {
          return Center(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Бронь\n отменена",
                    textAlign: TextAlign.center,
                    style: appThemeData.textTheme.titleLarge!.copyWith(
                        color: const Color.fromARGB(255, 0, 82, 11), fontSize: 30),
                  ),
                  AtbElevatedButton(
                      onPressed: () {
                        BookingListBloc().add(BookingListLoadEvent());
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);

                        ///back to BookingListScreen
                      },
                      text: "К списку броней")
                ],
              ),
            ),
          );
        } else {
          throw Exception("Bad BookingDeleteConfirmationState");
        }
      }, listener: (context, state) {
        // TODO: implement listener
      }),
    );
  }
}
