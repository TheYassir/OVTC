part of 'app_bloc.dart';

abstract class AppEvent {
  const AppEvent();
}

class ThemeToggleEvent extends AppEvent {}

class AuthToUserEvent extends AppEvent {
  final String id;

  const AuthToUserEvent({
    required this.id,
  });
}
