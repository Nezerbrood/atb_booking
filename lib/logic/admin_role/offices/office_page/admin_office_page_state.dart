part of 'admin_office_page_bloc.dart';

@immutable
abstract class AdminOfficePageState {}

class AdminOfficePageInitial extends AdminOfficePageState {}
class AdminOfficePageLoadingState extends AdminOfficePageState{}
class AdminOfficePageLoadedState extends AdminOfficePageState{
  final String address;
  final int bookingRange;
  final DateTimeRange workTimeRange;
  final bool isSaveButtonActive;
  final List<Level> levels;
  AdminOfficePageLoadedState(this.address, this.bookingRange, this.workTimeRange, this.isSaveButtonActive, this.levels);
}
class AdminOfficePageErrorState extends AdminOfficePageState{}