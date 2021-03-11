import 'package:flutter/material.dart';
import 'package:flutter_app/pages/homepage.dart';
import 'package:flutter_app/pages/photogrid.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo for Provider implement MVVM',
      theme: ThemeData.dark(),
      initialRoute: '/home',
      routes: {
        '/home': (context) => HomePage(),
        '/photoGrid': (context) => PhotoGridPage(),
      },
    );
  }
}
