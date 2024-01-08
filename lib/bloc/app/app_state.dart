part of 'app_bloc.dart';

class AppState extends Equatable {
  final UserModel? user;
  final bool isDarkMode;

  const AppState({
    required this.user,
    required this.isDarkMode,
  });

  AppState copyWith({
    UserModel? user,
    bool? isDarkMode,
  }) {
    return AppState(
      user: user ?? this.user,
      isDarkMode: isDarkMode ?? this.isDarkMode,
    );
  }

  @override
  List<Object?> get props => [user, isDarkMode];

  @override
  String toString() {
    return 'AppState{user: $user, isDarkMode: $isDarkMode}';
  }
}

class AppInitialState extends AppState {
  const AppInitialState()
      : super(
          user: null,
          isDarkMode: false,
        );
}
