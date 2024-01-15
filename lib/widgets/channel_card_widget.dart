import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ovtc_app/bloc/app/app_bloc.dart';
import 'package:ovtc_app/models/channel_model.dart';
import 'package:ovtc_app/routing/ovtc_router.dart';
import 'package:ovtc_app/utils/datetime_format_extension.dart';
import 'package:ovtc_app/utils/string_casing_extension.dart';

class ChannelCard extends StatelessWidget {
  const ChannelCard({super.key, required this.channelData});
  final ChannelModel channelData;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          return ListTile(
            onTap: () =>
                context.push(OVTCRouter.messages, extra: channelData.id),
            title: channelData.title != null
                ? Text(channelData.title!.toCapitalized())
                : const Text("New channel"),

            subtitle: channelData.lastMessageId != null
                ? Text(channelData.lastMessage!.content.toCapitalized())
                : const Text("There are no messages yet"),

            trailing: channelData.lastMessageId != null
                ? Wrap(
                    spacing: 15,
                    children: [
                      Column(
                        children: [
                          Text(channelData.lastMessage!.createdAt
                              .toDateFormat()),
                          Text(channelData.lastMessage!.createdAt
                              .toHoursFormat())
                        ],
                      ),
                      const Icon(Icons.arrow_forward_ios_rounded)
                    ],
                  )
                : const Icon(Icons.arrow_forward_ios_rounded),

            titleTextStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
              color: state.isDarkMode ? Colors.white : Colors.black,
            ),
            subtitleTextStyle: TextStyle(
              fontSize: 12.0,
              color: state.isDarkMode ? Colors.white : Colors.black,
            ),
            // leadingAndTrailingTextStyle: TextStyle(
            //   fontSize: 14.0,
            //   color: state.isDarkMode ? Colors.white : Colors.black,
            // ),
          );
        },
      ),
    );
  }
}
