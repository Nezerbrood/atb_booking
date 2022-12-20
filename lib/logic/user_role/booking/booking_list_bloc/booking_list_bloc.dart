import 'package:atb_booking/logic/user_role/booking/booking_details_bloc/booking_details_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:meta/meta.dart';

import '../../../../data/models/booking.dart';
import '../../../../data/models/workspace_type.dart';
import '../../../../data/services/booking_repository.dart';
import '../../../../data/services/workspace_type_repository.dart';
import '../../../../logic/secure_storage_api.dart';

part 'booking_list_event.dart';
part 'booking_list_state.dart';

class BookingListBloc extends Bloc<BookingListEvent, BookingListState> {
  static final BookingListBloc _singleton = BookingListBloc._internal();

  factory BookingListBloc() {
    return _singleton;
  }

  // todo получаем айди из секьюрити
  BookingListBloc._internal() : super(BookingListLoadingState()) {
    on<BookingListInitialEvent>((event, emit) async {
      emit(BookingListLoadingState());
    });
    on<BookingListLoadEvent>((event, emit) async {
      try {
        final currentUserId = await SecurityStorage().getIdStorage();
        final List<Booking> bookingList =
            await BookingRepository().getBookingsByUserId(currentUserId);
        final Map<int, WorkspaceType> mapOfTypes =
            await WorkspaceTypeRepository().getMapOfTypes();
        initializeDateFormatting();
        if (bookingList.isEmpty) {
          emit(BookingListEmptyState());
        } else {
          emit(BookingListLoadedState(
              bookingList: bookingList, mapOfTypes: mapOfTypes));
        }
      } catch (_) {
        emit(BookingListErrorState());
      }
    });
    on<BookingCardTapEvent>((event, emit) async {
      try {
        BookingDetailsBloc().add(BookingDetailsLoadEvent(event.bookingId,true));
      } catch (_) {}
    });
    add(BookingListLoadEvent());
  }
}
