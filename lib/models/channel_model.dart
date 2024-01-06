class ChannelModel {
  int id;
  String lastUpdate;
  String title;

  ChannelModel({
    required this.id,
    required this.lastUpdate,
    required this.title,
  });

  factory ChannelModel.fromJson(Map<String, dynamic> json) {
    return ChannelModel(
      id: json['id'],
      lastUpdate: json['last_update'],
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'last_update': lastUpdate,
        'title': title,
      };

  @override
  String toString() {
    return 'ChannelModel{id: $id, lastUpdate: $lastUpdate, title: $title}';
  }
}
