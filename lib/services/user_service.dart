import 'package:ovtc_app/models/driver_model.dart';
import 'package:ovtc_app/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class UserService {
  static Future<List<Object?>> getCurrentUser({required String id}) async {
    try {
      final Map<String, dynamic> response =
          await supabase.from('users').select().eq('id', id).single();

      if (response.isEmpty) {
        throw Exception("500: Internal server error");
      }

      final UserModel user = UserModel.fromJson(response);

      DriverModel? driver;
      final List<Object?> data = [user, null];

      if (user.roleId != "9cf60c0b-7920-40f1-a693-4f6c0a0c581a") {
        return data;
      }

      final Map<String, dynamic> driverResponse =
          await supabase.from('drivers').select().eq('user_id', id).single();

      if (driverResponse.isEmpty) {
        throw Exception("500: Internal server error on driver request");
      }

      driver = DriverModel.fromJson(driverResponse);
      final List<Object> driverData = [user, driver];
      return driverData;
    } catch (e) {
      print("[UserService] getCurrentUser: ${e.toString()}");
      rethrow;
    }
  }
}
