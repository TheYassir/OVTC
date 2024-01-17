import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ovtc_app/bloc/app/app_bloc.dart';
import 'package:ovtc_app/utils/snackbar_show_extension.dart';
import 'package:ovtc_app/utils/string_casing_extension.dart';

class AccountCard extends StatelessWidget {
  const AccountCard({super.key, required this.data});
  final MapEntry<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Card(
        child: BlocBuilder<AppBloc, AppState>(
          builder: (context, state) {
            return ListTile(
              title: Text(
                  "${data.key.replaceAll(RegExp(r'_'), ' ').toCapitalized()} :"),
              trailing: data.key == "id"
                  ? ElevatedButton.icon(
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: data.value))
                            .then((_) {
                          context.showValidSnackBar(
                              message: "Id copied to your clipboard !");
                        });
                      },
                      icon: Icon(
                        Icons.copy,
                        color: state.isDarkMode ? Colors.white : Colors.black,
                      ),
                      label: Text(
                        "Copy",
                        style: TextStyle(
                          color: state.isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    )
                  : Text(data.value.toString()),
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
      ),
    );
  }
}
