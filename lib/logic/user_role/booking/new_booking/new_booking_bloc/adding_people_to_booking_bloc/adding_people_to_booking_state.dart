part of 'adding_people_to_booking_bloc.dart';

@immutable
abstract class AddingPeopleToBookingState {
  final bool isFavoriteOn;
  final Map<int,User> selectedUsers;
  AddingPeopleToBookingState(this.isFavoriteOn, this.selectedUsers);
}

class AddingPeopleToBookingInitial extends AddingPeopleToBookingState {
  AddingPeopleToBookingInitial(super.isFavoriteOn,super.selectedUsers);
  final List<User> users = [];
}
class AddingPeopleToBookingLoadingState extends AddingPeopleToBookingState{
  AddingPeopleToBookingLoadingState(super.isFavoriteOn,super.selectedUsers, this.users);
  final List<User> users;
}
class AddingPeopleToBookingLoadedState extends AddingPeopleToBookingState{
  final List<User> users;
  AddingPeopleToBookingLoadedState(super.isFavoriteOn,super.selectedUsers,this.users);

}