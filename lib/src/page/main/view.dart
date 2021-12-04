import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:v2fly/generated/l10n.dart';
import 'package:v2fly/src/page/first/view.dart';
import 'package:v2fly/src/page/nodes/view.dart';

import 'logic.dart';

class MainPage extends StatefulWidget {
  const MainPage(this.title, {Key? key}) : super(key: key);

  final String title;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  final logic = Get.put(MainLogic());
  final state = Get.find<MainLogic>().state;

  int _selectedTabIndex = 0;

  void _onTapTab(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
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
