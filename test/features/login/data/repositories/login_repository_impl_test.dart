import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loginexample/features/login/data/datasource/login_user.dart';
import 'package:loginexample/features/login/data/model/User.dart';
import 'package:loginexample/features/login/data/repositories/login_repository_impl.dart';
import 'package:loginexample/features/login/domain/entities/LoginModel.dart';
import 'package:mockito/mockito.dart';

class MockLoginUser extends Mock implements LoginUser {}

void main() {
  MockLoginUser mockLoginUser;
  LoginRepositoryImpl loginRepositoryImpl;

  setUp(() {
    mockLoginUser = MockLoginUser();
    loginRepositoryImpl = LoginRepositoryImpl(mockLoginUser);
  });

  group('Login User', () {
    final LoginModel tLogin = LoginModel(login: "user1", password: "password");
    final LoginModel tLoginCorrect =
        LoginModel(login: "user", password: "password");
    final User user = User(id: 1, user: "admin");
    test('Should call datasource', () {
      //given
      when(mockLoginUser.login(tLoginCorrect)).thenAnswer((_) async => user);
      //when
      loginRepositoryImpl.login(tLogin);
      //then
      verify(mockLoginUser.login(tLogin));
    });

    test('Should return true if login correct', () async {
      //given
      when(mockLoginUser.login(tLoginCorrect)).thenAnswer((_) async => user);
      //when
      final result = await loginRepositoryImpl.login(tLoginCorrect);
      //then
      expect(result, Right(true));
    });

    test('Should return false if login is not correct', () async {
      //given
      when(mockLoginUser.login(tLoginCorrect)).thenAnswer((_) async => null);
      //when
      final result = await loginRepositoryImpl.login(tLogin);
      //then
      expect(result, Right(false));
    });
  });
}
