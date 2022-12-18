part of 'admin_office_page_bloc.dart';

@immutable
abstract class AdminOfficePageState {}

class AdminOfficePageInitial extends AdminOfficePageState {}

class AdminOfficePageLoadingState extends AdminOfficePageState {}

class AdminOfficePageLoadedState extends AdminOfficePageState {
  final String address;
  final int bookingRange;
  final DateTimeRange workTimeRange;
  final bool isSaveButtonActive;
  final List<LevelListItem> levels;

  AdminOfficePageLoadedState(this.address, this.bookingRange,
      this.workTimeRange, this.isSaveButtonActive, this.levels);
}

class AdminOfficePageDeleteSuccessState extends AdminOfficePageLoadedState {
  AdminOfficePageDeleteSuccessState(super.address, super.bookingRange,
      super.workTimeRange, super.isSaveButtonActive, super.levels);
}
class AdminOfficePageDeleteLoadingState extends AdminOfficePageLoadedState {
  AdminOfficePageDeleteLoadingState(super.address, super.bookingRange,
      super.workTimeRange, super.isSaveButtonActive, super.levels);
}

class AdminOfficePageDeleteErrorState extends AdminOfficePageLoadedState {
  AdminOfficePageDeleteErrorState(super.address, super.bookingRange,
      super.workTimeRange, super.isSaveButtonActive, super.levels);
}

class AdminOfficePageErrorState extends AdminOfficePageState {}
