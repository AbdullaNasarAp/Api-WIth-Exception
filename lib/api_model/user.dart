class User {
  User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  int id;
  String email;
  String firstName;
  String lastName;
  String avatar;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"] ?? '',
        email: json["email"] ?? '',
        firstName: json["first_name"] ?? '',
        lastName: json["last_name"] ?? '',
        avatar: json["avatar"] ?? '',
      );
}
