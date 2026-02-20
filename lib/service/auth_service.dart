import 'package:yb_news/data/dummy_users.dart';
import 'package:yb_news/models/user_models.dart';

class AuthService {
  static UserModel? currentUser;
  Future<UserModel> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));

    final user = FakeUserDB.users.where((u) => u.email == email).toList();

    if (user.isEmpty) {
      throw "User not found";
    }

    final current = user.first;

    if (current.password != password) {
      throw "Wrong password";
    }

    if (current.isLoggedIn) {
      throw "User already logged in";
    }

    current.isLoggedIn = true;

    currentUser = current;
    FakeUserDB.currentUser = current;

    return current;
  }

  Future<UserModel> register(String name, String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));

    final exists = FakeUserDB.users.any((u) => u.email == email);

    if (exists) {
      throw "Email already registered";
    }

    final newUser = UserModel(
      name: name,
      email: email,
      password: password,
      isLoggedIn: false,
      isFisrtLogin: true,
    );

    FakeUserDB.users.add(newUser);

    return newUser;
  }

  void logout() {
    currentUser?.isLoggedIn = false;
    currentUser = null;
  }
}
