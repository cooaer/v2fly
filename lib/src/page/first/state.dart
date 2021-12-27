import 'package:v2fly/src/model/home.dart';
import 'package:v2fly/src/model/topic.dart';

class FirstState {
  static const cachedTabsCount = 3;
  int selectedTabIndex = -1;

  List<HomeTab> tabs = [];

  // LinkedHashMap<String, List<Topic>> idTopics = LinkedHashMap.identity();
  Map<String, List<Topic>> idTopics = {};

  void updateTabs(List<HomeTab> newTabs) {
    tabs.clear();
    tabs.addAll(newTabs);

    selectedTabIndex = tabs.indexWhere((element) => element.selected);
  }

  void updateTopics(List<Topic> topics) {
    final tabId = tabs[selectedTabIndex].id;
    idTopics[tabId] = topics;
    // idTopics.keys.toList().reversed.skip(cachedTabsCount).forEach((element) {
    //   idTopics.remove(element);
    // });
  }
}
