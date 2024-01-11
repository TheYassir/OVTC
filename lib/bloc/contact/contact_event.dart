part of 'contact_bloc.dart';

abstract class ContactEvent {
  const ContactEvent();
}

class LoadAllContactsEvent extends ContactEvent {
  final String userId;

  const LoadAllContactsEvent({
    required this.userId,
  });
}
