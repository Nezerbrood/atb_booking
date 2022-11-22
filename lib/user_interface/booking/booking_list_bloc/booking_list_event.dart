part of 'booking_list_bloc.dart';
@immutable
abstract class BookingListEvent {
}

class NavigateToNewBookingEvent extends BookingListEvent{
}

class NavigateToBookingDetailsEvent extends BookingListEvent{
  final int bookingId;
  NavigateToBookingDetailsEvent(this.bookingId);
}
class BookingListLoadEvent extends BookingListEvent{

}