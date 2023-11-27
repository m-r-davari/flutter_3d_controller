import 'dart:math';

class Utils {

  String generateId(){
    return 'el-id-${Random.secure().nextInt(99999999)}-${Random.secure().nextInt(99999999)}';
  }

  String injectedJS(){
    String jsStr = """
    customEvaluate = (code) => { eval(code) }
    customEvaluateWithResult = (code) => { return eval (code) }
    """;
    return jsStr;
  }

}
