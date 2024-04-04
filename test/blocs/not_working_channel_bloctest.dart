import 'dart:io';

import 'package:mocktail/mocktail.dart';
import 'package:ovtc_app/bloc/channel/channel_bloc.dart';
import 'package:ovtc_app/models/channel_model.dart';
import 'package:ovtc_app/services/channel_service.dart';
import 'package:test/test.dart';

// Manually
// class ManuallyMockRepository implements ChannelService {
//   @override
//   Future<List<ChannelModel>?> getAllChannels() async {
//     final datenow = DateTime.now();
//     return [
//       ChannelModel(id: "001", lastUpdate: datenow, title: "first"),
//       ChannelModel(id: "002", lastUpdate: datenow, title: "second"),
//       ChannelModel(id: "003", lastUpdate: datenow, title: "third"),
//     ];
//   }
// }

class MockChannelService extends Mock implements ChannelService {}

void main() {
  final datenow = DateTime.now();
  late MockChannelService mockChannelService;
  late ChannelService channelService;
  final List<ChannelModel?> channels = [
    ChannelModel(id: "001", lastUpdate: datenow, title: "first"),
    ChannelModel(id: "002", lastUpdate: datenow, title: "second"),
    ChannelModel(id: "003", lastUpdate: datenow, title: "third"),
  ];
  late ChannelBloc channelBloc;

  setUp(() {
    mockChannelService = MockChannelService();
    channelService = ChannelService();
    channelBloc = ChannelBloc(service: channelService);
  });
  group('Testing ChannelBloc', () {
    test(
      "Test Http request",
      () async {
        HttpOverrides.global = null;
        List<ChannelModel>? channels =
            await channelService.getAllChannels(authId: "001");
        expect(channels?.first != null, true);
      },
    );
  });
}
