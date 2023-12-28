# Flutter 3D Controller

A Flutter package for rendering interactive 3D models in different formats(glb, gltf, fbx, obj), with ability to control animations, textures and camera.

## Features

- Mobile and Web stable version (support glb & gltf format)
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

<!--
## Todo (Next Versions)

- Change model source with setState
- Load models from local storage
- Load models from web
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
  controller: controller,
  src: 'assets/business_man.glb',
)
```

## Installation

### `pubspec.yaml`

```yaml
dependencies:
  flutter_3d_controller: ^1.2.1
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

## More Info

This package use 'Model Viewer' to render 3D models and it may have some issue in rendering some models/textures, the core of package (Model Viewer) will change in future to support all type of 3D models