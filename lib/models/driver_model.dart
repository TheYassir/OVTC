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
