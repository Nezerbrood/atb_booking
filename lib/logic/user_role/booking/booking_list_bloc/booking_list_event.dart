part of 'booking_list_bloc.dart';
@immutable
abstract class BookingListEvent {
}

class NavigateToNewBookingEvent extends BookingListEvent{
}
class BookingListLoadEvent extends BookingListEvent{
}
class BookingCardTapEvent extends BookingListEvent{
  final int bookingId;

  BookingCardTapEvent(this.bookingId);
}