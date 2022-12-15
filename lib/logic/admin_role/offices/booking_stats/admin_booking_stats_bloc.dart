import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'admin_booking_stats_event.dart';
part 'admin_booking_stats_state.dart';

class AdminBookingStatsBloc extends Bloc<AdminBookingStatsEvent, AdminBookingStatsState> {
  DateTimeRange? _selectedDateTimeRange;
  AdminBookingStatsBloc() : super(const AdminBookingStatsInitial(null)) {
    on<AdminBookingStatsEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<AdminBookingStatsSelectNewRangeEvent>((event, emit) {
      //todo load stats from server
      emit(AdminBookingStatsLoadedState(_selectedDateTimeRange));
    });

  }
}
