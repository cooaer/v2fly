import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:v2fly/generated/l10n.dart';
import 'package:v2fly/src/page/first/view.dart';
import 'package:v2fly/src/page/nodes/view.dart';

import 'logic.dart';

class MainPage extends StatefulWidget {
  static const tabFirst = "first";
  static const tabNodes = "nodes";

  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  final logic = Get.find<MainLogic>();
  final state = Get.find<MainLogic>().state;

  int _selectedTabIndex = 0;

  void _onTapTab(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  @override
  void initState() {
    _initSelectedTabIndex();
    super.initState();
  }

  void _initSelectedTabIndex() {
    final defaultTab = Get.parameters["tab"];
    switch (defaultTab) {
      case MainPage.tabNodes:
        _selectedTabIndex = 1;
        break;
      default:
        _selectedTabIndex = 0;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTabIndex,
        onTap: _onTapTab,
        items: [
          BottomNavigationBarItem(
              icon: const Icon(Icons.subject), label: S.of(context).firstPage),
          BottomNavigationBarItem(
              icon: const Icon(Icons.explore), label: S.of(context).nodes)
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (_selectedTabIndex == 0) {
      return FirstPage();
    } else {
      return NodesPage();
    }
  }
}
