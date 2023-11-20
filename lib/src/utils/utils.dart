import 'dart:math';

class Utils {
  final random = Random();

  String get generateId => 'el-id-${random.nextInt(99999999)}-${random.nextInt(99999999)}';

  String relatedJs({required String id}) => """var mainModelViewer = document.querySelector('#$id');
cameraOrbit = (a, b, c) => {console.log("------camOrbiit------"); mainModelViewer.cameraOrbit = `\${a}deg \${b}deg \${c}m`; }
cameraTarget = (x, y, z) => {mainModelViewer.cameraTarget = `\${x}m \${y}m \${z}m`}
customEvaluate = (code) => { eval(code) }
""";

}
