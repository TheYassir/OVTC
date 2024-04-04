import 'package:ovtc_app/models/detail_other_user_model.dart';
import 'package:test/test.dart';

void main() {
  group('[DetailOtherUserModel] -', () {
    Map<String, dynamic> testJson = {
      "id": "001",
      "last_name": "Doe",
      "first_name": "John",
      "email": "test@gmail.com",
      "role_id": "010"
    };

    test('Test fromJson() factory', () {
      final sut = DetailOtherUserModel.fromJson(testJson);
      expect(
          sut,
          const DetailOtherUserModel(
              id: "001",
              lastName: "Doe",
              firstName: "John",
              email: "test@gmail.com",
              roleId: "010"));
    });

    test('Test toJson() method', () {
      expect(
          const DetailOtherUserModel(
                  id: "001",
                  lastName: "Doe",
                  firstName: "John",
                  email: "test@gmail.com",
                  roleId: "010")
              .toJson(),
          testJson);
    });
  });
}
