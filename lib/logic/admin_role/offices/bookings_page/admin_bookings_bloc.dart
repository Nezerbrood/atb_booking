import 'dart:async';

import 'package:atb_booking/data/models/booking.dart';
import 'package:atb_booking/data/services/booking_repository.dart';
import 'package:atb_booking/logic/admin_role/people/admin_people_bloc.dart';
import 'package:atb_booking/logic/secure_storage_api.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'admin_bookings_event.dart';

part 'admin_bookings_state.dart';

class AdminBookingsBloc extends Bloc<AdminBookingsEvent, AdminBookingsState> {
  DateTimeRange? _selectedDateTimeRange;
  List<Booking> _loadedBookings = [];
  int _page = 0;

  AdminBookingsBloc() : super(AdminBookingsInitialState(null)) {
    on<AdminBookingsEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<AdminBookingsSelectNewRangeEvent>((event, emit) async {
      _selectedDateTimeRange = event.newRange;
      emit(AdminBookingsLoadingState(_selectedDateTimeRange, _loadedBookings));
      try {
        var id = await SecurityStorage().getIdStorage();
        _loadedBookings = await BookingRepository()
            .getBookingsByUserId(id); //TODO REPLACE TO GETBOOKINGBYRANGE!
        emit(AdminBookingsLoadedState(_selectedDateTimeRange, _loadedBookings));
      } catch (_) {
        emit(AdminBookingsErrorState(_selectedDateTimeRange));
      }
    });
    on<AdminBookingsLoadNextPageEvent>((event, emit) async {
      emit(AdminBookingsLoadingState(_selectedDateTimeRange,_loadedBookings));
      try {
        //page++;
        await Future.delayed(const Duration(seconds: 5));
        //todo load next page
        print("emit after load next page");
        emit(AdminBookingsLoadedState(_selectedDateTimeRange, _loadedBookings));
      } catch (_) {
        emit(AdminBookingsLoadedState(_selectedDateTimeRange, _loadedBookings));
      }
    });
  }
}
