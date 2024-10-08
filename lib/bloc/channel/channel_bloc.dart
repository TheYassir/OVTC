import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ovtc_app/models/channel_model.dart';
import 'package:ovtc_app/services/channel_service.dart';
import 'package:ovtc_app/services/message_service.dart';

part 'channel_event.dart';
part 'channel_state.dart';

class ChannelBloc extends Bloc<ChannelEvent, ChannelState> {
  ChannelBloc({required ChannelService service})
      : super(const ChannelInitialState()) {
    on<LoadAllChannelsEvent>(
        (LoadAllChannelsEvent event, Emitter<ChannelState> emit) async {
      emit(state.copyWith(isLoading: true));

      await service
          .getAllChannels(
            authId: event.authId,
          )
          .then((value) => emit(state.copyWith(
                channels: value,
                isLoading: false,
              )))
          .catchError((onError) => emit(state.copyWith(
                channelErrorMessage: onError.toString(),
                isLoading: false,
              )));
    });

    on<SendMessageEvent>(
        (SendMessageEvent event, Emitter<ChannelState> emit) async {
      emit(state.copyWith(isLoading: true));

      await MessageService.sendMessage(
        channelId: event.channelId,
        authId: event.authId,
        content: event.content,
      )
          .then((value) => emit(state.copyWith(
                isLoading: false,
              )))
          .catchError((onError) => emit(state.copyWith(
                channelErrorMessage: onError.toString(),
                isLoading: false,
              )));
    });
  }
}
