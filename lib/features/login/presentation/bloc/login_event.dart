import 'package:equatable/equatable.dart';
import 'package:loginexample/features/login/presentation/dto/login_dto.dart';
import 'package:meta/meta.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class CheckLoginEvent extends LoginEvent {
  final LoginDTO login;

  CheckLoginEvent({@required this.login});

  @override
  List<Object> get props => [login];
}
