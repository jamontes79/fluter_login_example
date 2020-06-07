import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:loginexample/features/login/domain/entities/LoginModel.dart';
import 'package:loginexample/features/login/domain/usecases/login.dart';

import './bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final Login loginUseCase;

  LoginBloc(this.loginUseCase);

  @override
  LoginState get initialState => InitialLoginState();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is CheckLoginEvent) {
      yield CheckingLoginState();
      final result = await loginUseCase.call(
        Params(
          login: LoginModel(
            login: event.login.username,
            password: event.login.password,
          ),
        ),
      );
      yield result.fold(
        (failure) => ErrorLoggedState(),
        (value) => (value) ? LoggedState() : ErrorLoggedState(),
      );
    }
  }
}
