part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class AuthStartEvent extends AuthEvent {}

class AuthLoginEvent extends AuthEvent {
  final String login;
  final String password;
  final bool? isChecked;
  AuthLoginEvent({required this.login, required this.password, this.isChecked});
}
