import 'package:go_router/go_router.dart';
import 'package:ovtc_app/pages/account_page.dart';

import 'package:ovtc_app/pages/home_page.dart';
import 'package:ovtc_app/pages/login_page.dart';
import 'package:ovtc_app/pages/notifications_page.dart';
import 'package:ovtc_app/pages/register_page.dart';
import 'package:ovtc_app/pages/talk_page.dart';
import 'package:ovtc_app/pages/talks_page.dart';

class OVTCRouter {
  static const String home = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String account = '/account';

  static final GoRouter router = GoRouter(
    // Changer pour Login
    initialLocation: home,
    routes: [
      GoRoute(
        path: login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: register,
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
          path: home,
          builder: (context, state) => const HomePage(),
          routes: [
            GoRoute(
              path: account,
              builder: (context, state) => const AccountPage(),
            ),
            GoRoute(
              path: account,
              builder: (context, state) => const NotificationsPage(),
            ),
            GoRoute(
                path: account,
                builder: (context, state) => const TalksPage(),
                routes: [
                  GoRoute(
                    path: account,
                    builder: (context, state) => const TalkPage(
                      channelId: "ID",
                    ),
                  ),
                ]),
          ]),
    ],
  );
}
