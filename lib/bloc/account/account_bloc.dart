import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ovtc_app/models/driver_model.dart';
import 'package:ovtc_app/models/user_model.dart';
import 'package:ovtc_app/services/user_service.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc() : super(const AccountInitialState()) {
    on<AuthToUserEvent>(
        (AuthToUserEvent event, Emitter<AccountState> emit) async {
      emit(state.copyWith(isLoading: true));

      await UserService.getCurrentUser(
        id: event.id,
      )
          .then((value) => emit(state.copyWith(
                user: value.first as UserModel,
                driver: value.elementAtOrNull(1) as DriverModel,
                isLoading: false,
              )))
          .catchError((onError) => emit(state.copyWith(
                accountErrorMessage: onError.toString(),
                isLoading: false,
              )));
    });
  }
}
