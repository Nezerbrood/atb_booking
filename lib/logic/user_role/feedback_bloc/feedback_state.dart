part of 'feedback_bloc.dart';

@immutable
abstract class FeedbackState {}

class FeedbackInputFieldsState extends FeedbackState {
  final bool typeFieldVisible;
  final bool cityFieldVisible;
  final bool officeFieldVisible;
  final bool messageFieldVisible;
  final bool buttonVisible;
  bool isInitialState = false;

  final Future<List<String>> futureTypeList;
  final Future<List<City>>? futureCityList;
  final Future<List<Office>>? futureOfficeList;

  final String message;

  FeedbackInputFieldsState(
      this.typeFieldVisible,
      this.cityFieldVisible,
      this.officeFieldVisible,
      this.messageFieldVisible,
      this.buttonVisible,
      this.futureTypeList,
      this.futureCityList,
      this.futureOfficeList,
      this.message);
}



abstract class FeedbackPopupState extends FeedbackState {}
class FeedbackSuccessState extends FeedbackPopupState {}
class FeedbackPopupLoadingState extends FeedbackPopupState {}
class FeedbackPopupErrorState extends FeedbackPopupState {}