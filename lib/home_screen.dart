import 'dart:convert';

import 'package:api_project/Models/posts_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PostsModel> postList = [];

  Future<List<PostsModel>> getPostApi() async {
    final response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));

    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      postList.clear();
      for (Map i in data) {
        postList.add(PostsModel.fromJson(i));
      }
      return postList;
    } else {
      return postList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Api Course'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getPostApi(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Text('Loading');
                } else {
                  return ListView.builder(
                      itemCount: postList.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Title', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                                Text(postList[index].title.toString()),
                                SizedBox(height: 5,),
                                Text('Description', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                                Text(postList[index].body.toString()),
                                SizedBox(height: 5,),
                              ],
                            ),
                          ),
                        );
                      });
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
