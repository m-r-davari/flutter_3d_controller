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
  String? chosenAnimation;

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
              List<String> availableAnimations = await controller.getAvailableAnimations();
              print('Animations : $availableAnimations -- Length : ${availableAnimations.length}' );
              chosenAnimation = await showAnimPickerDialog(availableAnimations,chosenAnimation);
              controller.playAnimation(animationName: chosenAnimation);
            },
            child: const Icon(Icons.format_list_bulleted_outlined),
          ),
          const SizedBox(height: 4,),
          FloatingActionButton.small(
            onPressed: (){
              controller.setCameraOrbit(20, 20, 5);
              //controller.cameraTarget(1.6, 1.2, 3.9)
            },
            child: const Icon(Icons.camera_alt),
          )
        ],
      ),
      body: Container(
        color: Colors.grey,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Flutter3DViewer(
          controller: controller,
          src: 'assets/business_man.glb',
        ),
      ),
    );
  }

  Future<String?> showAnimPickerDialog(List<String> animationList,[String? chosenAnimation])async{
    return await showModalBottomSheet<String>(context: context, builder: (ctx){
      return SizedBox(
        height: 250,
        child: ListView.separated(
          itemCount: animationList.length,
          padding: const EdgeInsets.only(top: 16),
          itemBuilder: (ctx,index){
            return InkWell(
              onTap: (){
                Navigator.pop(context,animationList[index]);
              },
              child: Container(
                height: 50,
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${index+1}'),
                    Text(animationList[index]),
                    Icon(chosenAnimation == animationList[index] ? Icons.check_box : Icons.check_box_outline_blank)
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (ctx,index){
            return const Divider(color: Colors.grey,thickness: 0.6,indent: 10,endIndent: 10,);
          },
        ),
      );
    });
  }





}
