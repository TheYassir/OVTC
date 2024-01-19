part of 'mission_bloc.dart';

class MissionState extends Equatable {
  final List<MissionModel>? acceptedMissions;
  final List<MissionModel>? pendingMissions;
  final List<MissionModel>? refusedMissions;
  final List<ContactModel>? contacts;
  final String? roleId;
  final bool isLoading;
  final String? missionErrorMessage;

  const MissionState({
    required this.acceptedMissions,
    required this.pendingMissions,
    required this.refusedMissions,
    required this.contacts,
    required this.roleId,
    required this.isLoading,
    required this.missionErrorMessage,
  });

  MissionState copyWith({
    List<MissionModel>? acceptedMissions,
    List<MissionModel>? pendingMissions,
    List<MissionModel>? refusedMissions,
    List<ContactModel>? contacts,
    String? roleId,
    bool? isLoading,
    String? missionErrorMessage,
  }) {
    return MissionState(
      acceptedMissions: acceptedMissions ?? this.acceptedMissions,
      pendingMissions: pendingMissions ?? this.pendingMissions,
      refusedMissions: refusedMissions ?? this.refusedMissions,
      contacts: contacts ?? this.contacts,
      isLoading: isLoading ?? this.isLoading,
      roleId: roleId ?? this.roleId,
      missionErrorMessage: missionErrorMessage ?? this.missionErrorMessage,
    );
  }

  @override
  List<Object?> get props => [
        acceptedMissions,
        pendingMissions,
        refusedMissions,
        contacts,
        roleId,
        isLoading,
        missionErrorMessage
      ];

  @override
  String toString() {
    return 'MissionState{acceptedMissions: $acceptedMissions, pendingMissions: $pendingMissions, refusedMissions: $refusedMissions, isLoading: $isLoading, missionErrorMessage: $missionErrorMessage, contacts: $contacts, role_id: $roleId}';
  }
}

class MissionInitialState extends MissionState {
  const MissionInitialState()
      : super(
            acceptedMissions: null,
            pendingMissions: null,
            refusedMissions: null,
            contacts: null,
            roleId: null,
            isLoading: false,
            missionErrorMessage: null);
}
