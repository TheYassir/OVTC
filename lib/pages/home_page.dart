import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ovtc_app/bloc/auth/auth_bloc.dart';
import 'package:ovtc_app/bloc/contact/contact_bloc.dart';
import 'package:ovtc_app/components/OVTC_appbar.dart';
import 'package:ovtc_app/components/ovtc_bottombar.dart';
import 'package:ovtc_app/routing/ovtc_router.dart';
import 'package:ovtc_app/utils/ovtc_theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
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
    }, builder: (context, state) {
      // ContactBloc().add(LoadAllContactsEvent(userId: state.auth!.id));

      return const Scaffold(
        appBar: OVTCAppBar(),
        bottomNavigationBar: OVTCBottomBar(),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Home Formulaire mission"),
          ),
        ),
      );
    });
  }
}
