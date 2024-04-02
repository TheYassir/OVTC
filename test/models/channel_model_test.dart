import 'package:ovtc_app/models/channel_model.dart';
import 'package:test/test.dart';

void main() {
  group('Testing ChannelModel', () {
    final datenow = DateTime.now().toUtc().toIso8601String();

    Map<String, dynamic> testJson = {
      'id': "001",
      "last_update": datenow,
      "title": "title",
      "last_message_id": null,
    };

    test('Test fromJson() factory', () {
      final sut = ChannelModel.fromJson(testJson);
      expect(
          sut,
          ChannelModel(
              id: "001", lastUpdate: DateTime.parse(datenow), title: "title"));
    });

    test('Test toJson() method', () {
      expect(
          ChannelModel(
                  id: "001",
                  lastUpdate: DateTime.parse(datenow),
                  title: "title")
              .toJson(),
          testJson);
    });
  });
}
