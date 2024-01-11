import 'package:ovtc_app/models/contact_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class ContactService {
  static Future<List<List<ContactModel>?>> getAllContacts(
      {required userId}) async {
    try {
      final List<Map<String, dynamic>> response =
          await supabase.from('contacts').select().eq('sender_id', userId);

      final List<Map<String, dynamic>> receiverResponse =
          await supabase.from('contacts').select().eq('receiver_id', userId);

      // if (response.isEmpty) {
      //   throw Exception("500: Internal server error");
      // }
      print("[ContactService] response: ${response.toString()}");
      print(
          "[ContactService] receiverResponse: ${receiverResponse.toString()}");

      response.addAll(receiverResponse);

      final List<ContactModel> allContacts =
          response.map((contact) => ContactModel.fromJson(contact)).toList();

      final List<ContactModel> blockedContacts =
          (allContacts.where((element) => element.isBlocked == true)).toList();
      final List<ContactModel> pendingContacts =
          (allContacts.where((element) => element.isPending == true)).toList();
      final List<ContactModel> contacts = (allContacts.where((element) =>
          element.isAccepted == true && element.isBlocked == false)).toList();

      final value = [contacts, pendingContacts, blockedContacts];
      print("[ContactService] value: ${value.toString()}");
      return value;
    } catch (e) {
      print("[ContactService] getAllContacts: ${e.toString()}");
      rethrow;
    }
  }
}
