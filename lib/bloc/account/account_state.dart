part of 'account_bloc.dart';

class AccountState extends Equatable {
  final UserModel? user;
  final DriverModel? driver;
  final bool isLoading;
  final String? accountErrorMessage;

  const AccountState({
    required this.user,
    required this.driver,
    required this.isLoading,
    required this.accountErrorMessage,
  });

  AccountState copyWith({
    UserModel? user,
    DriverModel? driver,
    bool? isLoading,
    String? accountErrorMessage,
  }) {
    return AccountState(
      user: user ?? this.user,
      driver: driver ?? this.driver,
      isLoading: isLoading ?? this.isLoading,
      accountErrorMessage: accountErrorMessage ?? this.accountErrorMessage,
    );
  }

  @override
  List<Object?> get props => [user, driver, isLoading, accountErrorMessage];

  @override
  String toString() {
    return 'AccountState{user: $user, driver: $driver, isLoading: $isLoading, driver: $accountErrorMessage}';
  }
}

class AccountInitialState extends AccountState {
  const AccountInitialState()
      : super(
            user: null,
            driver: null,
            isLoading: true,
            accountErrorMessage: null);
}
