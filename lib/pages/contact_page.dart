import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ovtc_app/bloc/contact/contact_bloc.dart';
import 'package:ovtc_app/components/OVTC_appbar.dart';
import 'package:ovtc_app/components/ovtc_bottombar.dart';
import 'package:ovtc_app/routing/ovtc_router.dart';
import 'package:ovtc_app/utils/ovtc_theme.dart';
import 'package:ovtc_app/widgets/contact_card_widget.dart';
import 'package:ovtc_app/widgets/contact_title_widget.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key, required this.authId});

  final String authId;

  @override
  Widget build(BuildContext context) {
    // return BlocConsumer<ContactBloc, ContactState>(
    //   listener: (context, state) {
    //     if (state.contactErrorMessage != null) {
    //       ScaffoldMessenger.of(context).showSnackBar(
    //         SnackBar(
    //           content: Center(
    //               child: Text(
    //             state.contactErrorMessage.toString(),
    //             style: const TextStyle(fontSize: 18),
    //           )),
    //           backgroundColor: Colors.red[900],
    //         ),
    //       );
    //     }
    //   },
    //   builder: (context, state) {
    //     ContactBloc().add(LoadAllContactsEvent(userId: authId));
    //     print("Print STate = ${state.toString()}");
    //     return
    return BlocProvider(
        lazy: false,
        create: (context) =>
            ContactBloc()..add(LoadAllContactsEvent(userId: authId)),
        child: BlocConsumer<ContactBloc, ContactState>(
          listener: (context, state) {
            if (state.contactErrorMessage != null) {
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
          builder: (context, state) {
            print("Print STate = ${state.toString()}");
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
                body: state.isLoading
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
                                  ContactTitle(title: "Contact list"),
                                ],
                              ),
                            ),
                            state.contacts!.isEmpty
                                ? const Expanded(
                                    flex: 1,
                                    child: Text(
                                      "Empty contact list ! Add new contacts using the button at the bottom of the page.",
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.black,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  )
                                : Expanded(
                                    flex: 3,
                                    child: ListView.builder(
                                        itemCount: state.contacts!.length,
                                        itemBuilder: (context, index) {
                                          return ContactCard(
                                              data: state.contacts![index]);
                                        }),
                                  ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ContactTitle(
                                      title: "Contact request pending"),
                                ],
                              ),
                            ),
                            state.pendingContacts!.isEmpty
                                ? const Expanded(
                                    flex: 1,
                                    child: Text(
                                      "Empty pending contact list !",
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.black,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  )
                                : Expanded(
                                    flex: 3,
                                    child: ListView.builder(
                                        itemCount:
                                            state.pendingContacts!.length,
                                        itemBuilder: (context, index) {
                                          return ContactCard(
                                              data: state
                                                  .pendingContacts![index]);
                                        }),
                                  ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ContactTitle(title: "Blocked contacts list"),
                                ],
                              ),
                            ),
                            state.blockedContacts!.isEmpty
                                ? const Expanded(
                                    flex: 1,
                                    child: Text(
                                      "Empty blocked contact list !",
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.black,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  )
                                : Expanded(
                                    flex: 3,
                                    child: ListView.builder(
                                        itemCount:
                                            state.blockedContacts!.length,
                                        itemBuilder: (context, index) {
                                          return ContactCard(
                                              data: state
                                                  .blockedContacts![index]);
                                        }),
                                  ),
                          ],
                        ),
                      ));
          },
        ));
  }
}
