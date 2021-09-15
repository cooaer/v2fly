import 'package:flutter/material.dart';
import 'package:v2fly/generated/l10n.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
