import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:v2fly/src/common/extensions/list_extensions.dart';
import 'package:v2fly/src/common/network/http_maker.dart';
import 'package:v2fly/src/model/api/website_api.dart';

import 'state.dart';

class FirstLogic extends GetxController {
  final FirstState state = FirstState();
  final WebsiteApi api = WebsiteApi(doHttpMaker);
  final ScrollController scrollController = ScrollController();

  FirstLogic() {}

  @override
  void onInit() {
    loadHome();
    super.onInit();
  }

  Future<void> loadHome({String tabId = ""}) async {
    final homeData = await api.getHome(tabId);
    state.updateTabs(homeData.tabs);
    state.updateTopics(homeData.topics);
    update();
  }

  Future<void> refreshTab(int index) async {
    await _loadTab(index, true);
  }

  Future<void> switchTab(int index) async {
    await _loadTab(index, false);
  }

  Future<void> _loadTab(int index, bool force) async {
    if (!force && index == state.selectedTabIndex) {
      return;
    }
    state.selectedTabIndex = index;
    final tabId = state.tabs.get(index)?.id ?? "";
    if (!force && state.idTopics.containsKey(tabId)) {
      return;
    }

    await loadHome(tabId: tabId);
  }
}
