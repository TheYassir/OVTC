class MessageModel {
  int id;
  String createdAt;
  String content;
  String contentType;
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
      createdAt: json['created_at'],
      content: json['content'],
      contentType: json['content_type'],
      userId: json['user_id'],
      channelId: json['channel_id'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'created_at': createdAt,
        'content': content,
        'content_type': contentType,
        'user_id': userId,
        'channel_id': channelId,
      };
}
