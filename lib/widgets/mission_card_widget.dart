import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ovtc_app/bloc/app/app_bloc.dart';
import 'package:ovtc_app/models/mission_model.dart';
import 'package:ovtc_app/utils/snackbar_show_extension.dart';

class MissionCard extends StatelessWidget {
  const MissionCard({super.key, required this.mission});
  final MissionModel mission;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          return ListTile(
            onTap: () => {
              context.showSnackBar(
                  message:
                      "This feature has not yet been created. It will have to show informations Contact's and block ans deblock.")
            },
            leading: const Icon(
              Icons.person,
            ),
            title: const Text("TEXT TITLE"),
            trailing: const Text("TRAILLING"),
            titleTextStyle: TextStyle(
              fontSize: 16.0,
              color: state.isDarkMode ? Colors.white : Colors.black,
            ),
            leadingAndTrailingTextStyle: TextStyle(
              fontSize: 14.0,
              color: state.isDarkMode ? Colors.white : Colors.black,
            ),
          );
        },
      ),
    );
  }
}
