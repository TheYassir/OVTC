import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ovtc_app/bloc/account/account_bloc.dart';
import 'package:ovtc_app/bloc/app/app_bloc.dart';
import 'package:ovtc_app/bloc/auth/auth_bloc.dart';
import 'package:ovtc_app/bloc/channel/channel_bloc.dart';
import 'package:ovtc_app/components/OVTC_appbar.dart';
import 'package:ovtc_app/components/ovtc_bottombar.dart';
import 'package:ovtc_app/routing/ovtc_router.dart';
import 'package:ovtc_app/utils/ovtc_theme.dart';
import 'package:ovtc_app/widgets/account_card_widget.dart';

class ChannelsPage extends StatelessWidget {
  const ChannelsPage({super.key, required this.authId});

  final String authId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        lazy: false,
        create: (context) =>
            ChannelBloc()..add(LoadAllChannelsEvent(authId: authId)),
        child: BlocConsumer<ChannelBloc, ChannelState>(
          listener: (context, state) {
            if (state.channelErrorMessage != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Center(
                      child: Text(
                    state.channelErrorMessage.toString(),
                    style: const TextStyle(fontSize: 18),
                  )),
                  backgroundColor: Colors.red[900],
                ),
              );
            }
          },
          builder: (context, state) {
            return Scaffold(
                appBar: const OVTCAppBar(),
                bottomNavigationBar: const OVTCBottomBar(),
                body: state.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: Text("CHANNELSPAGE"),
                        ),
                      ));
          },
        ));
  }
}
