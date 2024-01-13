class DetailOtherUserModel {
  String id;
  String lastName;
  String firstName;
  String email;
  String roleId;

  DetailOtherUserModel({
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
}
