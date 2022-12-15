part of 'new_booking_sheet_bloc.dart';

@immutable
abstract class NewBookingSheetEvent {}

class NewBookingSheetLoadEvent extends NewBookingSheetEvent{
  final int workspaceId;
  final DateTime dateTime;

  NewBookingSheetLoadEvent(this.workspaceId, this.dateTime);
}
class NewBookingSheetSliderChangedEvent extends NewBookingSheetEvent{
  final int activeSliderIndex;

  NewBookingSheetSliderChangedEvent(this.activeSliderIndex);
}

class NewBookingSheetValuesChangedEvent extends NewBookingSheetEvent{
  final SfRangeValues newValues;
  NewBookingSheetValuesChangedEvent(this.newValues);
}

class NewBookingSheetButtonPressEvent extends NewBookingSheetEvent{
}
class NewBookingSheetAddingPeopleToBookingEvent extends NewBookingSheetEvent{
  final List<User> selectedUsers;

  NewBookingSheetAddingPeopleToBookingEvent(this.selectedUsers);
}