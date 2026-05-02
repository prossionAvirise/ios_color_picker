import 'dart:ui';
import 'package:flutter_test/flutter_test.dart';
import 'package:ios_color_picker/native_picker/ios_color_picker.dart';
import 'package:ios_color_picker/native_picker/ios_color_picker_platform_interface.dart';
import 'package:ios_color_picker/native_picker/ios_color_picker_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockIosColorPickerPlatform
    with MockPlatformInterfaceMixin
    implements IosColorPickerPlatform {
  Map<String, double>? lastDefaultColor;
  bool? lastDarkMode;

  @override
  Future<Color?> getPlatformColor(
    Map<String, double>? defaultColor,
    bool? darkMode,
  ) async {
    lastDefaultColor = defaultColor;
    lastDarkMode = darkMode;
    return const Color(0xFF336699);
  }
}

void main() {
  final IosColorPickerPlatform initialPlatform =
      IosColorPickerPlatform.instance;

  test('$MethodChannelIosColorPicker is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelIosColorPicker>());
  });

  test(
    'NativeIosColorPicker delegates color picking to platform instance',
    () async {
      final picker = NativeIosColorPicker();
      final fakePlatform = MockIosColorPickerPlatform();
      IosColorPickerPlatform.instance = fakePlatform;

      final color = await picker.getPlatformColor(
        const Color(0xFF336699),
        true,
      );

      expect(color, const Color(0xFF336699));
      expect(fakePlatform.lastDefaultColor?['red'], moreOrLessEquals(0.2));
      expect(fakePlatform.lastDefaultColor?['green'], moreOrLessEquals(0.4));
      expect(fakePlatform.lastDefaultColor?['blue'], moreOrLessEquals(0.6));
      expect(fakePlatform.lastDefaultColor?['alpha'], 1.0);
      expect(fakePlatform.lastDarkMode, isTrue);
    },
  );
}
