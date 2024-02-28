part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}


class LoginUser extends LoginEvent {
  String username;
  String password;

  LoginUser({required this.username, required this.password,});
}