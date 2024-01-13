import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ovtc_app/bloc/app/app_bloc.dart';
import 'package:ovtc_app/bloc/auth/auth_bloc.dart';
import 'package:ovtc_app/routing/ovtc_router.dart';
import 'package:ovtc_app/utils/ovtc_theme.dart';

class OVTCAppBar extends StatelessWidget implements PreferredSizeWidget {
  const OVTCAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        "O'VTC",
        style: TextStyle(color: Colors.white),
      ),
      elevation: 0,
      backgroundColor: OVTCTheme.primaryColor,
      actions: [
        BlocBuilder<AppBloc, AppState>(
          builder: (context, state) {
            return Row(
              children: [
                IconButton(
                  onPressed: () =>
                      context.read<AppBloc>().add(ThemeToggleEvent()),
                  icon: state.isDarkMode
                      ? const Icon(
                          Icons.sunny,
                          color: OVTCTheme.secondaryColor,
                        )
                      : const Icon(
                          Icons.mode_night,
                          color: OVTCTheme.secondaryColor,
                        ),
                ),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, authState) {
                    return TextButton(
                      onPressed: () {
                        context.go(OVTCRouter.account,
                            extra: authState.auth!.id);
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                      ),
                      child: const Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: Text("Yassir"),
                          ),
                          Icon(Icons.account_circle),
                        ],
                      ),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
