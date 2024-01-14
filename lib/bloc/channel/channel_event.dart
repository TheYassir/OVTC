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
