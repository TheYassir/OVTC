import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ovtc_app/models/auth_model.dart';
import 'package:ovtc_app/services/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthInitialState()) {
    on<InitializeSupabaseEvent>(
        (InitializeSupabaseEvent event, Emitter<AuthState> emit) async {
      emit(state.copyWith(isLoading: true));
      await AuthService.initialize()
          .then((value) => emit(state.copyWith(
                isLoading: false,
              )))
          .catchError((onError) => emit(state.copyWith(
                errorMessage: onError.toString(),
                isLoading: false,
              )));
      ;
    });

    on<AuthLoginEvent>((AuthLoginEvent event, Emitter<AuthState> emit) async {
      emit(state.copyWith(isLoading: true));

      await AuthService.login(
        email: event.email,
        password: event.password,
      )
          .then((value) => emit(state.copyWith(
                auth: value,
                isLoading: false,
              )))
          .onError<AuthException>((authError, _) => emit(state.copyWith(
                errorMessage:
                    "${authError.statusCode.toString()}: ${authError.message.toString()}",
                isLoading: false,
              )))
          .catchError((onError) => emit(state.copyWith(
                errorMessage: onError.toString(),
                isLoading: false,
              )));
    });

    on<AuthRegisterEvent>(
        (AuthRegisterEvent event, Emitter<AuthState> emit) async {
      emit(state.copyWith(isLoading: true));

      await AuthService.register(
        email: event.email,
        password: event.password,
        lastName: event.lastName,
        firstName: event.firstName,
        address: event.address,
        zipcode: event.zipcode,
        city: event.city,
        roleId: event.roleId,
        companyName: event.companyName!,
        siren: event.siren!,
      )
          .then((value) => emit(state.copyWith(
                auth: value,
                isLoading: false,
              )))
          .onError<AuthException>((authError, _) => emit(state.copyWith(
                errorMessage:
                    "${authError.statusCode.toString()}: ${authError.message.toString()}",
                isLoading: false,
              )))
          .catchError((onError) => emit(state.copyWith(
                errorMessage: onError.toString(),
                isLoading: false,
              )));
    });

    on<AuthLogoutEvent>((AuthLogoutEvent event, Emitter<AuthState> emit) async {
      emit(state.copyWith(isLoading: true));
      await AuthService.logout()
          .then((value) => emit(state.copyWith(
                auth: null,
                isLoading: false,
              )))
          .catchError((onError) => emit(state.copyWith(
                errorMessage: onError.toString(),
                isLoading: false,
              )));
      ;
    });

    on<AuthDeleteErrorMessageEvent>(
        (AuthDeleteErrorMessageEvent event, Emitter<AuthState> emit) =>
            emit(state.copyWith(errorMessage: null)));
  }
}
