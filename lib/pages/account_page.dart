import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ovtc_app/bloc/account/account_bloc.dart';
import 'package:ovtc_app/bloc/app/app_bloc.dart';
import 'package:ovtc_app/bloc/auth/auth_bloc.dart';
import 'package:ovtc_app/components/OVTC_appbar.dart';
import 'package:ovtc_app/components/ovtc_bottombar.dart';
import 'package:ovtc_app/routing/ovtc_router.dart';
import 'package:ovtc_app/utils/ovtc_theme.dart';
import 'package:ovtc_app/utils/snackbar_show_extension.dart';
import 'package:ovtc_app/widgets/account_card_widget.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key, required this.authId});

  final String authId;

  @override
  Widget build(BuildContext context) {
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
                    const Padding(
                      padding: EdgeInsets.only(bottom: 18.0, top: 2.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'My account',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    BlocBuilder<AccountBloc, AccountState>(
                        builder: (context, state) {
                      if (state.user == null) {
                        return const Padding(
                          padding: EdgeInsets.all(24.0),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      } else {
                        Map<String, dynamic> data = state.user!.toJson();

                        if (state.driver != null) {
                          data.addAll(state.driver!.toJson());
                        }
                        // Remove role_id from object
                        data.removeWhere((key, value) => key.contains("_id"));

                        return Expanded(
                          child: Scrollbar(
                            thumbVisibility: true,
                            thickness: 5,
                            radius: const Radius.circular(20),
                            scrollbarOrientation: ScrollbarOrientation.right,
                            child: ListView.builder(
                                itemCount: data.length,
                                itemBuilder: (context, index) {
                                  return AccountCard(
                                      data: data.entries.elementAt(index));
                                }),
                          ),
                        );
                      }
                    }),
                    const Divider(
                      color: OVTCTheme.primaryColor,
                    ),
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
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            context.showSnackBar(
                              message:
                                  "This feature has not yet been created. It will have to change the account cards by replacing them with fields for modification.",
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.teal,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3.0),
                            ),
                          ),
                          child: const Text('Edit'),
                        ),
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
