import 'package:loginexample/features/login/data/model/User.dart';
import 'package:loginexample/features/login/domain/entities/LoginModel.dart';

class LoginUser {
  Future<User> login(LoginModel login) async {
    if (login.login == "user" && login.password == "password") {
      return User(id: 1, user: "admin");
    } else {
      return null;
    }
  }
}
