part of 'people_bloc.dart';

@immutable
abstract class PeopleEvent {}

class PeopleLoadEvent extends PeopleEvent {
  final String form;
  final bool formHasBeenChanged;
  PeopleLoadEvent(this.form, this.formHasBeenChanged);
}

class PeopleIsFavoriteChangeEvent extends PeopleEvent {
  final String form;
  PeopleIsFavoriteChangeEvent(this.form);
}

class PeopleLoadNextPageEvent extends PeopleEvent {}

class PeopleReportEvent extends PeopleEvent {}

class PeopleAddingToFavoriteEvent extends PeopleEvent {
  final User user;
  PeopleAddingToFavoriteEvent(this.user);
}

class PeopleRemoveFromFavoriteEvent extends PeopleEvent {
  final User user;
  PeopleRemoveFromFavoriteEvent(this.user);
}
