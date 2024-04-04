import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ovtc_app/bloc/channel/channel_bloc.dart';
import 'package:ovtc_app/components/OVTC_appbar.dart';
import 'package:ovtc_app/components/ovtc_bottombar.dart';
import 'package:ovtc_app/components/ovtc_title_widget.dart';
import 'package:ovtc_app/services/channel_service.dart';
import 'package:ovtc_app/utils/snackbar_show_extension.dart';
import 'package:ovtc_app/widgets/channel_card_widget.dart';

class ChannelsPage extends StatelessWidget {
  const ChannelsPage({super.key, required this.authId});

  final String authId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        lazy: false,
        create: (context) => ChannelBloc(service: ChannelService())
          ..add(LoadAllChannelsEvent(authId: authId)),
        child:
            BlocConsumer<ChannelBloc, ChannelState>(listener: (context, state) {
          if (state.channelErrorMessage != null) {
            context.showErrorSnackBar(
                message: state.channelErrorMessage.toString());
          }
        }, builder: (context, state) {
          return Scaffold(
            appBar: const OVTCAppBar(),
            bottomNavigationBar: const OVTCBottomBar(),
            body: state.isLoading
                ? const Center(child: CircularProgressIndicator())
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              OVTCTitle(title: "Channels list"),
                            ],
                          ),
                        ),
                        state.channels?.firstOrNull == null
                            ? const Expanded(
                                child: Text(
                                  "Empty channel list ! Add new contacts to start chatting",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            : Expanded(
                                child: ListView.builder(
                                    itemCount: state.channels!.length,
                                    itemBuilder: (context, index) {
                                      return ChannelCard(
                                          channelData: state.channels![index],
                                          authId: authId);
                                    }),
                              ),
                      ],
                    ),
                  ),
          );
        }));
  }
}
