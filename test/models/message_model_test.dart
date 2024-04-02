import 'package:ovtc_app/models/message_model.dart';
import 'package:test/test.dart';

void main() {
  group('[MessageModel] -', () {
    final datenow = DateTime.now().toUtc().toIso8601String();

    Map<String, dynamic> testJson = {
      'id': "001",
      "created_at": datenow,
      "content": "Long message",
      "content_type": "Text",
      "user_id": "002",
      "channel_id": "020"
    };

    test('Test fromJson() factory', () {
      final sut = MessageModel.fromJson(testJson);
      expect(
          sut,
          MessageModel(
              id: "001",
              createdAt: DateTime.parse(datenow),
              content: "Long message",
              contentType: "Text",
              userId: "002",
              channelId: "020"));
    });

    test('Test toJson() method', () {
      expect(
          MessageModel(
                  id: "001",
                  createdAt: DateTime.parse(datenow),
                  content: "Long message",
                  contentType: "Text",
                  userId: "002",
                  channelId: "020")
              .toJson(),
          testJson);
    });
  });
}
