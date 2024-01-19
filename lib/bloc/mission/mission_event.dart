part of 'mission_bloc.dart';

abstract class MissionEvent {
  const MissionEvent();
}

class LoadAllMissionsEvent extends MissionEvent {
  final String authId;

  const LoadAllMissionsEvent({
    required this.authId,
  });
}

class CreateMissionEvent extends MissionEvent {
  final String customerId;
  final String driverId;
  final String senderId;
  final String receiverId;
  final String addressStart;
  final String addressEnd;
  final DateTime dateStart;
  final int price;

  const CreateMissionEvent({
    required this.addressStart,
    required this.addressEnd,
    required this.dateStart,
    required this.price,
    required this.customerId,
    required this.driverId,
    required this.senderId,
    required this.receiverId,
  });
}

class ResponseMissionEvent extends MissionEvent {
  final String missionId;
  final bool isAccepted;
  final bool isRefused;

  const ResponseMissionEvent({
    required this.missionId,
    required this.isAccepted,
    required this.isRefused,
  });
}
