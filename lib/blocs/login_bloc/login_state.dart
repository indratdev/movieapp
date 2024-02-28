part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

class FailureLogin extends LoginState {
  String info;

  FailureLogin({
    required this.info,
  });

  @override
  List<Object> get props => [info];
}

// now playing

class FailureLoginUser extends FailureLogin {
  FailureLoginUser({required super.info});
}

class LoadingLoginUser extends LoginState {}

class SuccessLoginUser extends LoginState {
  bool status;

  SuccessLoginUser({
    required this.status,
  });

  List<Object> get props => [status];
}
