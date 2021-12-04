import 'package:v2fly/src/model/entity/user.dart';

import 'node.dart';

class Topic {
  final String id;
  final String title;
  final String content;
  final User? creator;
  final DateTime? createTime;
  final int numberOfHits; //点击数
  final List<Postscript> postscripts;
  final int totalNumberOfReplies;
  final DateTime? latestReplyTime;
  final List<Reply> replies;
  final Node? node;

  Topic(this.id, this.title,
      {this.content = "",
      this.creator,
      this.createTime,
      this.numberOfHits = -1,
      this.postscripts = const [],
      this.totalNumberOfReplies = -1,
      this.latestReplyTime,
      this.replies = const [],
      this.node});

  @override
  String toString() {
    return 'Topic{id: $id, title: $title, content: $content, creator: $creator, createTime: $createTime, numberOfHits: $numberOfHits, postscripts: $postscripts, totalNumberOfReplies: $totalNumberOfReplies, latestReplyTime: $latestReplyTime, replies: $replies, node: $node}';
  }
}

/// 附言
class Postscript {
  final int index;
  final DateTime createTime;
  final String content;

  Postscript(this.index, this.createTime, this.content);

  @override
  String toString() {
    return 'Postscript{index: $index, createTime: $createTime, content: $content}';
  }
}

/// 回复
class Reply {
  final String id;
  final User creator;
  final DateTime createTime;

  ///感谢数
  final int numberOfThanks;
  final String content;

  ///发送渠道
  final String via;

  Reply(this.id, this.creator, this.createTime, this.numberOfThanks,
      this.content, this.via);

  @override
  String toString() {
    return 'Reply{id: $id, creator: $creator, createTime: $createTime, numberOfThanks: $numberOfThanks, content: $content, via: $via}';
  }
}

