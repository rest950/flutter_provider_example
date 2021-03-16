import 'package:flutter/material.dart';
import 'package:flutter_app/service/userrepository.dart';
import 'package:flutter_app/viewmodel/homepage_viewmodel.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomePageViewModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('${context.read<UserRepository>().userName}\'s Album'),
          actions: [
            Align(
                alignment: Alignment.bottomRight,
                child: Text(context.read<UserRepository>().currentTime))
          ],
        ),
        body: Center(child: Consumer<HomePageViewModel>(
          builder: (context, viewModel, child) {
            //如有相片來源則顯示
            if (viewModel.imgSrc != null) {
              return Image.network(viewModel.imgSrc);
            }
            //否則回傳空
            return Container();
          },
        )),
        floatingActionButton: FloatingActionButton(
          child: Text('Next'),
          onPressed: () => Navigator.popAndPushNamed(context, '/photoGrid'),
        ),
      ),
    );
  }
}
