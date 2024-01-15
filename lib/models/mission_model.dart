class MissionModel {
  String id;
  String addressStart;
  String addressEnd;
  DateTime dateStart;
  String price;
  String customerId;
  String driverId;

  MissionModel({
    required this.id,
    required this.addressStart,
    required this.addressEnd,
    required this.dateStart,
    required this.price,
    required this.customerId,
    required this.driverId,
  });

  factory MissionModel.fromJson(Map<String, dynamic> json) {
    return MissionModel(
      id: json['id'],
      addressStart: json['address_start'],
      addressEnd: json['address_end'],
      dateStart: DateTime.parse(json['date_start']),
      price: json['price'],
      customerId: json['customer_id'],
      driverId: json['driver_id'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'address_start': addressStart,
        'address_end': addressEnd,
        'date_start': dateStart.toIso8601String(),
        'price': price,
        'customer_id': customerId,
        'driver_id': driverId,
      };

  @override
  String toString() {
    return 'MissionModel{id: $id, addressStart: $addressStart, addressEnd: $addressEnd, dateStart: $dateStart, price: $price, customerId: $customerId, driverId: $driverId}';
  }
}
