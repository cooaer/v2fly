import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class NodesPage extends StatelessWidget {
  final logic = Get.put(NodesLogic());
  final state = Get.find<NodesLogic>().state;

  NodesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
