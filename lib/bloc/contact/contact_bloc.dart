import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ovtc_app/models/contact_model.dart';
import 'package:ovtc_app/services/contact_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
                contacts: value["contacts"],
                pendingContacts: value["pendingContacts"],
                blockedContacts: value["blockedContacts"],
                isLoading: false,
              )))
          .catchError((onError) => emit(state.copyWith(
                contactErrorMessage: onError.toString(),
                isLoading: false,
              )));
    });

    on<AddContactEvent>(
        (AddContactEvent event, Emitter<ContactState> emit) async {
      emit(state.copyWith(isLoading: true));

      await ContactService.addContact(
        senderId: event.senderId,
        receiverId: event.receiverId,
      )
          .then((value) => emit(state.copyWith(
                isLoading: false,
              )))
          .onError<PostgrestException>((error, _) => emit(state.copyWith(
                contactErrorMessage:
                    "Wrong request check the given identifier.",
                isLoading: false,
              )))
          .catchError((onError) => emit(state.copyWith(
                contactErrorMessage: onError.toString(),
                isLoading: false,
              )));
      ;
    });

    on<ResponseContactEvent>(
        (ResponseContactEvent event, Emitter<ContactState> emit) async {
      ContactService.responseContact(
        userId: event.userId,
        otherUserId: event.otherUserId,
        contactId: event.contactId,
        accepted: event.accepted,
        blocked: event.blocked,
      );

      // Envoi d'une requete de creation d'une conversation channels
    });
  }
}
