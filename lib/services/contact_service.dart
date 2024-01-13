import 'package:ovtc_app/models/contact_model.dart';
import 'package:ovtc_app/services/channel_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

final supabase = Supabase.instance.client;

class ContactService {
  static Future<Map<String, List<ContactModel>>> getAllContacts(
      {required String userId}) async {
    try {
      final List<Map<String, dynamic>> response = await supabase
          .from('contacts')
          .select('''*,detailOtherUser:receiver_id(id, first_name, last_name, role_id, email)''').eq(
              'sender_id', userId);
      final List<Map<String, dynamic>> receiverResponse = await supabase
          .from('contacts')
          .select('''*,detailOtherUser:receiver_id(id, first_name, last_name, role_id, email)''').eq(
              'receiver_id', userId);

      // print("Error on response : ${response.toString()}");
      // print("Error on receiverResponse : ${receiverResponse.toString()}");
      response.addAll(receiverResponse);

      final List<ContactModel> allContacts =
          response.map((contact) => ContactModel.fromJson(contact)).toList();

      // print("Error on allContacts to list : ${allContacts.toString()}");

      final List<ContactModel> blockedContacts =
          (allContacts.where((element) => element.isBlocked == true)).toList();
      final List<ContactModel> pendingContacts =
          (allContacts.where((element) => element.isPending == true)).toList();
      final List<ContactModel> contacts = (allContacts.where((element) =>
          element.isAccepted == true && element.isBlocked == false)).toList();

      final value = {
        "contacts": contacts,
        "pendingContacts": pendingContacts,
        "blockedContacts": blockedContacts
      };
      // print("Error on value : ${value.toString()}");
      return value;
    } catch (e) {
      print("[ContactService] getAllContacts: ${e.toString()}");
      rethrow;
    }
  }

  static Future addContact(
      {required String senderId, required String receiverId}) async {
    try {
      ContactModel newContact = ContactModel(
        id: const Uuid().v4(),
        createdAt: null,
        isPending: true,
        isAccepted: false,
        isBlocked: false,
        senderId: senderId,
        receiverId: receiverId,
      );

      await supabase.from('contacts').insert(newContact.toJson());
    } catch (e) {
      print("[ContactService] addContact: ${e.toString()}");
      rethrow;
    }
  }

  static void responseContact({
    required String userId,
    required String otherUserId,
    required String contactId,
    required bool accepted,
    required bool blocked,
  }) async {
    try {
      if (accepted == false && blocked == false) {
        await supabase.from('contacts').delete().match({'id': contactId});
      } else if (blocked == true) {
        await supabase.from('contacts').update(
            {'is_blocked': true, 'is_pending': false}).match({'id': contactId});
      } else {
        await supabase
            .from('contacts')
            .update({'is_accepted': true, 'is_pending': false}).match(
                {'id': contactId});
        ChannelService.createChannelAfterContact(
            userId: userId, otherUserId: otherUserId);
      }
      // getAllContacts(userId: userId);
    } catch (e) {
      print("[ContactService] responseContact: ${e.toString()}");
      rethrow;
    }
  }
}
