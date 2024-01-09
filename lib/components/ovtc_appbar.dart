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




// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
// import 'package:obankroot/bloc/auth/auth_bloc.dart';
// import 'package:obankroot/routing/obankroot_router.dart';

// class ObankrootAppBar extends StatelessWidget implements PreferredSizeWidget {
//   final String title;

//   const ObankrootAppBar({
//     super.key,
//     required this.title,
//   });

//   String _getCurrentRoute(BuildContext context) {
//     return GoRouterState.of(context).uri.toString();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<AuthBloc, AuthState>(
//       builder: (context, state) {
//         return AppBar(
//           title: Row(
//             children: [
//               Text(title),
//             ],
//           ),
//           elevation: 0,
//           actions: [
//             TextButton(
//               onPressed: () {
//                 if (_getCurrentRoute(context) != ObankrootRouter.preferences) {
//                   context.push(ObankrootRouter.preferences);
//                 }
//               },
//               style: TextButton.styleFrom(
//                 foregroundColor: Colors.white,
//               ),
//               child: Row(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(right: 8.0),
//                     child: Text(state.user!.name),
//                   ),
//                   const Icon(Icons.account_circle),
//                 ],
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight);
// }