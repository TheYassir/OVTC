import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ovtc_app/bloc/auth/auth_bloc.dart';
import 'package:ovtc_app/components/OVTC_appbar.dart';
import 'package:ovtc_app/routing/ovtc_router.dart';

class MessagesPage extends StatelessWidget {
  final String channelId;

  const MessagesPage({super.key, required this.channelId});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          state.toString();
          if (state.errorMessage != null) {
            // Display bug
            // ScaffoldMessenger.of(context).clearSnackBars();
            // ScaffoldMessenger.of(context).removeCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Center(
                    child: Text(
                  state.errorMessage.toString(),
                  style: const TextStyle(fontSize: 18),
                )),
                backgroundColor: Colors.red[900],
              ),
            );
          }
        },
        child: Scaffold(
            appBar: const OVTCAppBar(),
            // bottomNavigationBar: OVTC,
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    return const Text("Talk Une discussion avec une personne");
                  },
                ),
              ),
            )));
  }
}
