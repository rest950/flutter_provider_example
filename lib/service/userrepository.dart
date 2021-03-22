import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserRepository extends ChangeNotifier {
  //使用者姓名
  String userName = 'Andy';

  Timer _timer;

  //目前時間
  String currentTime = DateFormat('yy-MM-dd kk:mm:ss').format(DateTime.now());

  UserRepository() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      currentTime = DateFormat('yy-MM-dd kk:mm:ss').format(DateTime.now());
      notifyListeners();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }
}
