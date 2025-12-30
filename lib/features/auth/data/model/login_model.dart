class LoginInputModel {
  final String email;
  final String password;

  LoginInputModel({required this.email, required this.password});

  factory LoginInputModel.fromJson(Map<String, dynamic> json) =>
      LoginInputModel(email: json["email"], password: json["password"]);

  Map<String, dynamic> toJson() => {"email": email, "password": password};
}

class LoginResponseModel {
  final int id;
  final String email;
  final String name;
  final String token;

  LoginResponseModel({
    required this.id,
    required this.email,
    required this.name,
    required this.token,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        id: json["id"],
        email: json["email"],
        name: json["name"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "name": name,
    "token": token,
  };
}
