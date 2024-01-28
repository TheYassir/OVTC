import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ovtc_app/bloc/app/app_bloc.dart';
import 'package:ovtc_app/models/contact_model.dart';
import 'package:ovtc_app/models/role_model.dart';
import 'package:ovtc_app/utils/snackbar_show_extension.dart';
import 'package:ovtc_app/utils/string_casing_extension.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({super.key, required this.data});
  final ContactModel data;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          return ListTile(
            onTap: () => {
              context.showSnackBar(
                  message:
                      "This feature has not yet been created. It will have to show informations Contact's and block, deblock functionality.")
            },
            leading: data.detailOtherUser!.roleId == RoleModel().driverId
                ? const Icon(
                    Icons.local_taxi_rounded,
                  )
                : const Icon(
                    Icons.person,
                  ),
            title: Text(
                "${data.detailOtherUser!.firstName.toCapitalized()} ${data.detailOtherUser!.lastName.toCapitalized()}"),
            trailing: Text("${data.detailOtherUser?.email}"),
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
