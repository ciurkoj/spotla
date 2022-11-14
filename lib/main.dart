import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotlas/home.dart';

import 'change notifiers/post_list_change_notifier.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PostListChangeNotifier>.value(
          value: PostListChangeNotifier()),],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFCFFFFFF),
          primarySwatch: Colors.blue,
        ),
        home: const Scaffold(body: Home()),
      ),
    );
  }
}
