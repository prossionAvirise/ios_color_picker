import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ios_color_picker/native_picker/ios_color_picker_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelIosColorPicker platform = MethodChannelIosColorPicker();
  const MethodChannel channel = MethodChannel('ios_color_picker');
  final methodCalls = <MethodCall>[];

  setUp(() {
    methodCalls.clear();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
          methodCalls.add(methodCall);
          return {'red': 0.25, 'green': 0.5, 'blue': 0.75, 'alpha': 1.0};
        });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test(
    'getPlatformColor sends arguments and converts platform response',
    () async {
      final color = await platform.getPlatformColor({
        'red': 0.1,
        'green': 0.2,
        'blue': 0.3,
        'alpha': 1.0,
      }, true);

      expect(methodCalls, hasLength(1));
      expect(methodCalls.single.method, 'pickColor');
      expect(methodCalls.single.arguments, {
        'darkMode': true,
        'defaultColor': {'red': 0.1, 'green': 0.2, 'blue': 0.3, 'alpha': 1.0},
      });
      expect(color?.r, moreOrLessEquals(0.25));
      expect(color?.g, moreOrLessEquals(0.5));
      expect(color?.b, moreOrLessEquals(0.75));
      expect(color?.a, moreOrLessEquals(1.0));
    },
  );

  test(
    'getPlatformColor returns null when native picker is dismissed',
    () async {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
            methodCalls.add(methodCall);
            return null;
          });

      expect(await platform.getPlatformColor(null, null), isNull);
      expect(methodCalls.single.arguments, isEmpty);
    },
  );
}
