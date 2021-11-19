import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:v2fly/generated/l10n.dart';

import 'logic.dart';

class MainPage extends StatefulWidget {
  const MainPage(this.title, {Key? key}) : super(key: key);

  final String title;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final logic = Get.put(MainLogic());
  final state = Get.find<MainLogic>().state;

  int _selectedTabIndex = 0;

  void _onTapTab(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have tapped index:',
            ),
            Text(
              '$_selectedTabIndex',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
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
}
