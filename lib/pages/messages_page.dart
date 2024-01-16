import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ovtc_app/bloc/channel/channel_bloc.dart';
import 'package:ovtc_app/components/OVTC_appbar.dart';
import 'package:ovtc_app/components/ovtc_bottombar.dart';
import 'package:ovtc_app/components/ovtc_title_widget.dart';
import 'package:ovtc_app/models/channel_model.dart';
import 'package:ovtc_app/models/detail_other_user.dart';
import 'package:ovtc_app/models/message_model.dart';
import 'package:ovtc_app/services/message_service.dart';
import 'package:ovtc_app/utils/snackbar_show_extension.dart';
import 'package:ovtc_app/widgets/message_bar_widget.dart';
import 'package:ovtc_app/widgets/message_chat_bubble_widget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class MessagesPage extends StatefulWidget {
  final ChannelModel channel;
  final String authId;
  // final List<DetailOtherUserModel> users;

  const MessagesPage({
    super.key,
    required this.channel,
    required this.authId,
  });

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  final _stream = supabase.from('messages').stream(primaryKey: ['id']);
  // final List<DetailOtherUserModel> _users = await MessageService.findAllDetailUsers( channelId: widget.channel.id, authId: widget.authId) ;
  late final List<DetailOtherUserModel> _users;

  Future<void> findUsers() async {
    final res = await MessageService.findAllDetailUsers(
        channelId: widget.channel.id, authId: widget.authId);
    setState(() {
      _users = res;
    });
  }

  @override
  void initState() {
    findUsers();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChannelBloc, ChannelState>(
        listener: (context, state) {
          if (state.channelErrorMessage != null) {
            context.showErrorSnackBar(
                message: state.channelErrorMessage.toString());
          }
        },
        child: Scaffold(
            appBar: const OVTCAppBar(),
            bottomNavigationBar: const OVTCBottomBar(),
            body: Center(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: StreamBuilder(
                    stream: _stream.eq('channel_id', widget.channel.id),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final List<Map<String, dynamic>> messages =
                            snapshot.data!;
                        return Column(
                          children: [
                            OVTCTitle(
                                title: widget.channel.title ?? "New Title"),
                            const Divider(),
                            Expanded(
                              child: messages.isEmpty
                                  ? const Center(
                                      child: Text(
                                          'Start your conversation now :)'),
                                    )
                                  : _users.isNotEmpty
                                      ? ListView.builder(
                                          // reverse: true,
                                          dragStartBehavior:
                                              DragStartBehavior.down,
                                          itemCount: messages.length,
                                          itemBuilder: (context, index) {
                                            final MessageModel message =
                                                MessageModel.fromJson(
                                                    messages[index]);
                                            final DetailOtherUserModel user =
                                                _users.length == 1
                                                    ? _users.first
                                                    : _users.firstWhere(
                                                        (element) =>
                                                            element.id ==
                                                            message.userId);

                                            return MessageChatBubble(
                                              message: message,
                                              user: user,
                                              authId: widget.authId,
                                            );
                                          },
                                        )
                                      : const CircularProgressIndicator(),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            MessageBar(
                              authId: widget.authId,
                              channelId: widget.channel.id,
                            ),
                          ],
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  )),
            )));
  }
}
