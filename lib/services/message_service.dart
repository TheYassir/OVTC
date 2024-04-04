import 'package:ovtc_app/models/detail_other_user_model.dart';
import 'package:ovtc_app/models/message_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

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

  static Future sendMessage({
    required String authId,
    required String content,
    required String channelId,
  }) async {
    try {
      MessageModel newMessage = MessageModel(
        id: const Uuid().v4(),
        createdAt: DateTime.now(),
        content: content,
        contentType: null,
        channelId: channelId,
        userId: authId,
      );

      await supabase.from('messages').insert(newMessage.toJson());
      print("[ChannelService] sendMessage send");
    } catch (e) {
      print("[ChannelService] sendMessage: ${e.toString()}");
      rethrow;
    }
  }
}
