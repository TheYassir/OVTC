import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ovtc_app/bloc/auth/auth_bloc.dart';
import 'package:ovtc_app/bloc/contact/contact_bloc.dart';
import 'package:ovtc_app/components/OVTC_appbar.dart';
import 'package:ovtc_app/components/ovtc_bottombar.dart';

class AddContactPage extends StatefulWidget {
  const AddContactPage({super.key});

  @override
  State<AddContactPage> createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
  @override
  void initState() {
    super.initState();
  }

  void clearText(TextEditingController controller) {
    if (controller.text.isNotEmpty) controller.clear();
  }

  final _formkey = GlobalKey<FormState>();
  final TextEditingController _identifierController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ContactBloc, ContactState>(
      listener: (context, state) {
        _identifierController.text = "miaaaou78@gmail.com";

        if (state.contactErrorMessage != null) {
          // Display bug snackbar
          // ScaffoldMessenger.of(context).clearSnackBars();
          // ScaffoldMessenger.of(context).removeCurrentSnackBar();

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Center(
                  child: Text(
                state.contactErrorMessage.toString(),
                style: const TextStyle(fontSize: 18),
              )),
              backgroundColor: Colors.red[900],
            ),
          );
        }
      },
      child: Scaffold(
        appBar: const OVTCAppBar(),
        bottomNavigationBar: const OVTCBottomBar(),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocBuilder<ContactBloc, ContactState>(
            builder: (context, contactState) {
              return Form(
                key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.local_taxi_rounded,
                      color: Theme.of(context).colorScheme.primary,
                      size: 60,
                    ),
                    Text(
                      "Add contact",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w500,
                        fontSize: 30,
                      ),
                    ),
                    const SizedBox(height: 32),
                    TextFormField(
                        controller: _identifierController,
                        autofocus: true,
                        autocorrect: false,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter identifier of your contact';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'Identifier*',
                          suffixIcon: Focus(
                            descendantsAreFocusable: false,
                            canRequestFocus: false,
                            child: IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () => clearText(_identifierController),
                            ),
                          ),
                        )),
                    const SizedBox(height: 10),
                    contactState.isLoading
                        ? const CircularProgressIndicator()
                        : BlocBuilder<AuthBloc, AuthState>(
                            builder: (context, authState) {
                              return ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size.fromHeight(50),
                                ),
                                onPressed: () {
                                  if (_formkey.currentState!.validate()) {
                                    context
                                        .read<ContactBloc>()
                                        .add(AddContactEvent(
                                          senderId: authState.auth!.id,
                                          receiverId:
                                              _identifierController.text,
                                        ));
                                    _identifierController.clear();
                                  }
                                },
                                child: const Text('Add'),
                              );
                            },
                          ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
