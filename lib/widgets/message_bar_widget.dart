import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ovtc_app/bloc/channel/channel_bloc.dart';

class MessageBar extends StatefulWidget {
  final String authId;
  final String channelId;

  const MessageBar({super.key, required this.authId, required this.channelId});

  @override
  State<MessageBar> createState() => _MessageBarState();
}

class _MessageBarState extends State<MessageBar> {
  @override
  void initState() {
    super.initState();
  }

  void clearText(TextEditingController controller) {
    if (controller.text.isNotEmpty) controller.clear();
  }

  final _formkey = GlobalKey<FormState>();
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChannelBloc, ChannelState>(
      builder: (context, state) {
        return Form(
            key: _formkey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 5,
                  child: TextFormField(
                      controller: _messageController,
                      autocorrect: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please write a message first';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Message*',
                      )),
                ),
                Expanded(
                    flex: 1,
                    child: state.isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : SizedBox(
                            height: 60,
                            width: 50,
                            child: IconButton(
                              onPressed: () {
                                if (_formkey.currentState!.validate()) {
                                  context
                                      .read<ChannelBloc>()
                                      .add(SendMessageEvent(
                                        content: _messageController.text,
                                        authId: widget.authId,
                                        channelId: widget.channelId,
                                      ));

                                  _messageController.clear();
                                }
                              },
                              icon: const Icon(
                                Icons.send_rounded,
                              ),
                            ),
                          ))
              ],
            ));
      },
    );
  }
}
