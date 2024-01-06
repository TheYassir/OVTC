class UserModel {
  String id;
  String lastName;
  String firstName;
  String address;
  int zipcode;
  String city;
  String email;
  String roleId;

  UserModel({
    required this.id,
    required this.lastName,
    required this.firstName,
    required this.address,
    required this.zipcode,
    required this.city,
    required this.email,
    required this.roleId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      lastName: json['last_name'],
      firstName: json['first_name'],
      address: json['address'],
      zipcode: json['zipcode'],
      city: json['city'],
      email: json['email'],
      roleId: json['role_id'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'last_name': lastName,
        'first_name': firstName,
        'address': address,
        'zipcode': zipcode,
        'city': city,
        'email': email,
        'role_id': roleId,
      };

  @override
  String toString() {
    return 'UserModel{id: $id, last_name: $lastName, first_name: $firstName, address: $address, zipcode: $zipcode, city: $city, email: $email, role_id: $roleId,}';
  }
}
