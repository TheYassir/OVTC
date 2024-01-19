import 'package:ovtc_app/models/contact_model.dart';
import 'package:ovtc_app/models/mission_model.dart';
import 'package:ovtc_app/models/role_model.dart';
import 'package:ovtc_app/services/contact_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

final supabase = Supabase.instance.client;

class MissionService {
  static Future<Map<String, dynamic>> getAllMissions(
      {required String authId}) async {
    try {
      final Map<String, dynamic> responseRole = await supabase
          .from('users')
          .select('role_id')
          .eq('id', authId)
          .single();

      List<Map<String, dynamic>> responseAllMissions;

      if (responseRole["role_id"] == RoleModel().driverId) {
        responseAllMissions = await supabase
            .from('missions')
            .select('''*,detailOtherUser:customer_id(id, first_name, last_name, email, role_id)''').eq(
                'driver_id', authId);
      } else {
        responseAllMissions = await supabase
            .from('missions')
            .select('''*,detailOtherUser:driver_id(id, first_name, last_name, email, role_id)''').eq(
                'customer_id', authId);
      }

      // print("Error on response : ${responseAllMissions.toString()}");

      Map<String, List<ContactModel>> allContacts =
          await ContactService.getAllContacts(userId: authId);

      final valueIfNotMission = {
        "role_id": responseRole["role_id"],
        "acceptedMissions": null,
        "pendingMissions": null,
        "refusedMissions": null,
        "contacts": allContacts["contacts"],
      };
      print("Sent data : ${valueIfNotMission.toString()}");
      if (responseAllMissions.isEmpty) {
        return valueIfNotMission;
      }

      final List<MissionModel> allMissions = responseAllMissions
          .map((mission) => MissionModel.fromJson(mission))
          .toList();

      final List<MissionModel> acceptedMissions =
          (allMissions.where((element) => element.isAccepted == true)).toList();
      final List<MissionModel> pendingMissions =
          (allMissions.where((element) => element.isPending == true)).toList();
      final List<MissionModel> refusedMissions =
          (allMissions.where((element) => element.isRefused == true)).toList();

      final value = {
        "role_id": responseRole["role_id"],
        "acceptedMissions": acceptedMissions,
        "pendingMissions": pendingMissions,
        "refusedMissions": refusedMissions,
        "contacts": allContacts["contacts"],
      };

      return value;
    } catch (e) {
      print("[MissionService] getAllMissions: ${e.toString()}");
      rethrow;
    }
  }

  static Future createMission({
    required String customerId,
    required String driverId,
    required String senderId,
    required String receiverId,
    required String addressStart,
    required String addressEnd,
    required DateTime dateStart,
    required int price,
  }) async {
    try {
      MissionModel newMission = MissionModel(
        id: const Uuid().v4(),
        addressEnd: addressEnd,
        addressStart: addressStart,
        price: price,
        dateStart: dateStart,
        isPending: true,
        isAccepted: false,
        isRefused: false,
        customerId: customerId,
        driverId: driverId,
        senderId: senderId,
        receiverId: receiverId,
      );
      try {
        await supabase.from('missions').insert(newMission.toJson());
      } catch (e) {
        throw Exception("500: Internal server error");
      }

      print("[MissionService] Mission created");
    } catch (e) {
      print("[MissionService] createMission: ${e.toString()}");
      rethrow;
    }
  }

  static Future<void> responseMission({
    required String missionId,
    required bool isAccepted,
    required bool isRefused,
  }) async {
    try {
      try {
        if (isAccepted == true) {
          await supabase
              .from('missions')
              .update({'is_accepted': true, 'is_pending': false}).match(
                  {'id': missionId});
        }
        if (isRefused == true) {
          await supabase
              .from('missions')
              .update({'is_refused': true, 'is_pending': false}).match(
                  {'id': missionId});
        }
      } catch (e) {
        throw Exception("500: Internal server error ${e.toString()}");
      }
    } catch (e) {
      print("[ContactService] responseContact: ${e.toString()}");
      rethrow;
    }
  }
}
