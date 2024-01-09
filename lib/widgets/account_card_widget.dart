import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountCard extends StatelessWidget {
  const AccountCard({super.key, required this.data});
  final MapEntry<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(data.key),
        subtitle: Text(data.value),
        trailing: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.delete),
        ),
      ),
    );
  }
}
