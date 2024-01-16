import 'package:ovtc_app/models/detail_other_user.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class MessageService {
  static Future<List<DetailOtherUserModel>> findAllDetailUsers({
    required String channelId,
    required String authId,
  }) async {
    try {
      try {
        List<Map<String, dynamic>> allusers = await supabase
            .from('users_channels')
            .select(
                '''detailOtherUser:user_id(id, first_name, last_name, role_id, email)''')
            .eq("channel_id", channelId)
            .neq("user_id", authId);

        if (allusers.isEmpty) throw Exception("500: Internal server error");

        List<DetailOtherUserModel> detailAllUsers = (allusers.map(
            (detailUser) => DetailOtherUserModel.fromJson(
                detailUser["detailOtherUser"]))).toList();

        return detailAllUsers;
      } catch (e) {
        print("[MessageService] findAllDetailUsers: ${e.toString()}");
        throw Exception("500: Internal server error");
      }
    } catch (e) {
      print("[MessageService] findAllDetailUsers: ${e.toString()}");
      rethrow;
    }
  }
}
