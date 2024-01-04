class AuthModel {
  String id;
  String email;

  AuthModel({
    required this.id,
    required this.email,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      id: json['id'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
      };
}
