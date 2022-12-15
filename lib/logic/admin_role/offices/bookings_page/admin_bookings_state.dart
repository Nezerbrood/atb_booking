part of 'admin_bookings_bloc.dart';

@immutable
abstract class AdminBookingsState {
  final DateTimeRange? selectedDateTimeRange;

  AdminBookingsState(this.selectedDateTimeRange);
}

class AdminBookingsInitialState extends AdminBookingsState {
  AdminBookingsInitialState(super.selectedDateTimeRange);
}

class AdminBookingsLoadingState extends AdminBookingsState {
  AdminBookingsLoadingState(super.selectedDateTimeRange, this.bookings);
  final List<Booking> bookings;
}

class AdminBookingsLoadedState extends AdminBookingsState {
  AdminBookingsLoadedState(super.selectedDateTimeRange, this.bookings);
  final List<Booking> bookings;
}

class AdminBookingsErrorState extends AdminBookingsState {
  AdminBookingsErrorState(super.selectedDateTimeRange);
}
