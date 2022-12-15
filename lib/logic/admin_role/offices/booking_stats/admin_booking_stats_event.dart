part of 'admin_booking_stats_bloc.dart';

@immutable
abstract class AdminBookingStatsEvent {}
class AdminBookingStatsSelectNewRangeEvent extends AdminBookingStatsEvent{
  final DateTimeRange newRange;

  AdminBookingStatsSelectNewRangeEvent(this.newRange);
}