part of 'adding_people_to_booking_bloc.dart';

@immutable
abstract class AddingPeopleToBookingEvent {}

class AddingPeopleLoadEvent extends AddingPeopleToBookingEvent {
  final String form;
  final bool formHasBeenChanged;

  AddingPeopleLoadEvent(
    this.form,
    this.formHasBeenChanged,
  );
}

class AddingPeopleToBookingIsFavoriteChangeEvent
    extends AddingPeopleToBookingEvent {
  final bool isFavoriteOn;
  final String form;

  AddingPeopleToBookingIsFavoriteChangeEvent(this.isFavoriteOn, this.form);
}

class AddingPeopleToBookingLoadNextPageEvent
    extends AddingPeopleToBookingEvent {}

class AddingPeopleToBookingSelectUserEvent extends AddingPeopleToBookingEvent {
  final User selectedUser;

  AddingPeopleToBookingSelectUserEvent(this.selectedUser);
}

class AddingPeopleToBookingDeselectUserEvent
    extends AddingPeopleToBookingEvent {
  final User selectedUser;

  AddingPeopleToBookingDeselectUserEvent(this.selectedUser);
}

class AddingPeopleToBookingButtonPressEvent extends AddingPeopleToBookingEvent {
}

class AddingPeopleToBookingToFavoriteEvent extends AddingPeopleToBookingEvent {
  final User user;

  AddingPeopleToBookingToFavoriteEvent(this.user);
}

class AddingPeopleToBookingRemoveFromFavoriteEvent
    extends AddingPeopleToBookingEvent {
  final User user;

  AddingPeopleToBookingRemoveFromFavoriteEvent(this.user);
}
