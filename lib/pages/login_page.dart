import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ovtc_app/routing/ovtc_router.dart';
import '../bloc/auth/auth_bloc.dart';

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
        // if (state.user != null) {
        //   context.go(OVTCRouter.home);
        // }
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
                    const SizedBox(height: 16),
                    TextButton(
                        onPressed: () {
                          context.push('/register');
                        },
                        child: Text(
                          "Don't have an account yet ? Create one",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        )),
                    const SizedBox(height: 16),
                    if (authState.isLoading) const CircularProgressIndicator(),
                    if (!authState.isLoading)
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50),
                        ),
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            context.read<AuthBloc>().add(AuthLoginEvent(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                ));
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
