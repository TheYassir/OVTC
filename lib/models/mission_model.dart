import 'package:ovtc_app/models/detail_other_user_model.dart';

class MissionModel {
  String id;
  String addressStart;
  String addressEnd;
  DateTime dateStart;
  int price;
  String customerId;
  String driverId;
  String receiverId;
  String senderId;
  bool isPending;
  bool isAccepted;
  bool isRefused;
  DetailOtherUserModel? detailOtherUser;

  MissionModel({
    required this.id,
    required this.addressStart,
    required this.addressEnd,
    required this.dateStart,
    required this.price,
    required this.customerId,
    required this.driverId,
    required this.receiverId,
    required this.senderId,
    required this.isPending,
    required this.isAccepted,
    required this.isRefused,
    this.detailOtherUser,
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
      senderId: json['sender_id'],
      receiverId: json['receiver_id'],
      isAccepted: json['is_accepted'],
      isPending: json['is_pending'],
      isRefused: json['is_refused'],
      detailOtherUser: DetailOtherUserModel.fromJson(json['detailOtherUser']),
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
        'sender_id': senderId,
        'receiver_id': receiverId,
        'is_pending': isPending,
        'is_accepted': isAccepted,
        'is_refused': isRefused,
      };

  @override
  String toString() {
    return 'MissionModel{id: $id, addressStart: $addressStart, addressEnd: $addressEnd, dateStart: $dateStart, price: $price, customerId: $customerId, driverId: $driverId, is_accepted}: $isAccepted, is_pending: $isPending, is_refused: $isRefused, detailOtherUserModel: $detailOtherUser';
  }
}
