import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //TODO: 使用Provider提供UserInfo及Counter業務邏輯
    return MultiProvider(
      providers: [
        //基本的Provider容器
        Provider<UserInfo>(create: (_) => UserInfo()),
        //帶有更新通知的Provider容器
        ChangeNotifierProvider<Counter>(create: (_) => Counter())
      ],
      child: MaterialApp(
        title: 'Flutter Demo about Provider',
        theme: ThemeData.dark(),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  //TODO: [Method1]使用context.read<T>讀取使用者姓名
                  'Name: ${context.read<UserInfo>().name}',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                Text(
                  //TODO: [Method２]使用Provider.of<T>(context)讀取使用者年齡
                  'Age: ${Provider.of<UserInfo>(context).age}',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ],
            ),
            //TODO: [Method3] 使用Consumer<T>監聽計數器count值
            Consumer<Counter>(
              builder: (context, model, child) {
                return Text(
                  model.count.toString(),
                  style: Theme.of(context).textTheme.headline6,
                );
              },
            ),
            //TODO: [Method4] 使用context.watch<T>監聽計數器count值
            Text('${context.watch<Counter>().count}',
                style: Theme.of(context).textTheme.headline6),
            //TODO: [Method5] 使用context.select<T>監聽計數器count值
            Text(
              '${context.select<Counter, int>((counter) => counter.count)}',
              style: Theme.of(context).textTheme.headline6,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          //TODO: 呼叫計數器業務 "increment()" method(PS. context.read<T> or Provider.of(context ,listen: false)
          Provider.of<Counter>(context, listen: false).increment();
        },
      ),
    );
  }
}

//使用者資訊
class UserInfo {
  String name = 'James';
  int age = 35;
}

//計數器業務邏輯
class Counter extends ChangeNotifier {
  int _count = 0;

  int get count => _count;
  Timer _timer;

  Counter() {
    _timer = Timer.periodic(Duration(milliseconds: 1000), (timer) {
      increment();
    });
  }

  void increment() {
    _count++;
    print(count);
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }
}
