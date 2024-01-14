import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ovtc_app/models/channel_model.dart';
import 'package:ovtc_app/services/channel_service.dart';

part 'channel_event.dart';
part 'channel_state.dart';

class ChannelBloc extends Bloc<ChannelEvent, ChannelState> {
  ChannelBloc() : super(const ChannelInitialState()) {
    on<LoadAllChannelsEvent>(
        (LoadAllChannelsEvent event, Emitter<ChannelState> emit) async {
      emit(state.copyWith(isLoading: true));

      await ChannelService.getAllChannels(
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
  }
}
