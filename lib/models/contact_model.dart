import 'package:ovtc_app/models/detail_other_user.dart';

class ContactModel {
  String id;
  dynamic? createdAt;
  bool isPending;
  bool isAccepted;
  bool isBlocked;
  String senderId;
  String receiverId;
  DetailOtherUserModel? detailOtherUser;

  ContactModel({
    required this.id,
    this.createdAt,
    required this.isPending,
    required this.isAccepted,
    required this.isBlocked,
    required this.senderId,
    required this.receiverId,
    this.detailOtherUser,
  });

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      id: json['id'],
      createdAt: json['created_at'],
      isPending: json['is_pending'],
      isAccepted: json['is_accepted'],
      isBlocked: json['is_blocked'],
      senderId: json['sender_id'],
      receiverId: json['receiver_id'],
      detailOtherUser: DetailOtherUserModel.fromJson(json['detailOtherUser']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'created_at': createdAt,
        'is_pending': isPending,
        'is_accepted': isAccepted,
        'is_blocked': isBlocked,
        'sender_id': senderId,
        'receiver_id': receiverId,
      };

  @override
  String toString() {
    return 'ContactModel{id: $id, createdAt: $createdAt, isPending: $isPending,isAccepted: $isAccepted, isBlocked: $isBlocked, senderId: $senderId, receiverId: $receiverId, detailOtherUserModel: $detailOtherUser}';
  }
}
