import 'package:html/dom.dart';
import 'package:v2fly/src/model/html.dart';
import 'package:v2fly/src/model/topic.dart';

///节点类型
class NodeCategory extends BaseModel {
  late String _name;
  final List<Node> _nodes = [];

  NodeCategory.fromHtml(Element html) : super.fromHtml(html) {
  }

  String get name => _name;

  List<Node> get nodes => _nodes;

  @override
  String toString() {
    return 'NodeCategory{name: $name, nodes: $nodes}';
  }
}

///节点
class Node extends BaseModel {
  late String _id; //ex “life”
  late String _name; //ex "生活"
  late int _totalNumberOfTopics; //主题总数
  late List<Topic> _topics;

  Node.fromHtml(Element html) : super.fromHtml(html);

  String get id => _id; //一些主题

  String get name => _name;

  int get totalNumberOfTopics => _totalNumberOfTopics;

  List<Topic> get topics => _topics;

  @override
  String toString() {
    return 'Node{id: $id, name: $name, totalNumberOfTopics: $totalNumberOfTopics, topics: $topics}';
  }
}
