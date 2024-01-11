import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ovtc_app/models/contact_model.dart';
import 'package:ovtc_app/services/contact_service.dart';

part 'contact_event.dart';
part 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  ContactBloc() : super(const ContactInitialState()) {
    on<LoadAllContactsEvent>(
        (LoadAllContactsEvent event, Emitter<ContactState> emit) async {
      emit(state.copyWith(isLoading: true));

      await ContactService.getAllContacts(
        userId: event.userId,
      )
          .then((value) => emit(state.copyWith(
                contacts: value.first,
                pendingContacts: value.elementAtOrNull(1),
                blockedContacts: value.elementAtOrNull(2),
                isLoading: false,
              )))
          .catchError((onError) => emit(state.copyWith(
                contactErrorMessage: onError.toString(),
                isLoading: false,
              )));
    });
  }
}
