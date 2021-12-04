import 'package:v2fly/src/model/entity/node.dart';
import 'package:v2fly/src/model/entity/topic.dart';

class HomeData {
  final List<HomeTab> tabs;
  final List<Topic> topics;
  final List<NodeCategory> nodeCategories;

  HomeData(this.tabs, this.topics, this.nodeCategories);

  @override
  String toString() {
    return 'HomeData{tabs: $tabs, topics: $topics, nodeCategories: $nodeCategories}';
  }
}

class HomeTab {
  final String id;
  final String name;

  final bool selected; //是否被选中

  HomeTab(this.id, this.name, this.selected) {}

  @override
  String toString() {
    return 'HomeTab{id: $id, name: $name, selected: $selected}';
  }
}
