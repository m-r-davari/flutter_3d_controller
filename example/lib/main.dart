import 'package:flutter/material.dart';
import 'package:flutter_3d_controller/flutter_3d_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter 3D Controller',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter 3D Controller Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Flutter3DController controller = Flutter3DController();
  String? chosenAnimation;
  String? chosenTexture;

  @override
  void initState() {
    super.initState();
    controller.onModelLoaded.addListener(() {
      debugPrint('model is loaded : ${controller.onModelLoaded.value}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff0d2039),
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {
              controller.playAnimation();
            },
            icon: const Icon(Icons.play_arrow),
          ),
          const SizedBox(
            height: 4,
          ),
          IconButton(
            onPressed: () {
              controller.pauseAnimation();
              //controller.stopAnimation();
            },
            icon: const Icon(Icons.pause),
          ),
          const SizedBox(
            height: 4,
          ),
          IconButton(
            onPressed: () {
              controller.resetAnimation();
            },
            icon: const Icon(Icons.replay_circle_filled),
          ),
          const SizedBox(
            height: 4,
          ),
          IconButton(
            onPressed: () async {
              List<String> availableAnimations =
                  await controller.getAvailableAnimations();
              debugPrint(
                  'Animations : $availableAnimations --- Length : ${availableAnimations.length}');
              chosenAnimation = await showPickerDialog(
                  'Animations', availableAnimations, chosenAnimation);
              controller.playAnimation(animationName: chosenAnimation);
            },
            icon: const Icon(Icons.format_list_bulleted_outlined),
          ),
          const SizedBox(
            height: 4,
          ),
          IconButton(
            onPressed: () async {
              List<String> availableTextures =
                  await controller.getAvailableTextures();
              debugPrint(
                  'Textures : $availableTextures --- Length : ${availableTextures.length}');
              chosenTexture = await showPickerDialog(
                  'Textures', availableTextures, chosenTexture);
              controller.setTexture(textureName: chosenTexture ?? '');
            },
            icon: const Icon(Icons.list_alt_rounded),
          ),
          const SizedBox(
            height: 4,
          ),
          IconButton(
            onPressed: () {
              controller.setCameraOrbit(20, 20, 5);
              //controller.setCameraTarget(0.3, 0.2, 0.4);
            },
            icon: const Icon(Icons.camera_alt),
          ),
          const SizedBox(
            height: 4,
          ),
          IconButton(
            onPressed: () {
              controller.resetCameraOrbit();
              //controller.resetCameraTarget();
            },
            icon: const Icon(Icons.cameraswitch_outlined),
          )
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.grey,
          gradient: RadialGradient(
            colors: [
              Color(0xffffffff),
              Colors.grey,
            ],
            stops: [0.1, 1.0],
            radius: 0.7,
            center: Alignment.center,
          ),
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Flexible(
              flex: 1,
              child: Flutter3DViewer.obj(
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
              ),
            ),
            Flexible(
              flex: 1,
              child: Flutter3DViewer(
                //If you pass 'true' the flutter_3d_controller will add gesture interceptor layer
                //to prevent gesture recognizers from malfunctioning on iOS and some Android devices.
                // the default value is true
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
                src:
                    'assets/business_man.glb', //3D model with different animations
                //src: 'assets/sheen_chair.glb', //3D model with different textures
                //src: 'https://modelviewer.dev/shared-assets/models/Astronaut.glb', // 3D model from URL
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<String?> showPickerDialog(String title, List<String> inputList,
      [String? chosenItem]) async {
    return await showModalBottomSheet<String>(
      context: context,
      builder: (ctx) {
        return SizedBox(
          height: 250,
          child: inputList.isEmpty
              ? Center(
                  child: Text('$title list is empty'),
                )
              : ListView.separated(
                  itemCount: inputList.length,
                  padding: const EdgeInsets.only(top: 16),
                  itemBuilder: (ctx, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.pop(context, inputList[index]);
                      },
                      child: Container(
                        height: 50,
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${index + 1}'),
                            Text(inputList[index]),
                            Icon(
                              chosenItem == inputList[index]
                                  ? Icons.check_box
                                  : Icons.check_box_outline_blank,
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (ctx, index) {
                    return const Divider(
                      color: Colors.grey,
                      thickness: 0.6,
                      indent: 10,
                      endIndent: 10,
                    );
                  },
                ),
        );
      },
    );
  }
}
