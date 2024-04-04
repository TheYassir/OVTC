import 'package:ovtc_app/models/auth_model.dart';
import 'package:test/test.dart';

void main() {
  group('[AuthModel] -', () {
    Map<String, dynamic> testJson = {
      'id': "001",
      'email': "test@gmail.com",
    };

    test('Test fromJson() factory', () {
      final sut = AuthModel.fromJson(testJson);
      expect(sut, const AuthModel(id: "001", email: "test@gmail.com"));
    });

    test('Test toJson() method', () {
      expect(const AuthModel(id: "001", email: "test@gmail.com").toJson(),
          testJson);
    });
  });
}
