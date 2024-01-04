class NotificationModel {
  String id;
  String content;
  String isNew;
  String userId;

  NotificationModel({
    required this.id,
    required this.content,
    required this.isNew,
    required this.userId,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      content: json['content'],
      isNew: json['is_new'],
      userId: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'content': content,
        'is_new': isNew,
        'user_id': userId,
      };
}
