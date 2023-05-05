import 'dart:core';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'post.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({super.key});

  List<Post> posts = [];
  String link = "https://www.itiszuccante.edu.it/rss.xml?js=true";
  Future<http.Response> getPosts() {
    return http.get(Uri.parse(link));
  }

  @override
  Widget build(BuildContext context) {
    print(getPosts());
    Widget content = Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            /*1*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*2*/
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: const Text(
                    'Oeschinen Lake Campground',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  'Kandersteg, Switzerland',
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          /*3*/
          Icon(
            Icons.star,
            color: Colors.red[500],
          ),
          const Text('41'),
        ],
      ),
    );

    return MaterialApp(
      title: 'Flutter layout demo',
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Zuccante'),
        ),
        body: Column(
          children: [content],
        ),
      ),
    );
  }
}
