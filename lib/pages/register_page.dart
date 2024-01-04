import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ovtc_app/routing/ovtc_router.dart';
import '../bloc/auth/auth_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  void initState() {
    super.initState();
  }

  final validCharacters = RegExp(r'^[a-zA-Z0-9_\-=@,\.;]+$');
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _zipcodeController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  late String _roleId = "";
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _sirenController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.user != null) {
          context.go('/');
        }
        if (state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Erreur d'authentification : ${state.errorMessage}"),
          ));
        }
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, authState) {
              return Form(
                key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.local_taxi_rounded,
                          color: Theme.of(context).colorScheme.primary,
                          size: 60,
                        ),
                        Text(
                          "O'VTC",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      "Register",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 10),
                    DropdownButtonFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your role';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Who are you ?*',
                        ),
                        items: const [
                          DropdownMenuItem(
                              value: "9cf60c0b-7920-40f1-a693-4f6c0a0c581a",
                              child: Text("Driver")),
                          DropdownMenuItem(
                              value: "cb545524-18bb-4e53-8527-456e904d00c1",
                              child: Text("Customer")),
                        ],
                        onChanged: (val) {
                          setState(() {
                            _roleId = val!;
                          });
                        }),
                    const SizedBox(height: 10),
                    TextFormField(
                        controller: _emailController,
                        autofocus: true,
                        autocorrect: false,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!value.contains(RegExp(
                              r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$'))) {
                            return 'Please enter an email';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email*',
                        )),
                    const SizedBox(height: 10),
                    TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        autocorrect: false,
                        keyboardType: TextInputType.visiblePassword,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter strong password';
                          }
                          if (value.length < 8) {
                            return 'Please enter more than 8 characters';
                          }
                          if (!value.contains(RegExp(r'(\d+)'))) {
                            return 'Please enter numbers characters';
                          }
                          // if (!value.contains(RegExp(
                          //     r'^`!@#$%^&*()_+\-=\[\]{};:"\\|,.<>\/?~$'))) {
                          //   return 'Please enter specials characters';
                          // }
                          return null;
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password*',
                        )),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: TextFormField(
                              controller: _lastNameController,
                              autocorrect: false,
                              keyboardType: TextInputType.name,
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    value.length < 3 ||
                                    !validCharacters.hasMatch(value)) {
                                  return 'Please enter your last name';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Last Name*',
                              )),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          flex: 1,
                          child: TextFormField(
                              controller: _firstNameController,
                              autocorrect: false,
                              keyboardType: TextInputType.name,
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    value.length < 3 ||
                                    !validCharacters.hasMatch(value)) {
                                  return 'Please enter your first name';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'First Name*',
                              )),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                        controller: _addressController,
                        autocorrect: true,
                        keyboardType: TextInputType.streetAddress,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.length < 5 ||
                              !validCharacters.hasMatch(value)) {
                            return 'Please enter your address';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Address*',
                        )),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: TextFormField(
                              controller: _cityController,
                              autocorrect: false,
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    value.length < 3 ||
                                    !validCharacters.hasMatch(value)) {
                                  return 'Please enter your city';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'City*',
                              )),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          flex: 1,
                          child: TextFormField(
                              controller: _zipcodeController,
                              keyboardType: TextInputType.number,
                              autocorrect: false,
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    !validCharacters.hasMatch(value)) {
                                  return 'Please enter your zipcode';
                                }
                                if (!value.contains(RegExp(r'(^\d{5}$)'))) {
                                  return 'Please enter 5 numbers';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Zipcode*',
                              )),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    LayoutBuilder(builder: (context, constraints) {
                      if (_roleId == "9cf60c0b-7920-40f1-a693-4f6c0a0c581a") {
                        return Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: TextFormField(
                                  controller: _companyNameController,
                                  autocorrect: false,
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        value.length < 3 ||
                                        !validCharacters.hasMatch(value)) {
                                      return 'Please enter your company name';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Company name*',
                                  )),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              flex: 1,
                              child: TextFormField(
                                  controller: _sirenController,
                                  keyboardType: TextInputType.number,
                                  autocorrect: false,
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        !validCharacters.hasMatch(value)) {
                                      return 'Please enter your siren';
                                    }
                                    if (!value.contains(RegExp(r'(^\d{9}$)'))) {
                                      return 'Please enter 9 numbers';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Siren*',
                                  )),
                            ),
                          ],
                        );
                      } else {
                        return const SizedBox(height: 10);
                      }
                    }),
                    TextButton(
                        onPressed: () {
                          context.push('/login');
                        },
                        child: Text(
                          "Have an account ? Log in",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        )),
                    const SizedBox(height: 10),
                    if (authState.isLoading) const CircularProgressIndicator(),
                    if (!authState.isLoading)
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50),
                        ),
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            context.read<AuthBloc>().add(AuthRegisterEvent(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                  lastName: _lastNameController.text,
                                  firstName: _firstNameController.text,
                                  address: _addressController.text,
                                  zipcode: int.parse(_zipcodeController.text),
                                  city: _cityController.text,
                                  roleId: _roleId,
                                  companyName: _companyNameController.text,
                                  siren: _sirenController.text,
                                ));
                          }
                        },
                        child: const Text('Register'),
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
