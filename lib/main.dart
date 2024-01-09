import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ovtc_app/bloc/account/account_bloc.dart';
import 'package:ovtc_app/bloc/app/app_bloc.dart';
import 'package:ovtc_app/bloc/auth/auth_bloc.dart';
import 'package:ovtc_app/utils/ovtc_theme.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (BuildContext context) =>
              AuthBloc()..add(InitializeSupabaseEvent()),
        ),
        BlocProvider<AppBloc>(
          create: (BuildContext context) => AppBloc(),
        ),
      ],
      child: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: state.isDarkMode
                  ? OVTCTheme.colorSchemeDark
                  : OVTCTheme.colorScheme,
            ),
            routerConfig: OVTCRouter.router,
          );
        },
      ),
    );
  }
}
