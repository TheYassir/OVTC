import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ovtc_app/bloc/auth/auth_bloc.dart';
import 'package:ovtc_app/bloc/contact/contact_bloc.dart';
import 'package:ovtc_app/components/OVTC_appbar.dart';
import 'package:ovtc_app/components/ovtc_bottombar.dart';
import 'package:ovtc_app/utils/snackbar_show_extension.dart';

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
        if (state.contactErrorMessage != null) {
          context.showErrorSnackBar(
              message: state.contactErrorMessage.toString());
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
                      "Add Contact",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w500,
                        fontSize: 30,
                      ),
                    ),
                    const SizedBox(height: 32),
                    TextFormField(
                        controller: _identifierController,
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
                                    context.showValidSnackBar(
                                        message: "Contact Request sent");
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
