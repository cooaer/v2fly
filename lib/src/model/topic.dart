import 'package:html/dom.dart';
import 'package:v2fly/src/model/html.dart';
import 'package:v2fly/src/model/node.dart' as v2ex;
import 'package:v2fly/src/model/user.dart';

class Topic extends BaseModel {
  late String _id;
  late String _title;
  late String _content;
  User? _creator;
  DateTime? _createTime;
  late int _numberOfHits; //点击数
  final List<Postscript> _postscripts = [];
  late int _totalNumberOfReplies;
  DateTime? _latestReplyTime;
  final List<Reply> _replies = [];
  v2ex.Node? _node;

  Topic.fromHtml(Element html) : super.fromHtml(html) {}

  String get id => _id;

  String get title => _title;

  String get content => _content;

  User? get creator => _creator;

  DateTime? get createTime => _createTime;

  int get numberOfHits => _numberOfHits;

  List<Postscript> get postscripts => _postscripts;

  int get totalNumberOfReplies => _totalNumberOfReplies;

  DateTime? get latestReplyTime => _latestReplyTime;

  List<Reply> get replies => _replies;

  v2ex.Node? get node => _node;

  @override
  String toString() {
    return 'Topic{id: $id, title: $title, content: $content, creator: $creator, createTime: $createTime, numberOfHits: $numberOfHits, postscripts: $postscripts, totalNumberOfReplies: $totalNumberOfReplies, latestReplyTime: $latestReplyTime, replies: $replies, node: $node}';
  }
}

/// 附言
class Postscript extends BaseModel {
  DateTime? _createTime;
  late String _content;

  Postscript.fromHtml(Element html) : super.fromHtml(html) {}

  DateTime? get createTime => _createTime;

  String get content => _content;

  @override
  String toString() {
    return 'Postscript{createTime: $createTime, content: $content}';
  }
}

/// 回复
class Reply extends BaseModel {
  late String _id;
  late User _creator;
  late DateTime _createTime;

  ///感谢数
  late int _numberOfThanks;
  late String _content;

  ///发送渠道
  late String _via;

  Reply.fromHtml(Element html) : super.fromHtml(html);

  String get id => _id;

  User get creator => _creator;

  DateTime get createTime => _createTime;

  int get numberOfThanks => _numberOfThanks;

  String get content => _content;

  String get via => _via;

  @override
  String toString() {
    return 'Reply{id: $id, creator: $creator, createTime: $createTime, numberOfThanks: $numberOfThanks, content: $content, via: $via}';
  }
}
