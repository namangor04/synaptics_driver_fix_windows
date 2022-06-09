A Flutter package to fix horizontal scroll, which does not work on some (not-so) older windows devices with Synaptics TouchPads and Synaptics TouchPad Drivers.

## Features

* Fixes Horizontal Scroll on windows devices with Synaptics TouchPads and Synaptics TouchPad Drivers.

## Getting started

* Add the package to `pubspec.yaml` file.
* Run `flutter pub get`.
* Import the package: `import package:synaptics_driver_fix_windows.dart/synaptics_driver_fix_windows.dart;`

## Usage

* Wrap the widget which you want to scroll horizontally like this:

```dart
WindowsSynapticsFixWidget(
    scrollController: horizontalScrollController,
    child: yourHorizontallyScrollableChild,
);

```

## Additional information

If you experience any issues, please file those [here on Github][1]. If you want to contribute to this repo, open a PR on [Github][2]. If you want to view the API in detail, visit [synaptics_driver_fix_windows on our website][3].

Also, We would really appreciate if you view our [website][4] and our [apps][5].

[1]: https://github.com/nbrgdevelopers41/synaptics_driver_fix_windows/issues

[2]: https://github.com/nbrgdevelopers41/synaptics_driver_fix_windows/pulls

[3]: https://nbrg-developers.web.app/docs/plugins/flutter/synaptics_driver_fix_windows

[4]: https://nbrg-developers.web.app

[5]: https://nbrg-developers.web.app/services/one-nbrg/apps
