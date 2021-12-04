import 'package:flutter/material.dart';
import 'package:v2fly/src/app.dart';
import 'package:v2fly/src/common/path.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initApp();
  runApp(const MyApp());
}

Future initApp() async {
  await AppPath.instance.init();
}
