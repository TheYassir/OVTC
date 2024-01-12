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

class AddContactEvent extends ContactEvent {
  final String senderId;
  final String receiverId;

  const AddContactEvent({
    required this.senderId,
    required this.receiverId,
  });
}

class ResponseContactEvent extends ContactEvent {
  final String userId;
  final String otherUserId;
  final String contactId;
  final bool accepted;
  final bool blocked;

  const ResponseContactEvent({
    required this.userId,
    required this.otherUserId,
    required this.contactId,
    required this.accepted,
    required this.blocked,
  });
}
