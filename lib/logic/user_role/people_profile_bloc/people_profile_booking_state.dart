part of 'people_profile_booking_bloc.dart';

abstract class PeopleProfileBookingState {}

class PeopleProfileBooking_LoadingState extends PeopleProfileBookingState {}

class PeopleProfileBooking_LoadedState extends PeopleProfileBookingState {
  List<Booking> bookingList;
  Map<int, WorkspaceType> mapOfTypes;
  PeopleProfileBooking_LoadedState({required this.bookingList, required this.mapOfTypes});
}

class PeopleProfileBooking_EmptyState extends PeopleProfileBookingState {
  List<dynamic> loadedList = [];
}

class PeopleProfileBookingErrorState extends PeopleProfileBookingState {}
