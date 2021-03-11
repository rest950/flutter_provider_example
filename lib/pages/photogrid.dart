import 'package:flutter/material.dart';
import 'package:flutter_app/model/photo.dart';
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
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.popAndPushNamed(context, '/home'),
          ),
          title: Text('Photos Grid'),
        ),
        body: Consumer<List<Photo>>(
          builder: (context, photos, child) {
            return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: photos.length,
                itemBuilder: (context, index) {
                  return Image.network(photos[index].thumbnailUrl);
                });
          },
        ),
      ),
    );
  }
}
