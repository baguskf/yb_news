class UserModel {
  String name;
  String email;
  String password;
  bool isLoggedIn;
  bool isFisrtLogin;

  UserModel({
    required this.name,
    required this.email,
    required this.password,
    required this.isLoggedIn,
    required this.isFisrtLogin,
  });
}
