import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ovtc_app/bloc/app/app_bloc.dart';
import 'package:ovtc_app/bloc/contact/contact_bloc.dart';
import 'package:ovtc_app/models/contact_model.dart';
import 'package:ovtc_app/models/role_model.dart';
import 'package:ovtc_app/routing/ovtc_router.dart';
import 'package:ovtc_app/utils/datetime_format_extension.dart';
import 'package:ovtc_app/utils/string_casing_extension.dart';

class ContactPendingCard extends StatelessWidget {
  const ContactPendingCard(
      {super.key, required this.data, required this.authId});

  final ContactModel data;
  final String authId;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          return ListTile(
            onTap: data.senderId == authId
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
                                      'How do you want to respond to this contact request ?'),
                                  const SizedBox(height: 32),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      ElevatedButton.icon(
                                        onPressed: () {
                                          context
                                              .read<ContactBloc>()
                                              .add(ResponseContactEvent(
                                                contactId: data.id,
                                                userId: authId,
                                                otherUserId:
                                                    data.detailOtherUser!.id,
                                                accepted: true,
                                                blocked: false,
                                              ));

                                          context.read<AppBloc>().add(
                                              NavbarIndexEvent(navbarIndex: 0));
                                          context.go(OVTCRouter.home,
                                              extra: authId);
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
                                              .read<ContactBloc>()
                                              .add(ResponseContactEvent(
                                                contactId: data.id,
                                                userId: authId,
                                                otherUserId:
                                                    data.detailOtherUser!.id,
                                                accepted: false,
                                                blocked: false,
                                              ));

                                          context.read<AppBloc>().add(
                                              NavbarIndexEvent(navbarIndex: 0));
                                          context.go(OVTCRouter.home,
                                              extra: authId);
                                        },
                                        icon: Icon(
                                          Icons.highlight_off_rounded,
                                          color: Colors.yellow[700],
                                          size: 24,
                                        ),
                                        label: const Text('Refused'),
                                      ),
                                      ElevatedButton.icon(
                                        onPressed: () {
                                          context
                                              .read<ContactBloc>()
                                              .add(ResponseContactEvent(
                                                contactId: data.id,
                                                userId: authId,
                                                otherUserId:
                                                    data.detailOtherUser!.id,
                                                accepted: false,
                                                blocked: true,
                                              ));

                                          context.read<AppBloc>().add(
                                              NavbarIndexEvent(navbarIndex: 0));
                                          context.go(OVTCRouter.home);
                                        },
                                        icon: const Icon(
                                          Icons.block_rounded,
                                          color: Colors.red,
                                          size: 24,
                                        ),
                                        label: const Text('Blocked'),
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
            leading: data.detailOtherUser!.roleId == RoleModel().driverId
                ? const Icon(
                    Icons.local_taxi_rounded,
                  )
                : const Icon(
                    Icons.person,
                  ),
            title: Text(
                "${data.detailOtherUser!.firstName.toCapitalized()} ${data.detailOtherUser!.lastName.toCapitalized()}"),
            subtitle: Column(
              children: [
                const Divider(),
                // const SizedBox(height: 8),
                Text(
                  "Created on ${data.createdAt.toDateFormat()}",
                ),
                data.senderId == authId
                    ? const Text(
                        "Waiting for a reply from the contact",
                      )
                    : const Text(
                        "Waiting for your response.",
                      ),
                if (data.senderId != authId)
                  Text(
                    "Click here to reply.",
                    style: TextStyle(color: Colors.yellow[900]),
                  )
              ],
            ),
            trailing: data.senderId == authId
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
