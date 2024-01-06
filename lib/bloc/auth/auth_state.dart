part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final AuthModel? auth;
  final String? errorMessage;
  final bool isLoading;

  const AuthState({
    required this.auth,
    required this.errorMessage,
    required this.isLoading,
  });

  AuthState copyWith({
    AuthModel? auth,
    String? errorMessage,
    bool? isLoading,
  }) {
    return AuthState(
      auth: auth ?? this.auth,
      errorMessage: errorMessage ?? this.errorMessage,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [auth, errorMessage, isLoading];

  @override
  String toString() {
    return 'AuthState{auth: $auth, errorMessage: $errorMessage, isLoading: $isLoading}';
  }
}

class AuthInitialState extends AuthState {
  const AuthInitialState()
      : super(
          auth: null,
          errorMessage: null,
          isLoading: false,
        );
}
