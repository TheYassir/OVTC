import 'package:ovtc_app/models/user_model.dart';
import 'package:test/test.dart';

void main() {
  group('[UserModel] -', () {
    Map<String, dynamic> testJson = {
      "id": "001",
      "last_name": "Doe",
      "first_name": "John",
      "address": "Beverly Hills",
      "zipcode": 11111,
      "city": "Los Angeles",
      "email": "test@test.com",
      "role_id": "1"
    };

    test('Test fromJson() factory', () {
      final sut = UserModel.fromJson(testJson);
      expect(
          sut,
          const UserModel(
              id: "001",
              lastName: "Doe",
              firstName: "John",
              address: "Beverly Hills",
              zipcode: 11111,
              city: "Los Angeles",
              email: "test@test.com",
              roleId: "1"));
    });

    test('Test toJson() method', () {
      expect(
          const UserModel(
                  id: "001",
                  lastName: "Doe",
                  firstName: "John",
                  address: "Beverly Hills",
                  zipcode: 11111,
                  city: "Los Angeles",
                  email: "test@test.com",
                  roleId: "1")
              .toJson(),
          testJson);
    });
  });
}
