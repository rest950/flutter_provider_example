import 'package:flutter/material.dart';
import 'package:flutter_app/viewmodel/homepage_viewmodel.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomePageViewModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Example'),
        ),
        body: Center(child: Consumer<HomePageViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.imgSrc != null) {
              return Image.network(viewModel.imgSrc);
            }
            return Container();
          },
        )),
        floatingActionButton: FloatingActionButton(
          child: Text('+'),
          onPressed: () => Navigator.popAndPushNamed(context, '/photoGrid'),
        ),
      ),
    );
  }
}
