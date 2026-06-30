import 'package:flutter/material.dart';
import 'package:ios_color_picker/custom_picker/shared.dart';
import 'package:ios_color_picker/custom_picker/utils.dart';

/// Adapts picker chrome (text, controls) to [sheetBackgroundColor].
class PickerSheetTheme extends InheritedWidget {
  const PickerSheetTheme({
    super.key,
    required this.sheetBackgroundColor,
    required super.child,
  });

  final Color sheetBackgroundColor;

  bool get _useLightForeground => useWhiteForeground(sheetBackgroundColor);

  Color get primaryTextColor =>
      _useLightForeground ? Colors.white : Colors.black;

  Color get secondaryTextColor => primaryTextColor.withValues(alpha: 0.6);

  Color get valueFieldColor =>
      _useLightForeground ? valueColor : const Color(0xFFE5E5EA);

  Color get segmentTrackColor =>
      _useLightForeground ? sliderColor : const Color(0xFFE5E5EA);

  Color get segmentSelectedColor =>
      _useLightForeground ? selectedSliderColor : Colors.white;

  Color get closeButtonColor =>
      _useLightForeground ? const Color(0xff3A3A3B) : const Color(0xFFE5E5EA);

  Color get closeIconColor =>
      _useLightForeground ? const Color(0xffA4A4AA) : const Color(0xFF8E8E93);

  Color get selectionBorderColor =>
      _useLightForeground ? Colors.white : Colors.black;

  Color get addButtonColor => _useLightForeground
      ? Colors.white.withValues(alpha: 0.16)
      : Colors.black.withValues(alpha: 0.08);

  Color get addIconColor =>
      _useLightForeground ? const Color(0xffB0B0BD) : const Color(0xFF8E8E93);

  Color get pageIndicatorDotColor => primaryTextColor.withValues(alpha: 0.3);

  Color get pageIndicatorActiveDotColor => primaryTextColor;

  static PickerSheetTheme of(BuildContext context) {
    final theme =
        context.dependOnInheritedWidgetOfExactType<PickerSheetTheme>();
    assert(theme != null, 'PickerSheetTheme not found in context');
    return theme!;
  }

  @override
  bool updateShouldNotify(PickerSheetTheme oldWidget) =>
      sheetBackgroundColor != oldWidget.sheetBackgroundColor;
}
