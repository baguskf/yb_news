import 'package:yb_news/data/dummy_users.dart';
import 'package:yb_news/models/user_models.dart';

class AuthService {
  Future<UserModel> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));

    final user = dummyUsers.where((u) => u.email == email).toList();

    if (user.isEmpty) {
      throw "User not found";
    }

    if (user.first.password != password) {
      throw "Wrong password";
    }

    if (user.first.isLoggedIn) {
      throw "User already logged in";
    }

    user.first.isLoggedIn = true;

    return user.first;
  }
}
