import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app/model/photo.dart';
import 'package:flutter_app/service/apiservice.dart';

class HomePageViewModel extends ChangeNotifier {
  String imgSrc;
  Timer _timer;
  Random _random;

  int _index = 0;

  int get index => _index;

  set index(newValue) {
    _index = newValue;
    notifyListeners();
  }

  HomePageViewModel() {
    _random = Random();
    _timer = Timer.periodic(Duration(seconds: 5), (timer) async {
      imgSrc = await _getRandomImg();
      notifyListeners();
    });
  }

  Future<String> _getRandomImg() async {
    try {
      final response = await ApiService().fetchPhoto(_random.nextInt(5000) + 1);
      if (response.statusCode == 200) {
        final parsed = jsonDecode(response.body) as Map<String, dynamic>;
        final photo = Photo.fromJson(parsed);
        print('${photo.url} : ${DateTime.now()}');
        return photo.url;
      }
      return null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }
}
