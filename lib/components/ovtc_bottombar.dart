import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ovtc_app/bloc/app/app_bloc.dart';
import 'package:ovtc_app/bloc/auth/auth_bloc.dart';
import 'package:ovtc_app/routing/ovtc_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ovtc_app/utils/ovtc_theme.dart';

class OVTCBottomBar extends StatelessWidget {
  const OVTCBottomBar({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, stateApp) {
        String? currentPath = GoRouterState.of(context).path;
        Color selectedColor = (currentPath == OVTCRouter.account ||
                currentPath == OVTCRouter.messages ||
                currentPath == OVTCRouter.addContact ||
                currentPath == OVTCRouter.createMission
            ? Colors.white
            : OVTCTheme.secondaryColor);

        return BlocBuilder<AuthBloc, AuthState>(
          builder: (context, authState) {
            return BottomNavigationBar(
              currentIndex: stateApp.navbarIndex,
              backgroundColor: OVTCTheme.primaryColor,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              selectedItemColor: selectedColor,
              unselectedItemColor: Colors.white,
              type: BottomNavigationBarType.fixed,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.phone),
                  label: 'Contact',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.message),
                  label: 'Channels',
                ),
                // BottomNavigationBarItem(
                //   icon: Icon(Icons.notifications),
                //   label: 'Notifications',
                // ),
              ],
              onTap: (index) {
                context
                    .read<AppBloc>()
                    .add(NavbarIndexEvent(navbarIndex: index));

                switch (index) {
                  case 0:
                    context.go(OVTCRouter.home, extra: authState.auth!.id);
                    break;
                  case 1:
                    context.go(OVTCRouter.contact, extra: authState.auth!.id);
                    break;
                  case 2:
                    context.go(OVTCRouter.channels, extra: authState.auth!.id);
                    break;
                  // case 3:
                  //   context.go(OVTCRouter.notifications);
                  //   break;
                }
              },
            );
          },
        );
      },
    );
  }
}
