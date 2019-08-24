import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

Future<Post> fetchPost() async {
  final response = await http.get(
    'https://jsonplaceholder.typicode.com/posts/1',
    headers: {HttpHeaders.authorizationHeader: "Basic your_api_token_here"} //for authetication requests
    );
  if(response.statusCode == 200){
    return Post.fromJson(json.decode(response.body));
  }else{
    throw Exception('Failed to load post');
  }
}

class HttpRequestPage extends StatelessWidget {
    final Future<Post> post;
    HttpRequestPage({this.post});

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Center(
          child: FutureBuilder<Post>(
            future: post,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data.title);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          )
        )
      );
  }
}

class Post  {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({this.userId, this.id, this.body, this.title});

  factory Post.fromJson(Map<String, dynamic> json){
    return Post(
      title: json["title"],
      body: json["body"],
      id: json["id"],
      userId: json["userId"]
    );
  }
}

