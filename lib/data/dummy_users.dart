import 'package:yb_news/models/user_models.dart';

class FakeUserDB {
  static List<UserModel> users = [
    UserModel(email: "admin@mail.com", password: "Admin123", isLoggedIn: false),
  ];
}
