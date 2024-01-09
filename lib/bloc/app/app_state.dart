part of 'app_bloc.dart';

class AppState extends Equatable {
  final bool isDarkMode;
  final int navbarIndex;

  const AppState({
    required this.isDarkMode,
    required this.navbarIndex,
  });

  AppState copyWith({
    UserModel? user,
    bool? isDarkMode,
    int? navbarIndex,
  }) {
    return AppState(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      navbarIndex: navbarIndex ?? this.navbarIndex,
    );
  }

  @override
  List<Object?> get props => [isDarkMode, navbarIndex];

  @override
  String toString() {
    return 'AppState{isDarkMode: $isDarkMode, navbarIndex: $navbarIndex}';
  }
}

class AppInitialState extends AppState {
  const AppInitialState()
      : super(
          isDarkMode: false,
          navbarIndex: 0,
        );
}
