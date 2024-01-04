part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final AuthModel? user;
  final String? errorMessage;
  final bool isLoading;

  const AuthState({
    required this.user,
    required this.errorMessage,
    required this.isLoading,
  });

  AuthState copyWith({
    AuthModel? user,
    String? errorMessage,
    bool? isLoading,
  }) {
    return AuthState(
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [user];
}

class AuthInitialState extends AuthState {
  const AuthInitialState()
      : super(
          user: null,
          errorMessage: null,
          isLoading: false,
        );
}
