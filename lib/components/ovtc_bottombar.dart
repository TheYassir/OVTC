import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ovtc_app/bloc/app/app_bloc.dart';
import 'package:ovtc_app/routing/ovtc_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ovtc_app/utils/ovtc_theme.dart';

class ObankrootBottomBar extends StatelessWidget
    implements PreferredSizeWidget {
  final List<String> _paths = const [
    OVTCRouter.home,
    // OVTCRouter.preferences,
    // OVTCRouter.messages,
  ];

  const ObankrootBottomBar({
    super.key,
  });

  int _getCurrentIndex(BuildContext context) {
    String? currentPath = GoRouterState.of(context).path;
    if (currentPath == null || currentPath == OVTCRouter.home) {
      return 0;
    }
    // Compare the first segment of the current path with the paths of the bottom bar items
    // This enables to work with all the paths of the app, even if they are nested
    String currentRootPath = GoRouterState.of(context).uri.pathSegments[0];
    return _paths.indexOf("/$currentRootPath");
  }

  void _onItemTapped(BuildContext context, {required int index}) {
    context.go(_paths[index]);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return BottomNavigationBar(
          backgroundColor:
              state.isDarkMode ? Colors.black : OVTCTheme.primaryColor,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          currentIndex: _getCurrentIndex(context),
          onTap: (index) => _onItemTapped(context, index: index),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              label: 'Messages',
              tooltip: 'Messages',
              icon: Icon(Icons.message),
              activeIcon: Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Icon(Icons.message),
              ),
            ),
            BottomNavigationBarItem(
              label: 'Home',
              tooltip: 'Home',
              icon: Icon(Icons.home),
              activeIcon: Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Icon(Icons.home),
              ),
            ),
            BottomNavigationBarItem(
              label: 'Notifications',
              tooltip: 'Notifications',
              icon: Icon(Icons.notifications),
              activeIcon: Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Icon(Icons.notifications_active),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
