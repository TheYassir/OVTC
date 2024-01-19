import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ovtc_app/models/contact_model.dart';
import 'package:ovtc_app/models/mission_model.dart';
import 'package:ovtc_app/services/mission_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'mission_event.dart';
part 'mission_state.dart';

class MissionBloc extends Bloc<MissionEvent, MissionState> {
  MissionBloc() : super(const MissionInitialState()) {
    on<LoadAllMissionsEvent>(
        (LoadAllMissionsEvent event, Emitter<MissionState> emit) async {
      emit(state.copyWith(isLoading: true));

      await MissionService.getAllMissions(
        authId: event.authId,
      )
          .then((value) => emit(state.copyWith(
                acceptedMissions:
                    value["acceptedMissions"] as List<MissionModel>?,
                pendingMissions:
                    value["pendingMissions"] as List<MissionModel>?,
                refusedMissions:
                    value["refusedMissions"] as List<MissionModel>?,
                contacts: value["contacts"] as List<ContactModel>?,
                roleId: value["role_id"] as String,
                isLoading: false,
              )))
          .catchError((onError) => emit(state.copyWith(
                missionErrorMessage: onError.toString(),
                isLoading: false,
              )));
    });

    on<CreateMissionEvent>(
        (CreateMissionEvent event, Emitter<MissionState> emit) async {
      emit(state.copyWith(isLoading: true));

      await MissionService.createMission(
        customerId: event.customerId,
        driverId: event.driverId,
        receiverId: event.receiverId,
        senderId: event.senderId,
        addressStart: event.addressStart,
        addressEnd: event.addressEnd,
        dateStart: event.dateStart,
        price: event.price,
      )
          .then((value) => emit(state.copyWith(
                isLoading: false,
              )))
          .onError<PostgrestException>((error, _) => emit(state.copyWith(
                missionErrorMessage: "500: Internal error server $error",
                isLoading: false,
              )))
          .catchError((onError) => emit(state.copyWith(
                missionErrorMessage: onError.toString(),
                isLoading: false,
              )));
    });

    on<ResponseMissionEvent>(
        (ResponseMissionEvent event, Emitter<MissionState> emit) async {
      await MissionService.responseMission(
        missionId: event.missionId,
        isAccepted: event.isAccepted,
        isRefused: event.isRefused,
      );
    });
  }
}
