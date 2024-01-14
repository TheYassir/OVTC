import 'package:ovtc_app/models/channel_model.dart';
import 'package:ovtc_app/models/user_channel_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

final supabase = Supabase.instance.client;

class ChannelService {
  static Future createChannelAfterContact(
      {required String userId, required String otherUserId}) async {
    try {
      String channelId = const Uuid().v4();
      ChannelModel newChannel = ChannelModel(
        id: channelId,
        title: null,
        lastUpdate: DateTime.now().toIso8601String(),
      );
      try {
        await supabase.from('channels').insert(newChannel.toJson());
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

      print("[ChannelService] createChannelAfterContact: good");
    } catch (e) {
      print("[ChannelService] createChannelAfterContact: ${e.toString()}");
      rethrow;
    }
  }

  static Future<List<ChannelModel>?> getAllChannels(
      {required String authId}) async {
    try {
      final List<Map<String, dynamic>> userChannelResponse = await supabase
          .from('users_channels')
          .select('channel_id')
          .eq('user_id', authId);

      // userChannelResponse.map((channelId) async => {
      //   <Map<String, dynamic> response = await supabase
      //     .from('channels')
      //     .select()
      //     .eq('id', channelId)
      // });

      print("userChannelResponse : ${userChannelResponse.toString()}");
      // print("Error on receiverResponse : ${receiverResponse.toString()}");

      List<ChannelModel>? channels;
      // print("Error on value : ${value.toString()}");
      return channels;
    } catch (e) {
      print("[ChannelService] getAllChannel: ${e.toString()}");
      rethrow;
    }
  }
}
