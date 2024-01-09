import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ovtc_app/bloc/account/account_bloc.dart';
import 'package:ovtc_app/bloc/app/app_bloc.dart';
import 'package:ovtc_app/bloc/auth/auth_bloc.dart';
import 'package:ovtc_app/components/OVTC_appbar.dart';
import 'package:ovtc_app/components/ovtc_bottombar.dart';
import 'package:ovtc_app/routing/ovtc_router.dart';
import 'package:ovtc_app/widgets/account_card_widget.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key, required this.authId});
  final String authId;
  @override
  Widget build(BuildContext context) {
    print("AUth ID AccoundPage: $authId");
    return BlocProvider(
        lazy: false,
        create: (context) => AccountBloc()..add(AuthToUserEvent(id: authId)),
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, authState) {
            if (authState.auth == null) {
              context.go(OVTCRouter.login);
            }
          },
          child: Scaffold(
            appBar: const OVTCAppBar(),
            bottomNavigationBar: const OVTCBottomBar(),
            body: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BlocBuilder<AccountBloc, AccountState>(
                        builder: (context, state) {
                      if (state.user != null) {
                        return const CircularProgressIndicator();
                      } else {
                        return Expanded(
                          child: ListView.builder(
                              itemCount: state.user?.toJson().length,
                              itemBuilder: (context, index) {
                                return AccountCard(
                                    data: state.user!
                                        .toJson()
                                        .entries
                                        .elementAt(index));
                              }),
                        );
                      }
                    }),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Dark Mode'),
                        BlocBuilder<AppBloc, AppState>(
                          builder: (appContext, appState) {
                            return Checkbox(
                              checkColor: Colors.white,
                              value: appState.isDarkMode,
                              onChanged: (value) => context
                                  .read<AppBloc>()
                                  .add(ThemeToggleEvent()),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            context.read<AuthBloc>().add(AuthLogoutEvent());
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3.0),
                            ),
                          ),
                          child: const Text('Logout'),
                        ),
                      ],
                    )
                  ],
                )),
          ),
        ));
  }
}
