import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:v2fly/generated/l10n.dart';
import 'package:v2fly/src/model/topic.dart';
import 'package:v2fly/src/page/typedef.dart';
import 'package:v2fly/src/route.dart';
import 'package:v2fly/src/view/simple_topic.dart';

import 'logic.dart';

class FirstPage extends StatelessWidget {
  FirstPage({Key? key}) : super(key: key);

  final logic = Get.find<FirstLogic>();
  final state = Get.find<FirstLogic>().state;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FirstLogic>(builder: (logic) {
      if (state.selectedTabIndex < 0) {
        return Container(
          alignment: Alignment.center,
          child: const SizedBox(
              width: 56, height: 56, child: CircularProgressIndicator()),
        );
      }
      return const _FirstPageContent();
    });
  }
}

class _FirstPageContent extends StatefulWidget {
  const _FirstPageContent({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FirstPageContentState();
}

class _FirstPageContentState extends State<_FirstPageContent>
    with SingleTickerProviderStateMixin {
  final logic = Get.find<FirstLogic>();
  final state = Get.find<FirstLogic>().state;

  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(
        initialIndex: state.selectedTabIndex,
        length: state.tabs.length,
        vsync: this);

    _tabController.addListener(() {
      logic.switchTab(_tabController.index);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FirstLogic>(builder: (logic) {
      return Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).firstPage),
          bottom: _createTopBar(context),
        ),
        body: TabBarView(
          controller: _tabController,
          children: state.tabs.asMap().keys.map((index) {
            final homeTab = state.tabs[index];
            final topics = state.idTopics[homeTab.id] ?? [];
            return _TopicListView(topics, (topic) {
              Get.toNamed(RouteConfig.topic,
                  arguments: {RouteConfig.keyTopic: topic});
            }, () {
              return logic.refreshTab(index);
            }, key: PageStorageKey(index.toString()));
          }).toList(),
        ),
      );
    });
  }

  PreferredSizeWidget _createTopBar(BuildContext context) {
    return TabBar(
      isScrollable: true,
      controller: _tabController,
      tabs: state.tabs
          .map((e) => Tab(
                text: e.name,
              ))
          .toList(),
      onTap: (index) {
        logic.switchTab(index);
      },
    );
  }
}

class _TopicListView extends StatelessWidget {
  final List<Topic> topics;
  final TopicCallback onTapItem;
  final RefreshCallback onRefreshList;

  const _TopicListView(this.topics, this.onTapItem, this.onRefreshList,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (topics.isEmpty) {
      return Container(
        width: 56,
        height: 56,
        alignment: Alignment.center,
        child: const CircularProgressIndicator(),
      );
    }
    return RefreshIndicator(
      onRefresh: onRefreshList,
      child: ListView.builder(
        itemCount: topics.length,
        itemBuilder: (context, index) {
          final topic = topics[index];
          return SimpleTopicView(topic, onTapTopic: onTapItem);
        },
      ),
    );
  }
}
