import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ovtc_app/bloc/app/app_bloc.dart';
import 'package:ovtc_app/models/contact_model.dart';

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
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Center(
                      child: Text(
                    "This feature has not yet been created. It will have to change the account cards by replacing them with fields for modification.",
                    style: TextStyle(fontSize: 18),
                  )),
                  backgroundColor: Colors.red[900],
                ),
              )
            },
            leading: const Icon(Icons.star),
            title: const Text("FirstName"),
            trailing: const Text("LastName"),
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
