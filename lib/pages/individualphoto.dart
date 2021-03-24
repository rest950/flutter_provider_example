import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/model/photo.dart';
import 'package:flutter_app/service/userrepository.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class IndividualPhotoPage extends StatefulWidget {
  @override
  _IndividualPhotoPageState createState() => _IndividualPhotoPageState();
}

class _IndividualPhotoPageState extends State<IndividualPhotoPage>
    with SingleTickerProviderStateMixin {
  double _scaleRadio = 0.8;

  @override
  Widget build(BuildContext context) {
    //TODO: 取得Photo Data Model
    final Photo photo = ModalRoute.of(context).settings.arguments;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
            '${context.read<UserRepository>().userName}\'s Photo ${photo.id}'),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () async {
              //TODO: 使用生物辨識
              try {} catch (e) {}
            },
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ListTile(
            title: Text('Title: ${photo.title}'),
            leading: Text('Id: ${photo.id}'),
          ),
          //TODO: AnimatedOpacity, AnimatedPadding, AnimatedContainer
          // //TODO: AnimatedSwitcher
          // //TODO: TweenAnimationBuilder
        ],
      ),
    );
  }

  //分享圖片的Function
  Future<void> shareImage(Photo photo) async {
    final response = await http.get(Uri.parse(photo.url));
    final tempDir = await getTemporaryDirectory();
    final file = await File('${tempDir.path}/${photo.id}.png')
        .writeAsBytes(response.bodyBytes);
    Share.shareFiles([file.path],
        subject: 'Share the photo with you!',
        text: 'Share the photo with you!');
  }
}
