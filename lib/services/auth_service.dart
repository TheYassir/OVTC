import 'package:ovtc_app/models/auth_model.dart';
import 'package:ovtc_app/models/driver_model.dart';
import 'package:ovtc_app/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:uuid/uuid.dart';

final supabase = Supabase.instance.client;

class AuthService {
  static initialize() async {
    try {
      await Supabase.initialize(
        url: dotenv.env['YOUR_SUPABASE_URL']!,
        anonKey: dotenv.env['YOUR_SUPABASE_ANON_KEY']!,
        debug: true,
        authOptions: const FlutterAuthClientOptions(
          localStorage: EmptyLocalStorage(),
        ),
        realtimeClientOptions: const RealtimeClientOptions(
          eventsPerSecond: 1,
          logLevel: RealtimeLogLevel.debug,
        ),
        storageOptions: const StorageClientOptions(),
        postgrestOptions: const PostgrestClientOptions(),
      );
    } catch (e) {
      print("[AuthService] Initialize: ${e.toString()}");
      rethrow;
    }
  }

  static Future<AuthModel?> login(
      {required String email, required String password}) async {
    try {
      if (email.isEmpty || password.isEmpty) {
        throw const AuthException("Invalid credentials", statusCode: "401");
      }

      final AuthResponse res = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      // print(
      //     "[AuthService] Login: ${AuthModel(id: res.user!.id, email: email).toString()}");
      return AuthModel(id: res.user!.id, email: email);
    } catch (e) {
      print("[AuthService] Login: ${e.toString()}");
      rethrow;
    }
  }

  static Future<AuthModel> register({
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
    try {
      // Fetch request for check if email exist in users table
      final response =
          await supabase.from('users').select('email').eq('email', email);

      // If this is not empty, throw exception because is an error from user or usurpation
      if (response.isNotEmpty) {
        throw const AuthException('Conflict account already exist.',
            statusCode: "409");
      }

      // Send request for create Authentification for new user
      final AuthResponse res = await supabase.auth.signUp(
        email: email,
        password: password,
      );

      // Check if the request is not null and throw Exception if is it
      if (res.user!.id.isNotEmpty) {
        try {
          // Prepare updates on the User Table
          final UserModel newUser = UserModel(
            id: res.user!.id,
            lastName: lastName,
            firstName: firstName,
            address: address,
            zipcode: zipcode,
            city: city,
            email: email,
            roleId: roleId,
          );

          // Send Upsert with all updates and use true on parameter defaultToNull
          await supabase
              .from('users')
              .upsert(newUser.toJson(), defaultToNull: true);
        } catch (e) {
          // Print for Debug, on the future add it on logs
          print("[AuthService] Upsert: ${e.toString()}");
          throw e.toString();
        }

        // Check if the roleId is Driver
        if (roleId == "9cf60c0b-7920-40f1-a693-4f6c0a0c581a" &&
            companyName!.isNotEmpty &&
            siren!.isNotEmpty) {
          // Using UUID's librairie for better security on ID
          // UUID.v4 is for ramdom UUID
          DriverModel newDriver = DriverModel(
              id: const Uuid().v4(),
              userId: res.user!.id,
              companyName: companyName,
              siren: siren);

          try {
            // Insert driver's data into the Drivers's Table
            await supabase.from('drivers').insert(newDriver.toJson());
          } catch (e) {
            print("[AuthService] Create Driver: ${e.toString()}");
            throw Exception(e.toString());
          }
        }
      } else {
        print("[AuthService] Fail on Register request");
        throw const AuthException('Failed on register.', statusCode: "500");
      }

      return AuthModel(id: res.user!.id, email: email);
    } catch (e) {
      print("[AuthService] Error ${e.toString()}");
      rethrow;
    }
  }

  static Future<void> logout() async {
    try {
      await supabase.auth.signOut();
    } catch (e) {
      print("[AuthService] Logout: ${e.toString()}");
      throw Exception(e.toString());
    }
  }
}
