import 'dart:io';

import 'package:http/http.dart';
import 'package:ovtc_app/models/auth_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class UserService {
// Future<UserModel>
  static getCurrentUser({required id}) async {
    final List<Map<String, dynamic>> response =
        await supabase.from('users').select().eq('id', id);
    // [{id: c62da5b2-6959-4e15-a438-35be1194f857, updated_at: 2024-01-04T11:02:14.735311+00:00, last_name: null, first_name: null, address: null, zipcode: null, city: null, role_id: cb545524-18bb-4e53-8527-456e904d00c1}]

    // if (response.statusCode == 200) {
    //   final user = UserModel.fromJson(jsonDecode(response.body));

    //   return user;
    // } else {
    //   print(
    //       'Failed to load user, error ${response.statusCode} : ${response.body}');
    //   throw ObankrootException(response);
    // }
    print(response.toString());
    return response;
  }
}
