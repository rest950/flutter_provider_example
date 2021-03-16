import 'package:flutter/material.dart';
import 'package:flutter_app/pages/homepage.dart';
import 'package:flutter_app/pages/photogrid.dart';
import 'package:flutter_app/service/userrepository.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider<UserRepository>(
      create: (_) => UserRepository(), //注入使用者資料
      child: MaterialApp(
        title: 'Flutter Demo for Provider implement MVVM',
        theme: ThemeData.dark(),
        initialRoute: '/home', //初始路由設定
        routes: {
          //路由設定
          '/home': (context) => HomePage(),
          '/photoGrid': (context) => PhotoGridPage(),
        },
      ),
    );
  }
}
