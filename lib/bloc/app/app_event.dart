part of 'app_bloc.dart';

abstract class AppEvent {
  const AppEvent();
}

class ThemeToggleEvent extends AppEvent {}

class NavbarIndexEvent extends AppEvent {
  final int navbarIndex;

  NavbarIndexEvent({required this.navbarIndex});
}
