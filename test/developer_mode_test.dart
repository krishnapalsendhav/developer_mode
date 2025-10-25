import 'package:flutter_test/flutter_test.dart';
import 'package:developer_mode/developer_mode.dart';
import 'package:flutter/services.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const MethodChannel channel = MethodChannel('flutter_jailbreak_detection');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      switch (methodCall.method) {
        case 'jailbroken':
          return false;
        case 'developerMode':
          return false;
        default:
          return null;
      }
    });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('isJailbroken returns false on non-jailbroken device', () async {
    expect(await DeveloperMode.isJailbroken, false);
  });

  test('isDeveloperMode returns false when not in developer mode', () async {
    expect(await DeveloperMode.isDeveloperMode, false);
  });

  test('isJailbroken handles platform exceptions gracefully', () async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      throw PlatformException(code: 'ERROR', message: 'Test error');
    });

    expect(await DeveloperMode.isJailbroken, false);
  });

  test('isDeveloperMode handles platform exceptions gracefully', () async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      throw PlatformException(code: 'ERROR', message: 'Test error');
    });

    expect(await DeveloperMode.isDeveloperMode, false);
  });
}
