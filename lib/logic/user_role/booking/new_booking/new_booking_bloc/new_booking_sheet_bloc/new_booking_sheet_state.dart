part of 'new_booking_sheet_bloc.dart';

@immutable
abstract class NewBookingSheetState {}

class NewBookingSheetInitialState extends NewBookingSheetState {}

class NewBookingSheetLoadingState extends NewBookingSheetState {}

class NewBookingSheetLoadedState extends NewBookingSheetState {
  final Workspace workspace;
  final List<SfRangeValues> rangeValuesList;
  final List<SfRangeValues> rangeList;
  final int activeSliderIndex;
  final List<User> selectedUsers;
  NewBookingSheetLoadedState(this.rangeValuesList, this.rangeList, this.activeSliderIndex, this.workspace, this.selectedUsers);
}

class NewBookingSheetErrorState extends NewBookingSheetState {}
