import 'package:ovtc_app/models/channel_model.dart';
import 'package:ovtc_app/models/user_channel_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

final supabase = Supabase.instance.client;

class ChannelService {
  static void createChannelAfterContact(
      {required String userId, required String otherUserId}) async {
    try {
      String channelId = const Uuid().v4();
      ChannelModel newChannel = ChannelModel(id: channelId);
      try {
        await supabase
            .from('channels')
            .insert(newChannel.toJson(), defaultToNull: true);
      } catch (e) {
        print("[ChannelService] insert new channel: ${e.toString()}");
        throw Exception("500: Internal server error");
      }

      try {
        UserChannelModel userChannel = UserChannelModel(
            id: const Uuid().v4(), userId: userId, channelId: channelId);
        UserChannelModel otherUserChannel = UserChannelModel(
            id: const Uuid().v4(), userId: otherUserId, channelId: channelId);

        await supabase.from('users_channels').insert(
            [userChannel.toJson(), otherUserChannel.toJson()],
            defaultToNull: true);
      } catch (e) {
        print("[ChannelService] insert news UserChannel: ${e.toString()}");
        throw Exception("500: Internal server error");
      }

      print("[ChannelService] insert: good");
    } catch (e) {
      print("[ChannelService] createChannelAfterContact: ${e.toString()}");
      rethrow;
    }
  }
}
