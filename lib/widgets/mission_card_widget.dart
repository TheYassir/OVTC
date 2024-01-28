import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ovtc_app/bloc/app/app_bloc.dart';
import 'package:ovtc_app/models/mission_model.dart';
import 'package:ovtc_app/models/role_model.dart';
import 'package:ovtc_app/utils/snackbar_show_extension.dart';
import 'package:ovtc_app/utils/string_casing_extension.dart';

class MissionCard extends StatelessWidget {
  final MissionModel mission;
  const MissionCard({super.key, required this.mission});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          return ListTile(
            onTap: () => {
              context.showSnackBar(
                  message:
                      "This feature has not yet been created. It will have to show Mission's informations.")
            },
            leading: mission.detailOtherUser!.roleId == RoleModel().driverId
                ? const Icon(
                    Icons.local_taxi_rounded,
                  )
                : const Icon(
                    Icons.person,
                  ),
            title: Text(
                "${mission.detailOtherUser!.firstName.toCapitalized()} ${mission.detailOtherUser!.lastName.toCapitalized()}"),
            trailing: Text("${mission.detailOtherUser?.email}"),
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
