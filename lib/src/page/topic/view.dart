import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:v2fly/src/model/topic.dart';
import 'package:v2fly/src/page/topic/state.dart';
import 'package:v2fly/src/route.dart';
import 'package:v2fly/src/view/simple_topic.dart';

import 'logic.dart';

class TopicPage extends StatelessWidget {
  final Topic topic = Get.arguments[RouteConfig.keyTopic];

  TopicPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        _buildAppBar(context),
        _buildSimpleTopicView(context),
        _buildContentView(context),
        for (final postscript in topic.postscripts)
          _buildPostscriptItemViews(context, postscript),
        for (final reply in topic.replies) _buildReplyItemView(context, reply),
      ],
    );
  }

  Widget _buildAppBar(BuildContext context) {
    const titleStyle = TextStyle(fontSize: 16);

    return SliverAppBar(
      leading: BackButton(
        onPressed: () {
          Get.back();
        },
      ),
      title: Text(topic.title, style: titleStyle),
    );
  }

  Widget _buildSimpleTopicView(BuildContext context) {
    return SliverToBoxAdapter(
      child: SimpleTopicView(topic),
    );
  }

  Widget _buildContentView(BuildContext context) {
    return Container();
  }

  Widget _buildPostscriptItemViews(
      BuildContext context, Postscript postscript) {
    return Container();
  }

  Widget _buildReplyItemView(BuildContext context, Reply reply) {
    return Container();
  }
}

class _TopicPageBody extends StatelessWidget {
  final Topic _topic;
  final TopicLogic _logic = Get.find<TopicLogic>();
  final TopicState _state = Get.find<TopicLogic>().state;

  _TopicPageBody(this._topic, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SimpleTopicView(_topic),
      ],
    );
  }
}