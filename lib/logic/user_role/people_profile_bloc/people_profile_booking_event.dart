part of 'people_profile_booking_bloc.dart';

@immutable
abstract class PeopleProfileBookingEvent {}

class NavigateToNewBookingEvent extends PeopleProfileBookingEvent {}

class PeopleProfileBookingLoadEvent extends PeopleProfileBookingEvent {
  final int id;
  PeopleProfileBookingLoadEvent({required this.id});
}

class PeopleProfileBookingCardTapEvent extends PeopleProfileBookingEvent {
  final int bookingId;
  PeopleProfileBookingCardTapEvent(this.bookingId);
}

