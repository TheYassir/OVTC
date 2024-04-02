import 'package:ovtc_app/models/contact_model.dart';
import 'package:test/test.dart';

void main() {
  group('[ContactModel] -', () {
    final datenow = DateTime.now().toUtc().toIso8601String();

    Map<String, dynamic> testJson = {
      "id": "200",
      "created_at": datenow,
      "is_pending": true,
      "is_accepted": false,
      "is_blocked": false,
      "sender_id": "001",
      "receiver_id": "002",
    };

    // DetailOtherUser error
    // test('Test fromJson() factory', () {
    //   final sut = ContactModel.fromJson(testJson);
    //   expect(
    //       sut,
    //       ContactModel(
    //           id: "200",
    //           createdAt: DateTime.parse(datenow),
    //           isPending: true,
    //           isAccepted: false,
    //           isBlocked: false,
    //           senderId: "001",
    //           receiverId: "002"));
    // });

    test('Test toJson() method', () {
      expect(
          ContactModel(
                  id: "200",
                  createdAt: DateTime.parse(datenow),
                  isPending: true,
                  isAccepted: false,
                  isBlocked: false,
                  senderId: "001",
                  receiverId: "002")
              .toJson(),
          testJson);
    });
  });
}
