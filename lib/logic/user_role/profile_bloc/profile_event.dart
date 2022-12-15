part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {}

class ProfileLoadEvent extends ProfileEvent {}
class ProfileExitToAuthEvent extends ProfileEvent {}
class ProfileFeedbackEvent extends ProfileEvent {}