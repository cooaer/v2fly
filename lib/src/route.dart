import 'package:get/get.dart';
import 'package:v2fly/src/page/main/binding.dart';
import 'package:v2fly/src/page/main/view.dart';
import 'package:v2fly/src/page/topic/binding.dart';
import 'package:v2fly/src/page/topic/view.dart';

import 'model/topic.dart';


class RouteConfig {
  static const String main = "/";
  static const String topic = "/topic";

  static const String keyTopic = "topic";

  static final List<GetPage> getPages = [
    GetPage(name: main, page: () => const MainPage(), binding: MainBinding()),
    GetPage(
        name: topic, page: () => TopicPage(), binding: TopicBinding()),
  ];
}

class Router {
  ///打开话题详情页面
  static void toTopic(Topic topic) {
    Get.toNamed(RouteConfig.topic, arguments: {"topic": topic});
  }
}
