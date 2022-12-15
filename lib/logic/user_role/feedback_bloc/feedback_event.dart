part of 'feedback_bloc.dart';

@immutable
abstract class FeedbackEvent {}

class FeedbackTypeFormEvent extends FeedbackEvent {
  final String type;
  FeedbackTypeFormEvent(this.type);
}

class FeedbackCityFormEvent extends FeedbackEvent {
  final City city;
  FeedbackCityFormEvent(this.city);
}

class FeedbackOfficeFormEvent extends FeedbackEvent {
  final Office office;
  FeedbackOfficeFormEvent(this.office);
}

class FeedbackMessageInputEvent extends FeedbackEvent {
  final String form;
  FeedbackMessageInputEvent(this.form);
}

class FeedbackButtonSubmitEvent extends FeedbackEvent {}
