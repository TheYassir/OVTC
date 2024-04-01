import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ovtc_app/bloc/auth/auth_bloc.dart';
import 'package:ovtc_app/routing/ovtc_router.dart';
import 'package:ovtc_app/utils/ovtc_theme.dart';
import 'package:ovtc_app/utils/snackbar_show_extension.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
  }

  void clearText(TextEditingController controller) {
    if (controller.text.isNotEmpty) controller.clear();
  }

  final _formkey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        // _emailController.text = "miaaaou78@gmail.com";
        // _passwordController.text = "rissay78";
        if (state.auth != null) {
          context.go(OVTCRouter.home, extra: state.auth!.id);
        }
        if (state.errorMessage != null) {
          context.showErrorSnackBar(message: state.errorMessage.toString());
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
                    const Icon(
                      Icons.local_taxi_rounded,
                      color: OVTCTheme.primaryColor,
                      size: 60,
                    ),
                    Text(
                      "O'VTC",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w500,
                        fontSize: 30,
                      ),
                    ),
                    const SizedBox(height: 32),
                    const Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                        controller: _emailController,
                        autocorrect: false,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
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
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'Email*',
                          suffixIcon: Focus(
                            descendantsAreFocusable: false,
                            canRequestFocus: false,
                            child: IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () => clearText(_emailController),
                            ),
                          ),
                        )),
                    const SizedBox(height: 10),
                    TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        autocorrect: false,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.visiblePassword,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'Password*',
                          suffixIcon: Focus(
                            descendantsAreFocusable: false,
                            canRequestFocus: false,
                            child: IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () => clearText(_passwordController),
                            ),
                          ),
                        )),
                    const SizedBox(height: 16),
                    TextButton(
                        onPressed: () {
                          context.go(OVTCRouter.register);
                        },
                        child: Text(
                          "Don't have an account yet ? Create one",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        )),
                    const SizedBox(height: 16),
                    authState.isLoading
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size.fromHeight(50),
                            ),
                            onPressed: () {
                              if (_formkey.currentState!.validate()) {
                                context.read<AuthBloc>().add(AuthLoginEvent(
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                    ));
                                _emailController.clear();
                                _passwordController.clear();
                              }
                            },
                            child: const Text('Login'),
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
