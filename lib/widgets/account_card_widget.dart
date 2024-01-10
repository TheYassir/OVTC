import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ovtc_app/bloc/app/app_bloc.dart';

class AccountCard extends StatelessWidget {
  const AccountCard({super.key, required this.data});
  final MapEntry<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          return ListTile(
            title: Text("${data.key.replaceAll(RegExp(r'_'), ' ')} :"),
            trailing: Text(data.value.toString()),
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
