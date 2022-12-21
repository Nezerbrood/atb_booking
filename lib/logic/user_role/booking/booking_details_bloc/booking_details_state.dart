part of 'booking_details_bloc.dart';

abstract class BookingDetailsState {}

class BookingDetailsInitialState extends BookingDetailsState {}

class BookingDetailsLoadingState extends BookingDetailsState {}

class BookingDetailsLoadedState extends BookingDetailsState {
  final Booking booking;
  bool buttonIsShow = true;
  final User holderUser;

  BookingDetailsLoadedState(this.booking,this.buttonIsShow,this.holderUser);
}
class BookingDetailsDeletedState extends BookingDetailsState {
  final Booking booking;

  BookingDetailsDeletedState(this.booking);
}

class BookingDetailsErrorState extends BookingDetailsState {}
