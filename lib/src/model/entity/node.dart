import 'package:v2fly/src/model/entity/topic.dart';

///节点类型
class NodeCategory {
  final String name;
  final List<Node> nodes;

  NodeCategory(this.name, this.nodes) {}

  @override
  String toString() {
    return 'NodeCategory{name: $name, nodes: $nodes}';
  }
}

///节点
class Node {
  final String id; //ex “life”
  final String name; //ex "生活"
  final int totalNumberOfTopics; //主题总数
  final List<Topic> topics; //一些主题

  Node(this.id, this.name,
      {this.totalNumberOfTopics = 0, this.topics = const []});

  @override
  String toString() {
    return 'Node{id: $id, name: $name, totalNumberOfTopics: $totalNumberOfTopics, topics: $topics}';
  }
}
