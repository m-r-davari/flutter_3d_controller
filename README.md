# Flutter 3D Controller

The most complete Flutter package for rendering interactive 3D models in various formats (**GLB**, **GLTF**, **OBJ**, **FBX**), with the ability to control animations, textures, camera, and more.

# Why Flutter 3D Controller?

The ***Flutter 3D Controller*** package is the most comprehensive solution for rendering various 3D model formats, offering extensive functionality to give users optimal control over 3D models.

It leads in implementing new features, while **some other packages have just copied Flutter 3D Controller's features and code** without proper credit or adherence to licensing.

Notably, when testing **other available packages**, users may experience **gesture malfunctions** on iOS and certain Android devices. However, **Flutter 3D Controller** is the first and only package to **resolve this issue** with its **gesture interceptor feature**, introduced in **version 2.0.0**, released on **October 5, 2024**.

## Features

- Mobile and Web stable version (support **glb**, **gltf** and **obj** format)
- Load 3D model from assets
- Load 3D model from URL
- Gesture interceptor (Prevents gesture recognizers from malfunctioning)
- Controller model loading value listener
- Model loading states callbacks, **onProgress**, **onLoad** and **onError**
- Load OBJ models with textures and mtl files
- OBJ 3D models scale and camera properties
- Play animation
- Switch between animations
- Pause animation
- Reset animation
- Stop animation
- Get available animations list
- Switch between textures
- Get available textures list
- Set camera target
- Reset camera target
- Set camera orbit
- Reset camera orbit
- Default loading progressbar color
- Enable/disable touch control

<!--
## Todo (Next Versions)
- Change model source with setState
- Support fbx format
-->

## Samples

<img src="https://raw.githubusercontent.com/m-r-davari/content-holder/refs/heads/master/flutter_3d_controller/scrs_gifs_v2/male_scr.gif" alt="Model1" width="19%"/> <img src="https://raw.githubusercontent.com/m-r-davari/content-holder/refs/heads/master/flutter_3d_controller/scrs_gifs_v2/lambo_scr.gif" alt="Model2" width="19%"/> <img src="https://raw.githubusercontent.com/m-r-davari/content-holder/refs/heads/master/flutter_3d_controller/scrs_gifs_v2/dog_scr.gif" alt="Model3" width="19%"/> <img src="https://raw.githubusercontent.com/m-r-davari/content-holder/refs/heads/master/flutter_3d_controller/scrs_gifs_v2/chair_scr.gif" alt="Model3" width="19%"/> <img src="https://raw.githubusercontent.com/m-r-davari/content-holder/refs/heads/master/flutter_3d_controller/scrs_gifs_v2/dash_scr.gif" alt="Model3" width="19%"/>
<img src="https://raw.githubusercontent.com/m-r-davari/content-holder/refs/heads/master/flutter_3d_controller/scrs_gifs_v2/female_scr.gif" alt="Model1" width="19%"/> <img src="https://raw.githubusercontent.com/m-r-davari/content-holder/refs/heads/master/flutter_3d_controller/scrs_gifs_v2/bird_scr.gif" alt="Model2" width="19%"/> <img src="https://raw.githubusercontent.com/m-r-davari/content-holder/refs/heads/master/flutter_3d_controller/scrs_gifs_v2/male2_scr.gif" alt="Model3" width="19%"/> <img src="https://raw.githubusercontent.com/m-r-davari/content-holder/refs/heads/master/flutter_3d_controller/scrs_gifs_v2/donut_scr.gif" alt="Model3" width="19%"/> <img src="https://raw.githubusercontent.com/m-r-davari/content-holder/refs/heads/master/flutter_3d_controller/scrs_gifs_v2/multi_scr.gif" alt="Model3" width="19%"/>


## Compatibility

- Android
- iOS
- Web

## Notes

- For now this package supports **GLB**, **glTF** and **OBJ** format, other 3D formats coming soon.
- Visit the full example to see how to use this package.

## Brief Examples

## How to use controller
```dart
//Create controller object to control 3D model.
Flutter3DController controller = Flutter3DController();

//Listen to model loading state via controller
controller.onModelLoaded.addListener(() {
  debugPrint('model is loaded : ${controller.onModelLoaded.value}');
});

//It will play 3D model animation, you can use it to play or switch between animations.
controller.playAnimation();

//If you pass specific animation name it will play that specific animation.
//If you pass null and your model has at least 1 animation it will play first animation.
controller.playAnimation(animationName: chosenAnimation);

//It will pause the animation at current frame.
controller.pauseAnimation();

//It will reset and play animation from first frame (from beginning).
controller.resetAnimation();

//It will stop the animation.
controller.stopAnimation();

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

## How to load glb and gltf models
```dart
//The 3D viewer widget for glb and gltf format
Flutter3DViewer(
    //If you pass 'true' the flutter_3d_controller will add gesture interceptor layer
    //to prevent gesture recognizers from malfunctioning on iOS and some Android devices.
    //the default value is true
    activeGestureInterceptor: true,
    //If you don't pass progressBarColor, the color of defaultLoadingProgressBar will be grey.
    //You can set your custom color or use [Colors.transparent] for hiding loadingProgressBar.
    progressBarColor: Colors.orange,
    //You can disable viewer touch response by setting 'enableTouch' to 'false'
    enableTouch: true,
    //This callBack will return the loading progress value between 0 and 1.0
    onProgress: (double progressValue) {
      debugPrint('model loading progress : $progressValue');
    },
    //This callBack will call after model loaded successfully and will return model address
    onLoad: (String modelAddress) {
      debugPrint('model loaded : $modelAddress');
    },
    //this callBack will call when model failed to load and will return failure error
    onError: (String error) {
      debugPrint('model failed to load : $error');
    },
    //You can have full control of 3d model animations, textures and camera
    controller: controller,
    src: 'assets/business_man.glb', //3D model with different animations
    //src: 'assets/sheen_chair.glb', //3D model with different textures
    //src: 'https://modelviewer.dev/shared-assets/models/Astronaut.glb', // 3D model from URL
)
```

## How to load obj models
```dart
//The 3D viewer widget for obj format
Flutter3DViewer.obj(
    src: 'assets/flutter_dash.obj',
    //src: 'https://raw.githubusercontent.com/m-r-davari/content-holder/refs/heads/master/flutter_3d_controller/flutter_dash_model/flutter_dash.obj',
    scale: 5,
    // Initial scale of obj model
    cameraX: 0,
    // Initial cameraX position of obj model
    cameraY: 0,
    //Initial cameraY position of obj model
    cameraZ: 10,
    //Initial cameraZ position of obj model
    //This callBack will return the loading progress value between 0 and 1.0
    onProgress: (double progressValue) {
      debugPrint('model loading progress : $progressValue');
    },
    //This callBack will call after model loaded successfully and will return model address
    onLoad: (String modelAddress) {
      debugPrint('model loaded : $modelAddress');
    },
    //this callBack will call when model failed to load and will return failure erro
    onError: (String error) {
      debugPrint('model failed to load : $error');
    },
)
```

## Installation

### `pubspec.yaml`

```yaml
dependencies:
  flutter_3d_controller: ^2.0.1
```

### `AndroidManifest.xml` (Android only)

Configure your app's `android/app/src/main/AndroidManifest.xml` as follows:

```diff

+   <uses-permission android:name="android.permission.INTERNET"/>

     <application
        android:name="${applicationName}"
        android:icon="@mipmap/ic_launcher"
-       android:label="example">
+       android:label="example"
+       android:usesCleartextTraffic="true">
        <activity
            android:name=".MainActivity"
```

### `app/build.gradle` (Android only)

Change minSdkVersion to 21.

    defaultConfig {
        ...
        minSdkVersion 21
        ...
    }

### `Info.plist` (iOS only)

To use this package on iOS, you need to opt-in to the embedded views preview
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
    <script type="module" src="./assets/packages/flutter_3d_controller/assets/model_viewer.min.js" defer></script>
</head>
```


## Common Issues
- **The 3D model does not display** : First check the example, if models in examples loads, may be there is problem with your model or your model path.
- **The animation list could not be retrieved** : Check if there are any special characters in the animation names that might cause a JSON encoding error.

## Not working with a url on a real iOS device?

**Problem Description** : If you're having trouble loading 3D models from a URL on a real iOS device, **Lockdown Mode** might be the cause. Lockdown Mode is a security feature in iOS that restricts certain functionalities like network requests or loading embedded content to protect user data.

## How to Disable Lockdown Mode
Follow these steps to disable Lockdown Mode on your device:

1. Open the **Settings** app on your iPhone.
2. Scroll down and select **Privacy and Security**.
3. Tap on **Lockdown Mode**.
4. Select **Turn Off Lockdown Mode**. You may need to enter your password to confirm.
5. After disabling Lockdown Mode, return to the app and try loading the 3D model again.

---

## More Info

This package use 'Model Viewer' to render 3D models and it may have some issue in rendering some models/textures, the core of package (Model Viewer) will change in future to support all type of 3D models.
