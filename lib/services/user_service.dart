// import 'package:ovtc_app/models/auth_model.dart';
import 'package:ovtc_app/models/driver_model.dart';
import 'package:ovtc_app/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class UserService {
  static Future<List<Object?>> getCurrentUser({required id}) async {
    try {
      final Map<String, dynamic> response =
          await supabase.from('users').select().eq('id', id).single();
      // [{id: c62da5b2-6959-4e15-a438-35be1194f857, updated_at: 2024-01-04T11:02:14.735311+00:00, last_name: null, first_name: null, address: null, zipcode: null, city: null, role_id: cb545524-18bb-4e53-8527-456e904d00c1}]
      print("Response Supabase ${response.toString()}");

      if (response.isEmpty) {
        throw Exception("500: Internal server error");
      }

      final UserModel user = UserModel.fromJson(response);
      print("UserModel user = $user");

      DriverModel? driver;
      final List<Object?> data = [user, null];

      if (user.roleId != "9cf60c0b-7920-40f1-a693-4f6c0a0c581a") {
        return data;
      }

      final Map<String, dynamic> driverResponse =
          await supabase.from('drivers').select().eq('user_id', id).single();
      print("driverResponse Supabase ${driverResponse.toString()}");

      if (driverResponse.isEmpty) {
        throw Exception("500: Internal server error on driver request");
      }

      driver = DriverModel.fromJson(driverResponse);
      print("DriverModel driver = $driver");
      print(driverResponse.toString());
      final List<Object> driverData = [user, driver];
      return driverData;
    } catch (e) {
      print("[UserService] getCurrentUser: ${e.toString()}");
      rethrow;
    }
  }
}
