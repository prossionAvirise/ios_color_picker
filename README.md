# ios_color_picker

A Flutter package that provides an iOS-style color picker UI for every Flutter
platform, plus access to the native iOS color picker on iOS.

## Supported Platforms

- Linux
- macOS
- Web
- Windows
- iOS
- Android

## Requirements

- Flutter 3.41.0 or later
- Dart 3.11.4 or later
- Android minSdk 24
- iOS 14.0 or later for the native iOS picker
- macOS 10.15 or later

## Features

### Screenshots & Demo

<img src="https://res.cloudinary.com/dcvoshrrl/image/upload/v1737504135/color_picker/1_v2nk8m.png" width="300">
<img src="https://res.cloudinary.com/dcvoshrrl/image/upload/v1738019895/color_picker/esmczhsgeo6qk7py5x66.gif" width="300">
<img src="https://res.cloudinary.com/dcvoshrrl/image/upload/v1737504183/color_picker/1_p91sih.gif" width="300">
<img src="https://res.cloudinary.com/dcvoshrrl/image/upload/v1737504212/color_picker/3_zkbdzu.gif" width="300">



## Getting Started

Add the package and create a controller. Dispose the controller from your
widget's `dispose` method because the native iOS picker streams color changes
through an event channel.

## Usage

```dart
final iosColorPickerController = IOSColorPickerController();

/// Native iOS Color Picker
ElevatedButton(
  onPressed: () {
    iosColorPickerController.showNativeIosColorPicker(
      startingColor: backgroundColor,
      darkMode: true,
      onColorChanged: (color) {
        setState(() {
          backgroundColor = color;
        });
      },
    );
  },
  child: Text("Native iOS"),
),

/// Custom iOS Color Picker (for all platforms)
ElevatedButton(
  onPressed: () {
    iosColorPickerController.showIOSCustomColorPicker(
      startingColor: backgroundColor,
      onColorChanged: (color) {
        setState(() {
          backgroundColor = color;
        });
      },
      context: context,
    );
  },
  child: Text("Custom iOS for all"),
),
```

Dispose the controller:

```dart
final IOSColorPickerController iosColorPickerController =
    IOSColorPickerController();

@override
void dispose() {
  iosColorPickerController.dispose();
  super.dispose();
}

```

## Example

Run the app in the example/ folder to explore the plugin.

## Additional Information

For more updates and inquiries, connect with me on LinkedIn:

<a href="https://www.linkedin.com/in/mo-kh-selim/"> <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/8/81/LinkedIn_icon.svg/144px-LinkedIn_icon.svg.png" width="32" /> </a>