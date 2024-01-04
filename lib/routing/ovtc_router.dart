import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:ovtc_app/pages/home_page.dart';
import 'package:ovtc_app/pages/login_page.dart';
import 'package:ovtc_app/pages/register_page.dart';

class OVTCRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/register',
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => LoginPage(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => RegisterPage(),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => const HomePage(),
        routes: const [
          // GoRoute(
          //   path: 'vehicle',
          //   builder: (context, state) {
          //     VehicleModel vehicle = state.extra as VehicleModel;
          //     return VehiclePage(vehicle: vehicle);
          //   },
          // )
        ],
      )
    ],
  );
}
