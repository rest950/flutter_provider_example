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
                child:
                    Consumer<UserRepository>(builder: (context, model, child) {
                  return Text(model.currentTime);
                }))
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
        //TODO: Add Navigation Drawer
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                child: Image.network(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSbVg0JCFzD1T0R93AGYV_h2AiOWAlEJgCkew&usqp=CAU'),
              ),
              ListTile(
                title: Text('Home'),
                selected: true,
              ),
              ListTile(
                title: Text('PhotoGrid'),
                onTap: () => Navigator.popAndPushNamed(context, '/photoGrid'),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Text('Next'),
          onPressed: () => Navigator.pushNamed(context, '/photoGrid'),
        ),
      ),
    );
  }
}
