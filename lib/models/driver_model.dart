class DriverModel {
  String id;
  String companyName;
  String siren;
  String userId;

  DriverModel({
    required this.id,
    required this.companyName,
    required this.siren,
    required this.userId,
  });

  factory DriverModel.fromJson(Map<String, dynamic> json) {
    return DriverModel(
      id: json['id'],
      companyName: json['company_name'],
      siren: json['siren'],
      userId: json['user_id'],
    );
  }

  // {
  //   id: 24253817-a0ff-4e35-9b3d-453643b57f7e,
  //   company_name: catvtc,
  //   siren: 999999999,
  //   user_id: 22b5e68e-802c-4383-a755-66b24319e47b
  // },

  Map<String, dynamic> toJson() => {
        'id': id,
        'company_name': companyName,
        'siren': siren,
        'user_id': userId,
      };

  @override
  String toString() {
    return 'DriverModel{id: $id, companyName: $companyName, siren: $siren, userId: $userId}';
  }
}
