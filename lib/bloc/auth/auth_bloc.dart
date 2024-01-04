import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ovtc_app/models/auth_model.dart';
import 'package:ovtc_app/services/auth_service.dart';
import 'package:ovtc_app/services/user_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthInitialState()) {
    on<InitializeSupabaseEvent>((event, emit) {
      // Pour éviter la connexion automatique via cache
      AuthService.initialize();
      AuthService.logout();
    });

    on<AuthLoginEvent>((event, emit) async {
      AuthService.login(email: event.email, password: event.password);

      try {
        AuthResponse response = await AuthService.login(
          email: event.email,
          password: event.password,
        );

        final AuthModel user =
            await UserService.getCurrentUser(id: response.user!.id);

        emit(state.copyWith(user: user));
      } catch (error) {
        emit(AuthState(
          user: null,
          errorMessage: error.toString(),
          isLoading: false,
        ));
      }
    });

    on<AuthRegisterEvent>((event, emit) {
      emit(state.copyWith(isLoading: true));

      AuthService.register(
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
      );

      // if (error) {
      //   emit(state.copyWith(errorMessage: event.error, isLoading: false));
      // } else {
      //   emit(state.copyWith(user:event.user,isLoading: false));
      // }
      emit(state.copyWith(isLoading: false));
    });

    on<AuthLogoutEvent>((event, emit) {
      AuthService.logout();
    });
  }
}
