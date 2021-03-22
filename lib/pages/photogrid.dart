import 'package:flutter/material.dart';
import 'package:flutter_app/model/photo.dart';
import 'package:flutter_app/service/userrepository.dart';
import 'package:flutter_app/viewmodel/photogrid_viewmodel.dart';
import 'package:provider/provider.dart';

class PhotoGridPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureProvider<List<Photo>>(
      create: (context) => PhotoGridViewModel().fetchPhotos(),
      initialData: <Photo>[],
      child: Scaffold(
        appBar: AppBar(
          // leading: IconButton(
          //   icon: Icon(Icons.arrow_back),
          //   onPressed: () => Navigator.popAndPushNamed(context, '/home'),
          // ),
          title:
              Text('${context.read<UserRepository>().userName}\'s Photos Grid'),
          actions: [
            Align(
                alignment: Alignment.bottomRight,
                child:
                    Consumer<UserRepository>(builder: (context, model, child) {
                  return Text(model.currentTime);
                }))
          ],
        ),
        body: Consumer<List<Photo>>(
          builder: (context, photos, child) {
            return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: photos.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    child: Image.network(photos[index].thumbnailUrl),
                    onTap: () {
                      //TODO: 導覽至相片瀏覽頁並帶入此Photo Data Model
                      print('Photo on pressed: ' + photos[index].id.toString());
                      Navigator.pushNamed(context, '/individualPhoto',
                          arguments: photos[index]);
                    },
                  );
                });
          },
        ),
      ),
    );
  }
}
