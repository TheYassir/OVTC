part of 'channel_bloc.dart';

abstract class ChannelEvent {
  const ChannelEvent();
}

class LoadAllChannelsEvent extends ChannelEvent {
  final String authId;

  const LoadAllChannelsEvent({
    required this.authId,
  });
}

class SendMessageEvent extends ChannelEvent {
  final String content;
  final String authId;
  final String channelId;

  const SendMessageEvent({
    required this.content,
    required this.authId,
    required this.channelId,
  });
}
