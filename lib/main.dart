import 'package:demo_error_handling/post_change_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Demo Error Handling',
        home: ChangeNotifierProvider(
            create: (_) => PostChangeNotifier(), child: Home()));
  }
}
