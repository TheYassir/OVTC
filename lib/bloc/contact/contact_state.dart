part of 'contact_bloc.dart';

class ContactState extends Equatable {
  final List<ContactModel>? contacts;
  final List<ContactModel>? pendingContacts;
  final List<ContactModel>? blockedContacts;
  final bool isLoading;
  final String? contactErrorMessage;

  const ContactState({
    required this.contacts,
    required this.pendingContacts,
    required this.blockedContacts,
    required this.isLoading,
    required this.contactErrorMessage,
  });

  ContactState copyWith({
    List<ContactModel>? contacts,
    List<ContactModel>? pendingContacts,
    List<ContactModel>? blockedContacts,
    bool? isLoading,
    String? contactErrorMessage,
  }) {
    return ContactState(
      contacts: contacts ?? this.contacts,
      pendingContacts: pendingContacts ?? this.pendingContacts,
      blockedContacts: blockedContacts ?? this.blockedContacts,
      isLoading: isLoading ?? this.isLoading,
      contactErrorMessage: contactErrorMessage ?? this.contactErrorMessage,
    );
  }

  @override
  List<Object?> get props => [
        contacts,
        pendingContacts,
        blockedContacts,
        isLoading,
        contactErrorMessage
      ];

  @override
  String toString() {
    return 'ContactState{contact: $contacts, pendingContacts: $pendingContacts, blockedContacts: $blockedContacts, isLoading: $isLoading, contactErrorMessage: $contactErrorMessage}';
  }
}

class ContactInitialState extends ContactState {
  const ContactInitialState()
      : super(
            contacts: null,
            pendingContacts: null,
            blockedContacts: null,
            isLoading: true,
            contactErrorMessage: null);
}
