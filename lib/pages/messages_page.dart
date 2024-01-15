import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ovtc_app/bloc/channel/channel_bloc.dart';
import 'package:ovtc_app/components/OVTC_appbar.dart';
import 'package:ovtc_app/components/ovtc_bottombar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class MessagesPage extends StatefulWidget {
  final String channelId;

  const MessagesPage({super.key, required this.channelId});

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  final _stream = supabase.from('messages').stream(primaryKey: ['id']);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChannelBloc, ChannelState>(
        listener: (context, state) {
          if (state.channelErrorMessage != null) {
            // Display bug
            // ScaffoldMessenger.of(context).clearSnackBars();
            // ScaffoldMessenger.of(context).removeCurrentSnackBar();
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
        child: Scaffold(
            appBar: const OVTCAppBar(),
            bottomNavigationBar: const OVTCBottomBar(),
            body: Center(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: StreamBuilder(
                    stream: _stream.eq('channel_id', widget.channelId),
                    builder: (context, snapshot) {
                      return Text(snapshot.data.toString());
                    },
                  )),
            )));
  }
}
