import 'dart:async';
import 'package:atb_booking/data/services/workspace_type_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:atb_booking/util/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'dart:io';
import '../../../data/models/booking.dart';
import '../../../data/models/workspace_type.dart';
import '../../../data/services/booking_repository.dart';
import '../../../presentation/user_interface/booking/booking_card_widget.dart';

part 'booking_list_event.dart';
part 'booking_list_state.dart';

class BookingListBloc extends Bloc<BookingListEvent, BookingListState> {
  final BookingRepository bookingRepository;
  final WorkspaceTypeRepository workspaceTypeRepository;
  final currentUserId = 1;// todo получаем айди из секьюрити
  BookingListBloc({required this.workspaceTypeRepository, required this.bookingRepository}) : super(BookingListLoadingState()) {
    on<BookingListLoadEvent>((event, emit) async {
      try{
        final List<dynamic> bookingList = [];
        final List<Booking> bookingData = await bookingRepository.getBookingByUserId(currentUserId);
        final Map<int,WorkspaceType> mapOfTypes = await workspaceTypeRepository.getMapOfTypes();
        bool todayItemIsAdd = false;
        bool tomorrowIsAdd = false;
        bool tomorrowEnd = false;
        initializeDateFormatting();
        for (var i = 0; i < bookingData.length; i++) {
          if (bookingData[i].dateTimeRange.start.day == DateTime
              .now()
              .day &&
              !todayItemIsAdd) {
            bookingList.add(ListTitle("Сегодня"));
            bookingList.add(BookingCard(bookingData[i].dateTimeRange,
                mapOfTypes[bookingData[i].workspace.typeId]!.type, "assets/workplacelogo.png",
                "assets/workplace.png"));
            todayItemIsAdd = true;
          } else if (bookingData[i].dateTimeRange.start.day ==
              DateTime
                  .now()
                  .day + 1 &&
              !tomorrowIsAdd) {
            bookingList.add(ListTitle("Завтра"));
            bookingList.add(BookingCard(bookingData[i].dateTimeRange,
                mapOfTypes[bookingData[i].workspace.typeId]!.type, "assets/workplacelogo.png",
                "assets/workplace.png"));
            tomorrowIsAdd = true;
          } else if (bookingData[i].dateTimeRange.start.day ==
              DateTime
                  .now()
                  .day + 1) {
            bookingList.add(BookingCard(bookingData[i].dateTimeRange,
                mapOfTypes[bookingData[i].workspace.typeId]!.type, "assets/workplacelogo.png",
                "assets/workplace.png"));
          } else {
            bookingList.add(BookingCard(bookingData[i].dateTimeRange,
                mapOfTypes[bookingData[i].workspace.typeId]!.type, "assets/workplacelogo.png",
                "assets/workplace.png"));
          }
          if (bookingData[i].dateTimeRange.start.day != DateTime
              .now()
              .day &&
              tomorrowEnd == false) {
            tomorrowEnd = true;
            initializeDateFormatting();
            bookingList.add(ListTitle(DateFormat.MMMM(Platform.localeName)
                .format(bookingData[i].dateTimeRange.start)
                .capitalize()));
          } else {
            bookingList.add(BookingCard(bookingData[i].dateTimeRange,
                mapOfTypes[bookingData[i].workspace.typeId]!.type, "assets/workplacelogo.png",
                "assets/workplace.png")
            );
          }
        }
        emit(BookingListLoadedState(loadedList: bookingList));
      } catch (_) {

        emit(BookingListErrorState());
      }});
  }
}
