class UserModel {
  String id;
  String lastName;
  String firstName;
  String address;
  int zipcode;
  String city;
  String roleId;

  UserModel({
    required this.id,
    required this.lastName,
    required this.firstName,
    required this.address,
    required this.zipcode,
    required this.city,
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
        'role_id': roleId,
      };
}
