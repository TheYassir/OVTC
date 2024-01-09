import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ovtc_app/models/user_model.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(const AppInitialState()) {
    on<ThemeToggleEvent>((ThemeToggleEvent event, Emitter<AppState> emit) {
      bool isDarkModeChecked = !state.isDarkMode;

      emit(state.copyWith(
        isDarkMode: isDarkModeChecked,
      ));
    });

    on<NavbarIndexEvent>((NavbarIndexEvent event, Emitter<AppState> emit) {
      emit(state.copyWith(navbarIndex: event.navbarIndex));
    });
  }
}
