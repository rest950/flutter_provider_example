import 'package:intl/intl.dart';

class UserRepository {
  //使用者姓名
  String userName = 'Andy';

  //目前時間
  String currentTime = DateFormat('yy-MM-dd kk:mm:ss').format(DateTime.now());
}
