import 'package:flutter/material.dart';
import 'package:ios_color_picker/custom_picker/pickers/slider_picker/slider_helper.dart';
import 'package:ios_color_picker/custom_picker/pickers_selector_row.dart';
import 'package:ios_color_picker/custom_picker/picker_sheet_theme.dart';
import 'package:ios_color_picker/custom_picker/shared.dart';
import 'color_observer.dart';
import 'helpers/cache_helper.dart';
import 'history_colors.dart';

///Returns iOS Style color Picker
class IosColorPicker extends StatefulWidget {
  const IosColorPicker({
    super.key,
    required this.onColorSelected,
    this.sheetBackgroundColor = const Color(0xff232421),
  });

  ///returns the selected color
  final ValueChanged<Color> onColorSelected;

  ///Background color of the bottom sheet panel.
  final Color sheetBackgroundColor;

  @override
  State<IosColorPicker> createState() => _IosColorPickerState();
}

class _IosColorPickerState extends State<IosColorPicker> {
  @override
  void initState() {
    CacheHelper.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final sheetTheme = PickerSheetTheme(
      sheetBackgroundColor: widget.sheetBackgroundColor,
      child: _buildSheetContent(context),
    );

    return Column(
      children: [
        Expanded(
          child: InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            onTap: () => Navigator.pop(context),
            child: SizedBox(width: maxWidth(context)),
          ),
        ),
        Container(
          width: maxWidth(context),
          height: 340 + componentsHeight(context),
          decoration: BoxDecoration(
            color: widget.sheetBackgroundColor,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(10),
              topLeft: Radius.circular(10),
            ),
          ),
          child: sheetTheme,
        ),
      ],
    );
  }

  Widget _buildSheetContent(BuildContext context) {
    final theme = PickerSheetTheme.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 8, 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: 40),
              Text(
                'Colors',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 17,
                  color: theme.primaryTextColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
              IconButton(
                highlightColor: Colors.transparent,
                onPressed: () => Navigator.pop(context),
                icon: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: theme.closeButtonColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.close_rounded,
                    color: theme.closeIconColor,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
        PickersSelectorRow(onColorChanged: widget.onColorSelected),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17.0),
          child: Text(
            'OPACITY',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontSize: 13,
              color: theme.secondaryTextColor,
            ),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 2,
                ),
                child: SizedBox(
                  height: 36.0,
                  child: ValueListenableBuilder<Color>(
                    valueListenable: colorController,
                    builder: (context, color, child) {
                      return ColorPickerSlider(
                        TrackType.alpha,
                        HSVColor.fromColor(color),
                        small: false,
                        (v) {
                          colorController.updateOpacity(v.alpha);
                          widget.onColorSelected(colorController.value);
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
            Container(
              height: 36,
              width: 77,
              margin: const EdgeInsets.only(right: 16, left: 16),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: theme.valueFieldColor,
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
              child: ValueListenableBuilder<Color>(
                valueListenable: colorController,
                builder: (context, color, child) {
                  final alpha = (color.a * 100).toInt();
                  return Text(
                    "$alpha%",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: 16,
                      letterSpacing: 0.6,
                      color: theme.primaryTextColor,
                      fontWeight: FontWeight.w600,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        Divider(
          height: 44,
          thickness: 0.2,
          indent: 17,
          endIndent: 17,
          color: theme.secondaryTextColor,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 78,
                  width: 78,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  margin: const EdgeInsets.only(left: 16),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Transform.scale(
                    scale: 1.5,
                    child: Transform.rotate(
                      angle: 0.76,
                      child: Row(
                        children: [
                          Expanded(child: Container(color: Colors.white)),
                          Expanded(child: Container(color: Colors.black)),
                        ],
                      ),
                    ),
                  ),
                ),
                ValueListenableBuilder<Color>(
                  valueListenable: colorController,
                  builder: (context, color, child) {
                    return Container(
                      height: 78,
                      width: 78,
                      margin: const EdgeInsets.only(left: 16),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        color: color,
                      ),
                    );
                  },
                ),
              ],
            ),
            HistoryColors(onColorChanged: widget.onColorSelected),
          ],
        ),
      ],
    );
  }
}
