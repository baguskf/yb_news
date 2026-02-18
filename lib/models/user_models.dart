class UserModel {
  String email;
  String password;
  bool isLoggedIn;

  UserModel({
    required this.email,
    required this.password,
    required this.isLoggedIn,
  });
}
