import 'package:get/get.dart';

import 'logic.dart';

class NodesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NodesLogic());
  }
}
