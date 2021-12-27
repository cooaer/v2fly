
import 'package:v2fly/src/model/topic.dart';

class TopicState {
  int _page = 1;

  late String _topicId;
  late Topic _topic;
  final List<Reply> _replies = [];

  TopicState();

  String get topicId => _topic.id;
  Topic? get topic => _topic;
  List<Reply>? get replies => _replies;

  int nextPage() {
    return _page + 1;
  }

  void updateTopic(Topic newTopic) {
    _topicId = newTopic.id;
    _topic = newTopic;
    _replies.addAll(newTopic.replies);
  }

  void increasePage(){
    _page ++;
  }
}
