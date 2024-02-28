import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginUser>((event, emit) {
      emit(LoadingLoginUser());

      try {
        if (event.username == '123' && event.password == "123") {
          // aldmic | 123abc123
          // Future.delayed(Duration(seconds: 3), (){
          emit(SuccessLoginUser(status: true));
          // });
        } else {
          emit(FailureLoginUser(info: "Failed to Login"));
        }
      } catch (e) {
        emit(FailureLoginUser(info: e.toString()));
      }
    });
  }
}
