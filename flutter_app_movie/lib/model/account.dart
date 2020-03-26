class Account {
  String username;
  String password;
  String email;

  Account({
    this.username,
    this.password,
    this.email,
  });

  factory Account.fromJson(Map<String, dynamic> json) => Account(
    username: json["username"],
    password: json["password"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "password": password,
    "email": email,
  };
}