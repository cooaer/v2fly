
import 'package:get/get.dart';
import 'package:v2fly/src/page/first/logic.dart';

class FirstBinding extends Bindings{

  @override
  void dependencies() {
    Get.lazyPut(() => FirstLogic());
  }
}