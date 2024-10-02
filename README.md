# Flutter 3D Controller

A Flutter package for rendering interactive 3D models in different formats(glb, gltf, fbx, obj), with ability to control animations, textures and camera.

## Features

- Mobile and Web stable version (support glb & gltf format)
- Load 3D model from assets
- Load 3D model from URL
- Play animation
- Switch between animations
- Pause animation
- Reset animation
- Get available animations list
- Switch between textures
- Get available textures list
- Set camera target
- Reset camera target
- Set camera orbit
- Reset camera orbit
- Set default loading progressbar color

<!--
## Todo (Next Versions)
- Change model source with setState
- Support obj and fbx format
-->

## Samples

<img src="https://raw.githubusercontent.com/m-r-davari/flutter_3d_controller/master/example/samples/model1.png" alt="Model1" width="24%"/> <img src="https://raw.githubusercontent.com/m-r-davari/flutter_3d_controller/master/example/samples/model2.png" alt="Model2" width="24%"/> <img src="https://raw.githubusercontent.com/m-r-davari/flutter_3d_controller/master/example/samples/model3.png" alt="Model3" width="24%"/> <img src="https://raw.githubusercontent.com/m-r-davari/flutter_3d_controller/master/example/samples/model4.png" alt="Model3" width="24%"/>
<img src="https://raw.githubusercontent.com/m-r-davari/flutter_3d_controller/master/example/samples/model1.gif" alt="Model1" width="24%"/> <img src="https://raw.githubusercontent.com/m-r-davari/flutter_3d_controller/master/example/samples/model2.gif" alt="Model2" width="24%"/> <img src="https://raw.githubusercontent.com/m-r-davari/flutter_3d_controller/master/example/samples/model3.gif" alt="Model3" width="24%"/> <img src="https://raw.githubusercontent.com/m-r-davari/flutter_3d_controller/master/example/samples/model4.gif" alt="Model3" width="24%"/>


## Compatibility

- Android
- iOS
- Web

## Notes

- For now this package only support GLB & glTF format, other 3d formats coming soon.
- Visit the full example to see how to use this package

## Brief Example

```dart
//Create controller object to control 3D model.
Flutter3DController controller = Flutter3DController();

//It will play 3D model animation, you can use it to play or switch between animations.
controller.playAnimation();

//If you pass specific animation name it will play that specific animation.
//If you pass null and your model has at least 1 animation it will play first animation.
controller.playAnimation(animationName: chosenAnimation);

//It will pause the animation at current frame.
controller.pauseAnimation();

//It will reset and play animation from first frame (from beginning).
controller.resetAnimation();

//It will return available animation list of 3D model.
await controller.getAvailableAnimations();

//It will load desired texture of 3D model, you need to pass texture name.
controller.setTexture(textureName: chosenTexture);

//It will return available textures list of 3D model.
await controller.getAvailableTextures();

//It will set your desired camera target.
controller.setCameraTarget(0.3, 0.2, 0.4);

//It will reset the camera target to default.
controller.resetCameraTarget();

//It will set your desired camera orbit.
controller.setCameraOrbit(20, 20, 5);

//It will reset the camera orbit to default.
controller.resetCameraOrbit();

```

```dart
//The 3D viewer widget
Flutter3DViewer(
    //If you don't pass progressBarColor the color of defaultLoadingProgressBar will be grey.
    //You can set your custom color or use [Colors.transparent] for hiding the loadingProgressBar.
    progressBarColor: Colors.blue,
    controller: controller,
    src: 'assets/business_man.glb', //3D model with different animations
    //src: 'assets/sheen_chair.glb', //3D model with different textures
    //src: 'https://modelviewer.dev/shared-assets/models/Astronaut.glb', //3D model from URL
)
```

## Installation

### `pubspec.yaml`

```yaml
dependencies:
  flutter_3d_controller: ^1.3.1
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

## Not working with a url or on a real device?:

## Problem Description
If you're having trouble loading 3D models from a URL on a real iOS device, **Lockdown Mode** might be the cause. Lockdown Mode is a security feature in iOS that restricts certain functionalities like network requests or loading embedded content to protect user data.

## Common Issues
- The 3D object does not display.
- No output is available to help debug the problem.

## How to Disable Lockdown Mode
Follow these steps to disable Lockdown Mode on your device:

1. Open the **Settings** app on your iPhone.
2. Scroll down and select **Privacy and Security**.
3. Tap on **Lockdown Mode**.
4. Select **Turn Off Lockdown Mode**. You may need to enter your password to confirm.
5. After disabling Lockdown Mode, return to the app and try loading the 3D model again.

---

## Adding a Lockdown Mode Check to Your App

To help users easily disable Lockdown Mode when it's affecting the app, you can add a verification dialog:

```dart
void _showLockdownDialog() {
  Future.delayed(Duration.zero, () {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Lockdown Mode Activated'),
        content: const Text(
          'Lockdown Mode is activated on this device. '
          'This may affect some features of the app. '
          'Please go to Settings > Privacy & Security > Lockdown Mode to disable it.'
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Understood'),
          ),
          TextButton(
            onPressed: _openSettings,
            child: const Text('Go to Settings'),
          ),
        ],
      ),
    );
  });
}
```
## Screenshots

<img src="https://imgur.com/a/ASegTgb" alt="Model1" width="24%"/> <img src="https://imgur.com/a/KTDr5J3" alt="Model1" width="24%"/> <img src="https://imgur.com/a/fUSLIqj" alt="Model1" width="24%"/>

### `web/index.html` (Web only)

Modify the `<head>` tag of your `web/index.html` to load the JavaScript, like so:

```html
<head>

  <!-- Other stuff -->

  <script type="module" src="./assets/packages/flutter_3d_controller/assets/model-viewer.min.js" defer></script>
</head>
```

## More Info

This package use 'Model Viewer' to render 3D models and it may have some issue in rendering some models/textures, the core of package (Model Viewer) will change in future to support all type of 3D models
