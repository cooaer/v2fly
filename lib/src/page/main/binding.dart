
import 'package:get/get.dart';
import 'package:v2fly/src/page/first/logic.dart';
import 'package:v2fly/src/page/main/logic.dart';
import 'package:v2fly/src/page/nodes/logic.dart';

class MainBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => MainLogic());
    Get.lazyPut(() => FirstLogic());
    Get.lazyPut(() => NodesLogic());
  }
}