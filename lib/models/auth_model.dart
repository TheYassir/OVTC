import 'package:equatable/equatable.dart';

class AuthModel extends Equatable {
  final String id;
  final String email;

  const AuthModel({
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

  @override
  String toString() {
    return 'AuthModel{id: $id, email: $email}';
  }

  @override
  List<Object?> get props => [id, email];
}
