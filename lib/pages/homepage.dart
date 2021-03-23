import 'package:flutter/material.dart';
import 'package:flutter_app/pages/photogrid.dart';
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
        body: Consumer<HomePageViewModel>(
          builder: (_, viewModel, child) {
            return IndexedStack(
              index: viewModel.index,
              children: [
                RandomPhotoPage(),
                PhotoGridPage(),
              ],
            );
          },
        ),
        //TODO: Add Navigation Drawer
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                child: Image.network(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSbVg0JCFzD1T0R93AGYV_h2AiOWAlEJgCkew&usqp=CAU'),
              ),
              Consumer<HomePageViewModel>(
                builder: (_, viewModel, child) {
                  return ListTile(
                    leading: Icon(Icons.home),
                    title: Text('Home'),
                    selected: viewModel.index == 0,
                    onTap: () => viewModel.index = 0,
                  );
                },
              ),
              Consumer<HomePageViewModel>(
                builder: (_, viewModel, child) {
                  return ListTile(
                    leading: Icon(Icons.photo),
                    title: Text('PhotoGrid'),
                    selected: viewModel.index == 1,
                    onTap: () => viewModel.index = 1,
                  );
                },
              )
            ],
          ),
        ),
        bottomNavigationBar: Consumer<HomePageViewModel>(
          builder: (_, viewModel, child) {
            return BottomNavigationBar(
              currentIndex: viewModel.index,
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.photo), label: 'PhotoGrid'),
              ],
              onTap: (newIndex) => viewModel.index = newIndex,
            );
          },
        ),
      ),
    );
  }
}

class RandomPhotoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Consumer<HomePageViewModel>(
      builder: (context, viewModel, child) {
        //如有相片來源則顯示
        if (viewModel.imgSrc != null) {
          return Image.network(viewModel.imgSrc);
        }
        //否則回傳空
        return Container();
      },
    ));
  }
}
