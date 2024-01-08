import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ovtc_app/bloc/auth/auth_bloc.dart';
import 'package:ovtc_app/routing/ovtc_router.dart';

class OVTCAppBar extends StatelessWidget implements PreferredSizeWidget {
  const OVTCAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("O'VTC"),
      elevation: 0,
      actions: [
        BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state.auth == null) {
              context.go(OVTCRouter.login);
            }
            return TextButton(
              onPressed: () {
                // context.go(OVTCRouter.account);
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
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
