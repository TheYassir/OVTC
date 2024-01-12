import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ovtc_app/bloc/auth/auth_bloc.dart';
import 'package:ovtc_app/bloc/contact/contact_bloc.dart';
import 'package:ovtc_app/components/OVTC_appbar.dart';
import 'package:ovtc_app/components/ovtc_bottombar.dart';
import 'package:ovtc_app/routing/ovtc_router.dart';
import 'package:ovtc_app/utils/ovtc_theme.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Center(
                  child: Text(
                state.errorMessage.toString(),
                style: const TextStyle(fontSize: 18),
              )),
              backgroundColor: Colors.red[900],
            ),
          );
        }
      },
      builder: (context, state) {
        ContactBloc().add(LoadAllContactsEvent(userId: state.auth!.id));

        return Scaffold(
          appBar: const OVTCAppBar(),
          bottomNavigationBar: const OVTCBottomBar(),
          floatingActionButton: FloatingActionButton(
            backgroundColor: OVTCTheme.primaryColor,
            onPressed: () => context.push(OVTCRouter.addContact),
            child: const Icon(
              Icons.group_add,
              color: OVTCTheme.secondaryColor,
              size: 32,
            ),
          ),
          body: BlocBuilder<ContactBloc, ContactState>(
            builder: (context, state) {
              return state.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Contact list',
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          state.contacts == null
                              ? const Text(
                                  "Empty contact list ! Add new contacts using the button at the bottom of the page.",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.center,
                                )
                              : Expanded(
                                  child: ListView.builder(
                                      itemCount: state.contacts!.length,
                                      itemBuilder: (context, index) {
                                        return const ListTile(
                                          title: Text("NAME of contact"),
                                        );
                                      }),
                                ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Contact request pending',
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          state.pendingContacts == null
                              ? const Text(
                                  "Empty pending contact list !",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.center,
                                )
                              : Expanded(
                                  child: ListView.builder(
                                      itemCount: state.contacts!.length,
                                      itemBuilder: (context, index) {
                                        return const ListTile(
                                          title: Text("NAME of contact"),
                                        );
                                      }),
                                ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Blocked contacts list',
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          state.blockedContacts == null
                              ? const Text(
                                  "Empty blocked contact list !",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.center,
                                )
                              : Expanded(
                                  child: ListView.builder(
                                      itemCount: state.contacts!.length,
                                      itemBuilder: (context, index) {
                                        return const ListTile(
                                          title: Text("NAME of contact"),
                                        );
                                      }),
                                ),
                        ],
                      ),
                    );
            },
          ),
        );
      },
    );
  }
}
