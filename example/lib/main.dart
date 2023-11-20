import 'package:flutter/material.dart';
import 'package:flutter_3d_controller/flutter_3d_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter 3D controller example'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton.small(
            onPressed: (){
              controller.playAnimation();
            },
            child: const Icon(Icons.play_arrow),
          ),
          const SizedBox(height: 4,),
          FloatingActionButton.small(
            onPressed: (){
              controller.pauseAnimation();
            },
            child: const Icon(Icons.pause),
          ),
          const SizedBox(height: 4,),
          FloatingActionButton.small(
            onPressed: ()async{
              final result = await controller.getAvailableAnimations();
              print('Anims : $result');
            },
            child: const Icon(Icons.format_list_bulleted_outlined),
          )
        ],
      ),
      body: Container(
        color: Colors.blueAccent,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Flutter3DViewer(
          controller: controller,
          src: 'assets/dancing_girl.glb',
        ),
      ),
    );
  }
}
