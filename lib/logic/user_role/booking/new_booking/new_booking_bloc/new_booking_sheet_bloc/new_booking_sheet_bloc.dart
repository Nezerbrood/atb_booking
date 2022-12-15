import 'package:atb_booking/data/models/user.dart';
import 'package:atb_booking/data/models/workspace.dart';
import 'package:atb_booking/data/services/booking_repository.dart';
import 'package:atb_booking/data/services/workspace_repository.dart';
import 'package:atb_booking/logic/user_role/booking/new_booking/new_booking_bloc/new_booking_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

part 'new_booking_sheet_event.dart';

part 'new_booking_sheet_state.dart';

toSFRangeValuesList(List<DateTimeRange> list) {
  List<SfRangeValues> resultList = [];
  for (var element in list) {
    resultList.add(SfRangeValues(element.start, element.end));
  }
  return resultList;
}

fromSFRangeValuesList(List<SfRangeValues> list) {
  List<DateTimeRange> resultList = [];
  for (var element in list) {
    resultList.add(DateTimeRange(start: element.start, end: element.end));
  }
  return resultList;
}

fromSFRangeValues(SfRangeValues values) {
  return DateTimeRange(start: values.start, end: values.end);
}

class NewBookingSheetBloc
    extends Bloc<NewBookingSheetEvent, NewBookingSheetState> {
  static final NewBookingSheetBloc _singleton = NewBookingSheetBloc._internal();

  factory NewBookingSheetBloc() {
    return _singleton;
  }

  List<DateTimeRange>? rangeValuesList;
  List<DateTimeRange>? rangeList;
  DateTime? selectedDate;
  int activeSliderIndex = 0;
  Workspace? workspace;
  List<User> selectedUsers = [];

  NewBookingSheetBloc._internal() : super(NewBookingSheetInitialState()) {
    on<NewBookingSheetLoadEvent>((event, emit) async {
      emit(NewBookingSheetLoadingState());
      selectedDate = event.dateTime;
      activeSliderIndex = 0;
      try {
        workspace =
            await WorkspaceRepository().getWorkspaceById(event.workspaceId);

        rangeList = await BookingRepository()
            .getBookingWindows(workspace!.id, selectedDate!);
        rangeValuesList = rangeList!.toList();
        if (workspace != null) {
          emit(NewBookingSheetLoadedState(
              toSFRangeValuesList(rangeValuesList!),
              toSFRangeValuesList(rangeList!),
              activeSliderIndex,
              workspace!,
              selectedUsers));
        }
      } catch (_) {
        emit(NewBookingSheetErrorState());
      }
    });
    on<NewBookingSheetSliderChangedEvent>((event, emit) {
      activeSliderIndex = event.activeSliderIndex;
      emit(NewBookingSheetLoadedState(
          toSFRangeValuesList(rangeValuesList!),
          toSFRangeValuesList(rangeList!),
          activeSliderIndex,
          workspace!,
          selectedUsers));
    });
    on<NewBookingSheetValuesChangedEvent>((event, emit) {
      rangeValuesList![activeSliderIndex] = fromSFRangeValues(event.newValues);
      emit(NewBookingSheetLoadedState(
          toSFRangeValuesList(rangeValuesList!),
          toSFRangeValuesList(rangeList!),
          activeSliderIndex,
          workspace!,
          selectedUsers));
    });
    on<NewBookingSheetButtonPressEvent>((event, emit) {
      NewBookingBloc().add(NewBookingBookEvent());
      activeSliderIndex = 0;
    });

    on<NewBookingSheetAddingPeopleToBookingEvent>((event,emit){
      selectedUsers = event.selectedUsers;
      NewBookingBloc().setGuests(selectedUsers);
      emit(NewBookingSheetLoadedState(
          toSFRangeValuesList(rangeValuesList!),
          toSFRangeValuesList(rangeList!),
          activeSliderIndex,
          workspace!,
          selectedUsers));
    });
  }
}
