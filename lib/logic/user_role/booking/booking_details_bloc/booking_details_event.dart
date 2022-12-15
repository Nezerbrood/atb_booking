part of 'booking_details_bloc.dart';

@immutable
abstract class BookingDetailsEvent {}

class BookingDetailsLoadEvent extends BookingDetailsEvent {
  final int bookingId;
  final bool deleteButtonIsActive;
  BookingDetailsLoadEvent(this.bookingId,this.deleteButtonIsActive);
}

class BookingDetailsDeleteEvent extends BookingDetailsEvent {}
class BookingDetailsToFavoriteEvent extends BookingDetailsEvent{
  final User user;

  BookingDetailsToFavoriteEvent(this.user);
}
class BookingDetailsRemoveFromFavoriteEvent extends BookingDetailsEvent{
  final User user;

  BookingDetailsRemoveFromFavoriteEvent(this.user);
}