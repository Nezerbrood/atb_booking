part of 'profile_bloc.dart';

@immutable
abstract class ProfileState {}

class ProfileInitialState extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileLoadedState extends ProfileState {
  User userPerson;
  ProfileLoadedState({required this.userPerson});
}

class ProfileErrorState extends ProfileState {}
