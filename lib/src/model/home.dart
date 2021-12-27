import 'package:html/dom.dart';
import 'package:v2fly/src/model/html.dart';
import 'package:v2fly/src/model/node.dart';
import 'package:v2fly/src/model/topic.dart';

class HomeData extends BaseModel {
  //#Tabs
  final List<HomeTab> _tabs = [];
  //#Main.box > .cell.item
  final List<Topic> _topics = [];
  //#Main.box:last > table
  final List<NodeCategory> _nodeCategories = [];

  HomeData.fromHtml(Element html) : super.fromHtml(html){

  }

  List<HomeTab> get tabs => _tabs;

  List<Topic> get topics => _topics;

  List<NodeCategory> get nodeCategories => _nodeCategories;

  @override
  String toString() {
    return 'HomeData{tabs: $tabs, topics: $topics, nodeCategories: $_nodeCategories}';
  }
}

class HomeTab extends BaseModel {
  late String _id;
  late String _name;
  late bool _selected;

  HomeTab.fromHtml(Element html)
      : super.fromHtml(html) {

  }


  String get id => _id;

  String get name => _name;

  bool get selected => _selected;

  @override
  String toString() {
    return 'HomeTab{id: $id, name: $name, selected: $selected}';
  }
}
