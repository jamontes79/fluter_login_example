import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loginexample/core/error/failures.dart';
import 'package:loginexample/features/login/domain/entities/LoginModel.dart';
import 'package:loginexample/features/login/domain/usecases/login.dart';
import 'package:loginexample/features/login/presentation/bloc/bloc.dart';
import 'package:loginexample/features/login/presentation/dto/login_dto.dart';
import 'package:mockito/mockito.dart';

class MockLogin extends Mock implements Login {}

void main() {
  MockLogin mockLogin;
  LoginBloc bloc;

  setUp(() {
    mockLogin = MockLogin();
    bloc = LoginBloc(mockLogin);
  });

  test(
    'initial state should be InitialLoginState',
    () async {
      // assert
      expect(bloc.initialState, equals(InitialLoginState()));
    },
  );

  group('Login', () {
    final tLoginDTO = LoginDTO(username: 'username', password: "password");

    test('should call add movie', () async {
      //given
      when(mockLogin(any)).thenAnswer((_) async => Right(true));
      //when
      bloc.add(CheckLoginEvent(login: tLoginDTO));
      await untilCalled(mockLogin(any));
      //then
      verify(mockLogin(Params(
          login: LoginModel(
        login: tLoginDTO.username,
        password: tLoginDTO.password,
      ))));
    });

    test(
      'should emit [Checking, Logged] when data are correct',
      () async {
        // given
        when(mockLogin(any)).thenAnswer((_) async => Right(true));
        // when
        bloc.add(CheckLoginEvent(login: tLoginDTO));
        // assert
        expectLater(
            bloc,
            emitsInOrder([
              InitialLoginState(),
              CheckingLoginState(),
              LoggedState(),
            ]));
      },
    );

    test(
      'should emit [Checking, Error] when data are not correct',
      () async {
        // given
        when(mockLogin(any)).thenAnswer((_) async => Right(false));
        // when
        bloc.add(CheckLoginEvent(login: tLoginDTO));
        // assert
        expectLater(
            bloc,
            emitsInOrder([
              InitialLoginState(),
              CheckingLoginState(),
              ErrorLoggedState(),
            ]));
      },
    );

    test(
      'should emit [Checking, Error] when server error',
      () async {
        // given
        when(mockLogin(any)).thenAnswer((_) async => Left(ServerFailure()));
        // when
        bloc.add(CheckLoginEvent(login: tLoginDTO));
        // assert
        expectLater(
            bloc,
            emitsInOrder([
              InitialLoginState(),
              CheckingLoginState(),
              ErrorLoggedState(),
            ]));
      },
    );
  });
}
