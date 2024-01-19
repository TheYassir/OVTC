import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ovtc_app/bloc/app/app_bloc.dart';
import 'package:ovtc_app/bloc/mission/mission_bloc.dart';
import 'package:ovtc_app/models/mission_model.dart';
import 'package:ovtc_app/models/role_model.dart';
import 'package:ovtc_app/utils/datetime_format_extension.dart';
import 'package:ovtc_app/utils/string_casing_extension.dart';

class MissionPendingCard extends StatelessWidget {
  final MissionModel mission;
  final String authId;
  const MissionPendingCard(
      {super.key, required this.mission, required this.authId});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          return ListTile(
            onTap: mission.senderId == authId
                ? () {}
                : () => {
                      showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return SizedBox(
                            height: 200,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  const Text(
                                      'How do you want to respond to this contact request?'),
                                  const SizedBox(height: 32),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      ElevatedButton.icon(
                                        onPressed: () {
                                          context
                                              .read<MissionBloc>()
                                              .add(ResponseMissionEvent(
                                                missionId: mission.id,
                                                isAccepted: true,
                                                isRefused: false,
                                              ));

                                          context.pop();
                                        },
                                        icon: const Icon(
                                          Icons.check_circle_outline_rounded,
                                          color: Colors.green,
                                          size: 24,
                                        ),
                                        label: const Text('Accepted'),
                                      ),
                                      ElevatedButton.icon(
                                        onPressed: () {
                                          context
                                              .read<MissionBloc>()
                                              .add(ResponseMissionEvent(
                                                missionId: mission.id,
                                                isAccepted: false,
                                                isRefused: true,
                                              ));

                                          context.pop();
                                        },
                                        icon: Icon(
                                          Icons.highlight_off_rounded,
                                          color: Colors.yellow[700],
                                          size: 24,
                                        ),
                                        label: const Text('Refused'),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      )
                    },
            leading: mission.detailOtherUser!.roleId == RoleModel().driverId
                ? const Icon(
                    Icons.local_taxi_rounded,
                  )
                : const Icon(
                    Icons.person,
                  ),
            title: Text(
              "${mission.detailOtherUser!.firstName.toCapitalized()} ${mission.detailOtherUser!.lastName.toCapitalized()}",
              textAlign: TextAlign.center,
            ),
            subtitle: Column(
              children: [
                const Divider(),
                // const SizedBox(height: 8),
                Text(
                  "Date Start on ${mission.dateStart.toDateFormat()}",
                  textAlign: TextAlign.center,
                ),
                mission.senderId == authId
                    ? const Text(
                        "Waiting for a reply from the contact",
                        textAlign: TextAlign.center,
                      )
                    : const Text(
                        "Waiting for your response.",
                        textAlign: TextAlign.center,
                      ),
                if (mission.senderId != authId)
                  Text(
                    "Click here to reply.",
                    style: TextStyle(color: Colors.yellow[900]),
                  )
              ],
            ),
            trailing: mission.senderId == authId
                ? const Icon(Icons.watch_later_outlined)
                : Icon(
                    Icons.warning_amber_rounded,
                    color: Colors.yellow[900],
                  ),
            titleTextStyle: TextStyle(
              fontSize: 16.0,
              color: state.isDarkMode ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
            subtitleTextStyle: TextStyle(
              fontSize: 16.0,
              color: state.isDarkMode ? Colors.white : Colors.black,
            ),
            leadingAndTrailingTextStyle: TextStyle(
              fontSize: 14.0,
              color: state.isDarkMode ? Colors.white : Colors.black,
            ),
          );
        },
      ),
    );
  }
}
