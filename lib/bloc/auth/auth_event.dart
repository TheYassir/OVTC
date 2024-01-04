part of 'auth_bloc.dart';

abstract class AuthEvent {
  const AuthEvent();
}

class InitializeSupabaseEvent extends AuthEvent {}

class AuthLoginEvent extends AuthEvent {
  final String email;
  final String password;

  const AuthLoginEvent({
    required this.email,
    required this.password,
  });
}

class AuthRegisterEvent extends AuthEvent {
  final String email;
  final String password;
  final String lastName;
  final String firstName;
  final String address;
  final int zipcode;
  final String city;
  final String roleId;
  final String? companyName;
  final String? siren;

  const AuthRegisterEvent({
    required this.email,
    required this.password,
    required this.lastName,
    required this.firstName,
    required this.address,
    required this.zipcode,
    required this.city,
    required this.roleId,
    this.companyName,
    this.siren,
  });
}

class AuthLogoutEvent extends AuthEvent {}
