part of 'account_bloc.dart';

abstract class AccountEvent {
  const AccountEvent();
}

class AuthToUserEvent extends AccountEvent {
  final String id;

  const AuthToUserEvent({
    required this.id,
  });
}
