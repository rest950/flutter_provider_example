import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/model/photo.dart';
import 'package:flutter_app/service/userrepository.dart';
import 'package:http/http.dart' as http;
import 'package:local_auth/local_auth.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class IndividualPhotoPage extends StatefulWidget {
  @override
  _IndividualPhotoPageState createState() => _IndividualPhotoPageState();
}

class _IndividualPhotoPageState extends State<IndividualPhotoPage>
    with SingleTickerProviderStateMixin {
  final auth = LocalAuthentication();
  double _scaleRadio = 0.8;
  bool selected = false;

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
              try {
                if (await auth.canCheckBiometrics) {
                  if (await auth.authenticate(
                      localizedReason: 'Please authenticate to share photo.',
                      biometricOnly: false)) {
                    await shareImage(photo);
                  }
                }
              } catch (e) {}
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
          AnimatedOpacity(
            opacity: selected ? 0 : 1,
            duration: Duration(milliseconds: 1500),
            curve: Curves.linear,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                photo.url,
              ),
            ),
          ),
          // //TODO: AnimatedSwitcher
          // AnimatedSwitcher(
          //   duration: Duration(milliseconds: 1000),
          //   child: selected
          //       ? Container(
          //           key: ValueKey(1),
          //           color: Colors.white,
          //           height: 100,
          //           width: 50,
          //         )
          //       : FlutterLogo(
          //           size: 20,
          //         ),
          //   switchInCurve: Curves.easeIn,
          //   switchOutCurve: Curves.easeIn,
          // ),
          // //TODO: TweenAnimationBuilder
          // TweenAnimationBuilder<double>(
          //     tween: Tween<double>(begin: 0, end: 2 * math.pi),
          //     duration: Duration(seconds: 2),
          //     curve: Curves.easeIn,
          //     builder: (__, angle, child) {
          //       return Transform.rotate(
          //         angle: angle,
          //         child: FlutterLogo(
          //           size: 100,
          //         ),
          //       );
          //     }),
          TextButton(
            onPressed: () {
              setState(() {
                selected = !selected;
                if (selected) {
                  _scaleRadio = 0.8;
                } else {
                  _scaleRadio = 0.3;
                }
              });
            },
            child: Text(
              'Animate',
              style: TextStyle(fontSize: 15, color: Colors.red),
            ),
          )
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
