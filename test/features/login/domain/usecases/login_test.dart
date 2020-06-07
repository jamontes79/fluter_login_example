import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loginexample/features/login/domain/entities/LoginModel.dart';
import 'package:loginexample/features/login/domain/repositories/login_repository.dart';
import 'package:loginexample/features/login/domain/usecases/login.dart';
import 'package:mockito/mockito.dart';

class MockLoginRepository extends Mock implements LoginRepository {}

void main() {
  MockLoginRepository mockLoginRepository;
  Login usecase;
  setUp(() {
    mockLoginRepository = MockLoginRepository();
    usecase = Login(mockLoginRepository);
  });

  final tLogin = LoginModel(login: "login", password: "password");
  test('use case call repository', () async {
    //given
    when(
      mockLoginRepository.login(any),
    ).thenAnswer((_) async => Right(true));
    //when
    final result = await usecase.call(Params(login: tLogin));
    //then
    expect(result, Right(true));
    verify(mockLoginRepository.login(tLogin));
    verifyNoMoreInteractions(mockLoginRepository);
  });
}
