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
    return MaterialApp(
      title: 'Flutter Demo about Provider and Service',
      theme: ThemeData.dark(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Counter>(
      create: (_) => Counter(),
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            leading: TextButton(
                onPressed: () => Navigator.pop(context), child: Text('Back')),
            title: Text('Home Page'),
          ),
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //Consumer
                Consumer<Counter>(
                  builder: (context, model, child) {
                    return Text(
                      model.count.toString(),
                      style: Theme.of(context).textTheme.headline6,
                    );
                  },
                ),
                //context.watch
                Text('${context.watch<Counter>().count}',
                    style: Theme.of(context).textTheme.headline6),
                //context.select
                Text(
                  '${context.select<Counter, int>((counter) => counter.count)}',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: Text('+'),
            onPressed: () {
              //Provider.of
              Provider.of<Counter>(context, listen: false).increment();
              //context.read
              //context.read<Counter>().increment();
            },
          ),
        );
      },
    );
  }
}

class Counter extends ChangeNotifier {
  int _count = 0;

  int get count => _count;
  Timer _timer;

  Counter() {
    _timer = Timer.periodic(Duration(milliseconds: 2000), (timer) {
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
