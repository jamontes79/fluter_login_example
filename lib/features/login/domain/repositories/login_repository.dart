import 'package:dartz/dartz.dart';
import 'package:loginexample/core/error/failures.dart';
import 'package:loginexample/features/login/domain/entities/LoginModel.dart';

abstract class LoginRepository {
  Future<Either<Failure, bool>> login(LoginModel login);
}
