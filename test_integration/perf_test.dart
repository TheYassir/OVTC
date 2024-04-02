import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ovtc_app/main.dart';

void main() {
  group('Testing App Performance', () {
    final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
    binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

    testWidgets('Login test', (tester) async {
      await tester.pumpWidget(const MyApp());

      final inputEmail = find.byKey(const Key("input_email"));
      final inputPassword = find.byKey(const Key("input_password"));
      final buttonSubmit = find.byKey(const Key("button_submit"));

      await binding.traceAction(() async {
        await tester.enterText(inputEmail, "miaaaou78@gmail.com");
        await tester.enterText(inputPassword, "rissay78");
        await tester.tap(buttonSubmit);
        await tester.pumpAndSettle();
      }, reportKey: 'login_summary');
    });
  });
}
