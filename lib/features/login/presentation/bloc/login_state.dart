import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class InitialLoginState extends LoginState {
  @override
  List<Object> get props => [];
}

class CheckingLoginState extends LoginState {
  @override
  List<Object> get props => [];
}

class LoggedState extends LoginState {
  @override
  List<Object> get props => [];
}

class ErrorLoggedState extends LoginState {
  @override
  List<Object> get props => [];
}
