import 'package:dartz/dartz.dart';
import 'package:loginexample/core/error/failures.dart';
import 'package:loginexample/features/login/data/datasource/login_user.dart';
import 'package:loginexample/features/login/domain/entities/LoginModel.dart';
import 'package:loginexample/features/login/domain/repositories/login_repository.dart';

class LoginRepositoryImpl extends LoginRepository {
  final LoginUser loginUser;

  LoginRepositoryImpl(this.loginUser);
  @override
  Future<Either<Failure, bool>> login(LoginModel login) async {
    try {
      final user = await loginUser.login(login);
      return Right(user != null);
    } catch (exception) {
      return Left(ServerFailure());
    }
  }
}
