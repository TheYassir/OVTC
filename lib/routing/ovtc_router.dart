import 'package:go_router/go_router.dart';

import 'package:ovtc_app/pages/home_page.dart';
import 'package:ovtc_app/pages/login_page.dart';
import 'package:ovtc_app/pages/register_page.dart';

class OVTCRouter {
  static const String home = '/';
  static const String login = '/login';
  static const String register = '/register';

  static final GoRouter router = GoRouter(
    initialLocation: login,
    routes: [
      GoRoute(
        path: login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: home,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: register,
        builder: (context, state) => const RegisterPage(),
      ),
    ],
  );
}
