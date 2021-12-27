
import 'package:get/get.dart';
import 'package:v2fly/src/page/topic/logic.dart';

class TopicBinding extends Bindings{

  @override
  void dependencies() {
    Get.lazyPut(() => TopicLogic());
  }

}