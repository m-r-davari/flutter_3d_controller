# 3D Model Viewer for Flutter

A Flutter package for rendering interactive 3D models in the GLB format with ability to control camera and animations.

## Features

- Play and control (play, pause, switch) 3d models animation in GLB format
- Get list of available animations from 3d models
- Switch between available animations
- Control camera position
- Control camera orbit

## Screenshot


<img src="https://github.com/m-r-davari/flutter_3d_controller/blob/main/example/samples/model1.gif" alt="model1" width="25%" loading="lazy"/>
<img src="https://github.com/m-r-davari/flutter_3d_controller/blob/main/example/samples/model2.gif" alt="model2" width="25%" loading="lazy"/>
<img src="https://github.com/m-r-davari/flutter_3d_controller/blob/main/example/samples/model3.gif" alt="model3" width="25%" loading="lazy"/>


|                                                  Model1                                                  |                                                                   Model2                                                                   |                                                                   Model3                                                                   |
|:---------------------------------------------------------------------------------------------------------:|:----------------------------------------------------------------------------------------------------------------------------------------------:|:----------------------------------------------------------------------------------------------------------------------------------------------:|
| <img src="https://github.com/m-r-davari/flutter_3d_controller/blob/main/example/samples/model1.gif" alt="Model1" width="25%"/> | <img src="https://github.com/m-r-davari/flutter_3d_controller/blob/main/example/samples/model2.gif" alt="Model2" width="25%"/> | <img src="https://github.com/m-r-davari/flutter_3d_controller/blob/main/example/samples/model3.gif" alt="Model3" width="25%"/> |


## Compatibility

- Android
- iOS
- Web

## Notes

For now this package only support GLB format, other 3d formats coming soon.

## Installation

### `pubspec.yaml`

```yaml
dependencies:
  flutter_3d_controller: ^0.0.3
```

### `AndroidManifest.xml` (Android 9+ only)

To use this widget on Android 9+ devices, your app must be permitted to make an HTTP connection to `http://localhost:XXXXX`.
Android 9 (API level 28) changed the default for [`android:usesCleartextTraffic`] from `true` to `false`,
so you will need to configure your app's `android/app/src/main/AndroidManifest.xml` as follows:

```diff
     <application
        android:name="${applicationName}"
        android:icon="@mipmap/ic_launcher"
-       android:label="example">
+       android:label="example"
+       android:usesCleartextTraffic="true">
        <activity
            android:name=".MainActivity"
```

This does not affect Android 8 and earlier. See [#7] for more information.

### `app/build.gradle` (Android only)

Change minSdkVersion to 21.

    defaultConfig {
        ...
        minSdkVersion 21
        ...
    }

### `Info.plist` (iOS only)

To use this widget on iOS, you need to opt-in to the embedded views preview
by adding a boolean property to your app's `ios/Runner/Info.plist` file, with
the key `io.flutter.embedded_views_preview` and the value `YES`:

```xml
  <key>io.flutter.embedded_views_preview</key>
  <true/>
```

### `web/index.html` (Web only)

Modify the `<head>` tag of your `web/index.html` to load the JavaScript, like so:

```html
<head>

  <!-- Other stuff -->

  <script type="module" src="./assets/packages/flutter_3d_controller/assets/model-viewer.min.js" defer></script>
</head>
```
