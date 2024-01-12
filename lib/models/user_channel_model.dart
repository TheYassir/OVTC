class UserChannelModel {
  String id;
  String userId;
  String channelId;

  UserChannelModel({
    required this.id,
    required this.userId,
    required this.channelId,
  });

  factory UserChannelModel.fromJson(Map<String, dynamic> json) {
    return UserChannelModel(
      id: json['id'],
      userId: json['user_id'],
      channelId: json['channel_id'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'channel_id': channelId,
      };

  @override
  String toString() {
    return 'UserChannelModel{id: $id, userId: $userId, channelId: $channelId}';
  }
}
