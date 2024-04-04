import 'package:ovtc_app/models/channel_model.dart';
import 'package:ovtc_app/models/message_model.dart';
import 'package:ovtc_app/models/user_channel_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

final supabase = Supabase.instance.client;

class ChannelService {
  static Future createChannelAfterContact({
    required String userId,
    required String otherUserId,
    required String title,
  }) async {
    try {
      String channelId = const Uuid().v4();
      ChannelModel newChannel = ChannelModel(
        id: channelId,
        title: title,
        lastUpdate: DateTime.now(),
        lastMessageId: null,
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

      // print("[ChannelService] createChannelAfterContact: good");
    } catch (e) {
      print("[ChannelService] createChannelAfterContact: ${e.toString()}");
      rethrow;
    }
  }

  Future<List<ChannelModel>?> getAllChannels({
    required String authId,
  }) async {
    try {
      // Select all channels with user id
      final List<Map<String, dynamic>> userChannelResponse = await supabase
          .from('users_channels')
          .select('channel_id')
          .eq('user_id', authId);

      // print("userChannelResponse : ${userChannelResponse.toString()}");

      // if he does't have channels return empty
      if (userChannelResponse.isEmpty) return [];

      List<ChannelModel> channels = [];

      // Searched all of channels with id and added it on list channels. Use request custom to search foreignkey last_message
      try {
        await Future.wait(userChannelResponse.map((element) async => {
              channels.add(ChannelModel.fromJson(await supabase
                  .from('channels')
                  .select('''*,last_message:last_message_id(*)''')
                  .eq('id', element['channel_id'])
                  .single()))
            }));
      } catch (e) {
        print("[ChannelService] Future.wait Channels : ${e.toString()}");
        throw Exception("500: Internal server error");
      }
      // print("channels: ${channels.toString()}");

      // Did same for find lastMessage
      List<ChannelModel> channelsWithLastMessage = [];
      try {
        await Future.wait(channels.map((element) async => {
              if (element.lastMessageId != null)
                {
                  element.lastMessage = MessageModel.fromJson(await supabase
                      .from('messages')
                      .select()
                      .eq('id', element.lastMessageId.toString())
                      .single())
                },
              channelsWithLastMessage.add(element),
            }));
      } catch (e) {
        print("[ChannelService] Future.wait LastMessage : ${e.toString()}");
        throw Exception("500: Internal server error");
      }
      // print("channels: ${channelsWithLastMessage.toString()}");
      return channelsWithLastMessage;
    } catch (e) {
      print("[ChannelService] getAllChannels: ${e.toString()}");
      rethrow;
    }
  }
}
