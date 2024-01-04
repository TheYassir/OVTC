import 'package:ovtc_app/models/auth_model.dart';
import 'package:ovtc_app/models/driver_model.dart';
import 'package:ovtc_app/models/user_model.dart';
import 'package:ovtc_app/services/user_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final supabase = Supabase.instance.client;

class AuthService {
  static initialize() async {
    await Supabase.initialize(
      url: dotenv.env['YOUR_SUPABASE_URL']!,
      anonKey: dotenv.env['YOUR_SUPABASE_ANON_KEY']!,
    );
  }

// Future<UserModel>
  static Future<AuthResponse> login({required email, required password}) async {
    final AuthResponse res = await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
    UserService.getCurrentUser(id: res.user?.id);

    return res;
  }

  static register({
    required String email,
    required String password,
    required String lastName,
    required String firstName,
    required String address,
    required int zipcode,
    required String city,
    required String roleId,
    String? companyName,
    String? siren,
  }) async {
    final AuthResponse res = await supabase.auth.signUp(
      email: email,
      password: password,
    );

    final Session? session = res.session;
    final User? user = res.user;

    UserModel newUser = UserModel(
        id: res.user!.id,
        lastName: lastName,
        firstName: firstName,
        address: address,
        zipcode: zipcode,
        city: city,
        roleId: roleId);

    print(newUser.toJson());

    print("################");
    if (roleId == "9cf60c0b-7920-40f1-a693-4f6c0a0c581a" &&
        companyName!.isNotEmpty &&
        siren!.isNotEmpty) {
      DriverModel newDriver = DriverModel(
          userId: res.user!.id, companyName: companyName, siren: siren);
      print(newDriver.toJson());

      // await supabase
      //     .from('drivers')
      //     .insert(newDriver.toJson());
    }

    // await supabase
    //   .from('users')
    //   .update(newDriver.toJson())
    //   .match({ 'id': res.user?.id });
  }

  static logout() async {
    await supabase.auth.signOut();
  }
}
