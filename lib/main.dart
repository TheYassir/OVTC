import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:ovtc_app/bloc/auth/auth_bloc.dart';
import 'routing/ovtc_router.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        AuthBloc authBloc = AuthBloc();
        authBloc.add(InitializeSupabaseEvent());
        return authBloc;
      },
      child: MaterialApp.router(
        title: 'OVTC',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        routerConfig: OVTCRouter.router,
      ),
    );
  }
}
