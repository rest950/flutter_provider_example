import 'dart:convert';

import 'package:flutter/material.dart';
//TODO: import http Package

void main() {
  runApp(MaterialApp(
    title: 'Example for json and api',
    home: PostsPage(),
  ));
}

class PostsPage extends StatefulWidget {
  @override
  _PostsPageState createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  //API位置
  static const String _apiAddress = 'jsonplaceholder.typicode.com';

  Future<List<Post>> getPosts() async {
    final apiUrl = Uri.https(_apiAddress, '/posts');
    //TODO: 使用HttpGet取得資料

    if (response.statusCode == 200) {
      //TODO: Decode Json to List<Post>

    }
    return <Post>[];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Example for json and api')),
      body: Center(
        child: FutureBuilder<List<Post>>(
          future: getPosts(), //回傳非同步值
          builder: (context, snapshot) {
            //載入成功
            if (snapshot.hasData) {
              final list = snapshot.data;
              return ListView.builder(
                  padding: EdgeInsets.all(8),
                  itemCount: list?.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Text('${list[index].id}'),
                      title: Text('${list[index].title}'),
                      subtitle: Text('${list[index].body}'),
                    );
                  });
            } else if (snapshot.hasError) {
              //發生錯誤
              return Text('Error!!!');
            } else {
              //載入中
              return Text('Loading...');
            }
          },
        ),
      ),
    );
  }
}

class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post(this.userId, this.id, this.title, this.body);

//TODO: Serializing JSON inside model classes

}
