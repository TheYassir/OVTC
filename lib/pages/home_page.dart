import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ovtc_app/bloc/mission/mission_bloc.dart';
import 'package:ovtc_app/components/OVTC_appbar.dart';
import 'package:ovtc_app/components/ovtc_bottombar.dart';
import 'package:ovtc_app/components/ovtc_title_widget.dart';
import 'package:ovtc_app/routing/ovtc_router.dart';
import 'package:ovtc_app/utils/ovtc_theme.dart';
import 'package:ovtc_app/utils/snackbar_show_extension.dart';
import 'package:ovtc_app/widgets/mission_card_pending_widget.dart';
import 'package:ovtc_app/widgets/mission_card_widget.dart';

class HomePage extends StatelessWidget {
  final String authId;
  const HomePage({super.key, required this.authId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: true,
      create: (context) =>
          MissionBloc()..add(LoadAllMissionsEvent(authId: authId)),
      child: BlocConsumer<MissionBloc, MissionState>(
        listener: (context, state) {
          if (state.missionErrorMessage != null) {
            context.showErrorSnackBar(
                message: state.missionErrorMessage.toString());
          }
        },
        builder: (context, state) {
          return Scaffold(
              appBar: const OVTCAppBar(),
              bottomNavigationBar: const OVTCBottomBar(),
              floatingActionButton: FloatingActionButton(
                backgroundColor: OVTCTheme.primaryColor,
                onPressed: () => context.push(OVTCRouter.createMission, extra: {
                  "authId": authId,
                  "roleId": state.roleId,
                  "contacts": state.contacts,
                }),
                child: const Icon(
                  Icons.add_location_rounded,
                  color: OVTCTheme.secondaryColor,
                  size: 32,
                ),
              ),
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
                                OVTCTitle(title: "Accepted Missions"),
                              ],
                            ),
                          ),
                          state.acceptedMissions?.firstOrNull == null
                              ? const Expanded(
                                  flex: 1,
                                  child: Text(
                                    "List of accepted missions empty !",
                                    style: TextStyle(
                                      fontSize: 16.0,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              : Expanded(
                                  flex: 2,
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: state.acceptedMissions!.length,
                                      itemBuilder: (context, index) =>
                                          MissionCard(
                                            mission: state.acceptedMissions!
                                                .elementAt(index),
                                          )),
                                ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                OVTCTitle(title: "Pending request"),
                              ],
                            ),
                          ),
                          state.pendingMissions?.firstOrNull == null
                              ? const Expanded(
                                  flex: 1,
                                  child: Text(
                                    "List of pending mission requests empty ! New mission requests will be posted here",
                                    style: TextStyle(
                                      fontSize: 16.0,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              : Expanded(
                                  flex: 3,
                                  child: ListView.builder(
                                      itemCount: state.pendingMissions!.length,
                                      itemBuilder: (context, index) =>
                                          MissionPendingCard(
                                            mission:
                                                state.pendingMissions![index],
                                            authId: authId,
                                          )),
                                ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                OVTCTitle(title: "Refused missions"),
                              ],
                            ),
                          ),
                          state.refusedMissions?.firstOrNull == null
                              ? const Expanded(
                                  flex: 1,
                                  child: Text(
                                    "List of refused missions empty !",
                                    style: TextStyle(
                                      fontSize: 16.0,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              : Expanded(
                                  flex: 1,
                                  child: ListView.builder(
                                      itemCount: state.refusedMissions!.length,
                                      itemBuilder: (context, index) =>
                                          MissionCard(
                                              mission: state
                                                  .refusedMissions![index])),
                                ),
                        ],
                      ),
                    ));
        },
      ),
    );
  }
}
