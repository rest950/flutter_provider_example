import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_app/model/photo.dart';
import 'package:flutter_app/service/apiservice.dart';

List<Photo> parsedPhotos(String responseBody) {
  final parsed = jsonDecode(responseBody) as List<dynamic>;
  return parsed.map((e) => Photo.fromJson(e)).toList();
}

class PhotoGridViewModel {
  PhotoGridViewModel();

  Future<List<Photo>> fetchPhotos() async {
    try {
      final response = await ApiService().fetchPhotos();
      if (response.statusCode == 200) {
        //return parsedPhotos(response.body);
        return await compute(parsedPhotos, response.body);
      }
      return <Photo>[];
    } catch (e) {
      print(e.toString());
      return <Photo>[];
    }
  }
}
