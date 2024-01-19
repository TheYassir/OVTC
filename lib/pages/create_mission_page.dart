import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ovtc_app/bloc/auth/auth_bloc.dart';
import 'package:ovtc_app/bloc/mission/mission_bloc.dart';
import 'package:ovtc_app/components/OVTC_appbar.dart';
import 'package:ovtc_app/components/ovtc_bottombar.dart';
import 'package:ovtc_app/routing/ovtc_router.dart';
import 'package:ovtc_app/utils/snackbar_show_extension.dart';

class CreateMissionPage extends StatefulWidget {
  final String authId;
  const CreateMissionPage({super.key, required this.authId});

  @override
  State<CreateMissionPage> createState() => _CreateMissionPageState();
}

class _CreateMissionPageState extends State<CreateMissionPage> {
  @override
  void initState() {
    super.initState();
  }

  void clearText(TextEditingController controller) {
    if (controller.text.isNotEmpty) controller.clear();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _dateStart,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)));
    if (picked != null && picked != _dateStart) {
      setState(() {
        _dateStart = picked;
      });
    }
  }

  final _formkey = GlobalKey<FormState>();
  final validCharacters = RegExp(r'^[a-zA-Z0-9_\-=@,\.;]+$');
  final onlyDigitCharacters = RegExp(r'^[0-9]+$');

  late String _otherUserId;
  DateTime _dateStart = DateTime.now();

  final TextEditingController _addressStartController = TextEditingController();
  final TextEditingController _addressEndController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MissionBloc, MissionState>(
      listener: (context, state) {
        if (state.missionErrorMessage != null) {
          context.showErrorSnackBar(
              message: state.missionErrorMessage.toString());
        }
      },
      child: Scaffold(
        appBar: const OVTCAppBar(),
        bottomNavigationBar: const OVTCBottomBar(),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocBuilder<MissionBloc, MissionState>(
            builder: (context, state) {
              return state.contacts?.firstOrNull == null
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                              "You don't have a contact to send mission to."),
                          ElevatedButton(
                            onPressed: () => context.go(OVTCRouter.contact,
                                extra: widget.authId),
                            child: const Text("Go to the contact page !"),
                          ),
                        ],
                      ),
                    )
                  : Form(
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
                            "Create Mission",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w500,
                              fontSize: 30,
                            ),
                          ),
                          const SizedBox(height: 32),
                          DropdownButtonFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please choose your driver or customer';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText:
                                    'Choose your driver or your customer*',
                              ),
                              items: state.contacts!.map((contact) {
                                return DropdownMenuItem(
                                  value: contact.detailOtherUser!.id,
                                  child: Text(
                                      "${contact.detailOtherUser!.lastName} ${contact.detailOtherUser!.firstName}"),
                                );
                              }).toList(),
                              onChanged: (val) {
                                setState(() {
                                  _otherUserId = val!;
                                });
                              }),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                onPressed: () => _selectDate(context),
                                child: const Text('Select date'),
                              ),
                              Text("${_dateStart.toLocal()}".split(' ')[0]),
                            ],
                          ),
                          TextFormField(
                              controller: _addressStartController,
                              autocorrect: false,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              keyboardType: TextInputType.streetAddress,
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    value.length < 5 ||
                                    !validCharacters.hasMatch(value)) {
                                  return 'Please enter start address';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                labelText: 'Start address*',
                                suffixIcon: Focus(
                                  descendantsAreFocusable: false,
                                  canRequestFocus: false,
                                  child: IconButton(
                                    icon: const Icon(Icons.clear),
                                    onPressed: () =>
                                        clearText(_addressStartController),
                                  ),
                                ),
                              )),
                          TextFormField(
                              controller: _addressEndController,
                              autocorrect: false,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              keyboardType: TextInputType.streetAddress,
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    value.length < 5 ||
                                    !validCharacters.hasMatch(value)) {
                                  return 'Please enter end address';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                labelText: 'End address*',
                                suffixIcon: Focus(
                                  descendantsAreFocusable: false,
                                  canRequestFocus: false,
                                  child: IconButton(
                                    icon: const Icon(Icons.clear),
                                    onPressed: () =>
                                        clearText(_addressEndController),
                                  ),
                                ),
                              )),
                          TextFormField(
                              controller: _priceController,
                              autocorrect: false,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    !onlyDigitCharacters.hasMatch(value)) {
                                  return 'Please enter only digit';
                                }

                                return null;
                              },
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                labelText: 'Price (in euro €)*',
                                suffixIcon: Focus(
                                  descendantsAreFocusable: false,
                                  canRequestFocus: false,
                                  child: IconButton(
                                    icon: const Icon(Icons.clear),
                                    onPressed: () =>
                                        clearText(_addressEndController),
                                  ),
                                ),
                              )),
                          const SizedBox(height: 10),
                          state.isLoading
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
                                              .read<MissionBloc>()
                                              .add(CreateMissionEvent(
                                                addressStart:
                                                    _addressStartController
                                                        .text,
                                                addressEnd:
                                                    _addressEndController.text,
                                                dateStart: _dateStart,
                                                price: _priceController.text,
                                                customerId: authState.auth!.id,
                                                driverId: _otherUserId,
                                              ));
                                          // _addressStartController.clear();
                                          // _addressEndController.clear();
                                          // _priceController.clear();
                                          // _dateStart.
                                          context.showValidSnackBar(
                                              message: "Mission Request sent");
                                          context.go(OVTCRouter.home);
                                        }
                                      },
                                      child: const Text('Send'),
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
