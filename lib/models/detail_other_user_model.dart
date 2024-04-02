import 'package:equatable/equatable.dart';

class DetailOtherUserModel extends Equatable {
  final String id;
  final String lastName;
  final String firstName;
  final String email;
  final String roleId;

  const DetailOtherUserModel({
    required this.id,
    required this.lastName,
    required this.firstName,
    required this.email,
    required this.roleId,
  });

  factory DetailOtherUserModel.fromJson(Map<String, dynamic> json) {
    return DetailOtherUserModel(
      id: json['id'],
      lastName: json['last_name'],
      firstName: json['first_name'],
      email: json['email'],
      roleId: json['role_id'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'last_name': lastName,
        'first_name': firstName,
        'email': email,
        'role_id': roleId,
      };

  @override
  String toString() {
    return 'DetailOtherUserModel{id: $id, last_name: $lastName, first_name: $firstName, email: $email, role_id: $roleId,}';
  }

  @override
  List<Object?> get props => [id, lastName, firstName, email, roleId];
}
