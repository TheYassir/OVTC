class MessageModel {
  String id;
  DateTime createdAt;
  String content;
  String? contentType;
  String userId;
  String channelId;

  MessageModel({
    required this.id,
    required this.createdAt,
    required this.content,
    required this.contentType,
    required this.userId,
    required this.channelId,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'],
      createdAt: DateTime.parse(json['created_at']),
      content: json['content'],
      contentType: json['content_type'],
      userId: json['user_id'],
      channelId: json['channel_id'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'created_at': createdAt.toIso8601String(),
        'content': content,
        'content_type': contentType,
        'user_id': userId,
        'channel_id': channelId,
      };

  @override
  String toString() {
    return 'MessageModel{id: $id, createdAt: $createdAt, content: $content, contentType: $contentType, userId: $userId, channelId: $channelId}';
  }
}
