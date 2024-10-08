import 'package:equatable/equatable.dart';
import 'package:ovtc_app/models/message_model.dart';

class ChannelModel extends Equatable {
  final String id;
  final DateTime lastUpdate;
  final String? title;
  final String? lastMessageId;
  MessageModel? lastMessage;

  ChannelModel({
    required this.id,
    required this.lastUpdate,
    required this.title,
    this.lastMessageId,
    this.lastMessage,
  });

  factory ChannelModel.fromJson(Map<String, dynamic> json) {
    return ChannelModel(
      id: json['id'],
      lastUpdate: DateTime.parse(json['last_update']),
      title: json['title'],
      lastMessageId: json['last_message_id'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'last_update': lastUpdate.toUtc().toIso8601String(),
        'title': title,
        'last_message_id': lastMessageId,
      };

  @override
  String toString() {
    return 'ChannelModel{id: $id, lastUpdate: $lastUpdate, title: $title, lastMessageId: $lastMessageId, lastMessage: $lastMessage}';
  }

  @override
  List<Object?> get props =>
      [id, lastUpdate, title, lastMessageId, lastMessage];
}
