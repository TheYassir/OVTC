part of 'channel_bloc.dart';

class ChannelState extends Equatable {
  final List<ChannelModel>? channels;
  final bool isLoading;
  final String? channelErrorMessage;

  const ChannelState({
    required this.channels,
    required this.isLoading,
    required this.channelErrorMessage,
  });

  ChannelState copyWith({
    List<ChannelModel>? channels,
    bool? isLoading,
    String? channelErrorMessage,
  }) {
    return ChannelState(
      channels: channels ?? this.channels,
      isLoading: isLoading ?? this.isLoading,
      channelErrorMessage: channelErrorMessage ?? this.channelErrorMessage,
    );
  }

  @override
  List<Object?> get props => [channels, isLoading, channelErrorMessage];

  @override
  String toString() {
    return 'ChannelState{contact: $channels, isLoading: $isLoading, channelErrorMessage: $channelErrorMessage}';
  }
}

class ChannelInitialState extends ChannelState {
  const ChannelInitialState()
      : super(channels: null, isLoading: false, channelErrorMessage: null);
}
