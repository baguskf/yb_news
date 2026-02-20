import 'package:yb_news/models/user_models.dart';

class FakeUserDB {
  static List<UserModel> users = [
    UserModel(
      name: "Admin",
      email: "admin@mail.com",
      password: "Admin123",
      isLoggedIn: false,
      isFisrtLogin: true,
    ),
  ];

  static UserModel? currentUser;
}
