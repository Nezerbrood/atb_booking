import 'dart:async';

import 'package:atb_booking/data/models/booking.dart';
import 'package:atb_booking/data/models/user.dart';
import 'package:atb_booking/data/services/booking_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'admin_person_booking_list_event.dart';
part 'admin_person_booking_list_state.dart';

class AdminPersonBookingListBloc extends Bloc<AdminPersonBookingListEvent, AdminPersonBookingListState> {
  final User user;
  List<Booking>bookingList = [];
  AdminPersonBookingListBloc(this.user) : super(AdminPersonBookingListLoadingState()) {
    on<AdminPersonBookingLoadBookingsEvent>((event,emit) async {
      emit(AdminPersonBookingListLoadingState());
      try{
        bookingList = await BookingRepository().getBookingsByUserId(user.id);
        emit(AdminPersonBookingListLoadedState(user,bookingList));
      }catch(_){
        emit(AdminPersonBookingListErrorState());
      }
    });
    add(AdminPersonBookingLoadBookingsEvent());
  }
}
