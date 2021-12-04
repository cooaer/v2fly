import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:v2fly/generated/l10n.dart';
import 'package:v2fly/src/common/date.dart';
import 'package:v2fly/src/model/entity/topic.dart';
import 'package:v2fly/src/res/colors.dart';

import 'logic.dart';

class FirstPage extends StatelessWidget {
  FirstPage({Key? key}) : super(key: key);

  final logic = Get.put(FirstLogic());
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
  final logic = Get.put(FirstLogic());
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
            return _TopicListView(topics, (topic) {}, () {
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
  final void Function(Topic) onTapItem;
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
            return InkWell(
                onTap: () {
                  onTapItem(topic);
                },
                child: _TopicItem(topic));
          }),
    );
  }
}

class _TopicItem extends StatelessWidget {
  final Topic topic;

  const _TopicItem(this.topic, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const titleStyle = TextStyle(
      color: AppColors.black85,
      fontSize: 15,
      fontWeight: FontWeight.normal,
      height: 1.6,
    );

    const subtitleStyle = TextStyle(color: AppColors.black45, fontSize: 13);

    const numberStyle = TextStyle(
        color: AppColors.white100, fontWeight: FontWeight.bold, fontSize: 13);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 12,
          ),
          Text.rich(
            TextSpan(
              children: [
                WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 2),
                      decoration: const BoxDecoration(
                          color: AppColors.black5,
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Text(
                        topic.node?.name ?? "",
                        style: const TextStyle(color: AppColors.black45),
                      ),
                    )),
                const WidgetSpan(
                    child: SizedBox(
                  width: 5,
                )),
                TextSpan(text: topic.title, style: titleStyle),
              ],
            ),
            textAlign: TextAlign.start,
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(18)),
                child: CachedNetworkImage(
                    width: 24,
                    height: 24,
                    imageUrl: topic.creator?.avatar ?? ""),
              ),
              const SizedBox(
                width: 6,
              ),
              Text(topic.creator?.name ?? "", style: subtitleStyle),
              if (topic.latestReplyTime != null)
                const Text(
                  "  •  ",
                  style: subtitleStyle,
                ),
              if (topic.latestReplyTime != null)
                Text(
                  dateTimeToDisplay(topic.latestReplyTime!),
                  // topic.latestReplyTime.toString(),
                  style: subtitleStyle,
                ),
              const Spacer(),
              Container(
                  height: 18,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: const BoxDecoration(
                      color: AppColors.black20,
                      borderRadius: BorderRadius.all(Radius.circular(9))),
                  child: Text(
                    topic.totalNumberOfReplies.toString(),
                    style: numberStyle,
                  ))
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          const Divider(
            height: 1,
          )
        ],
      ),
    );
  }
}
