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

    // // todo implement event handler
    // // Use Auth.id to send request get on supabase table users with it
    // on<AuthToUserEvent>((AuthToUserEvent event, Emitter<AppState> emit) async {
    //   emit(state.copyWith(isLoading: true));

    //   await UserService.login(
    //     id: event.id,
    //   )
    //       .then((value) => emit(state.copyWith(
    //             auth: value,
    //             isLoading: false,
    //           )))
    //       .onError<AuthException>((authError, _) => emit(state.copyWith(
    //             errorMessage:
    //                 "${authError.statusCode.toString()}: ${authError.message.toString()}",
    //             isLoading: false,
    //           )))
    //       .catchError((onError) => emit(state.copyWith(
    //             errorMessage: onError.toString(),
    //             isLoading: false,
    //           )));
    // });
  }
}
