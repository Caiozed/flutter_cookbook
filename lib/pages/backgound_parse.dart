import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<Photo>> fetchPhotos() async {
  final response = await http.get('https://jsonplaceholder.typicode.com/photos');
  if(response.statusCode == 200){
    return compute(parsePhotos, response.body);
  }else{
    throw Exception('Failed to load photos');
  }
}

List<Photo> parsePhotos(String jsonString) {
  final parsed = json.decode(jsonString).cast<Map<String, dynamic>>();
  return parsed.map<Photo>((photo) => Photo.fromJson(photo)).toList();
}

class BackgoundParsePage extends StatelessWidget {
    final Future<List<Photo>> photos;
    BackgoundParsePage({Key key, this.photos});

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Center(
          child: FutureBuilder<List<Photo>>(
            future: photos,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return PhotosList(photos: snapshot.data);
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

class PhotosList extends StatelessWidget {
  final List<Photo> photos;

  PhotosList({this.photos});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      scrollDirection: Axis.horizontal,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
      ),
      itemCount: photos.length,
      itemBuilder: (context, index) {
        return Image.network(photos[index].thumbnailUrl);
      }
    );
  }
}

class Photo {
  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  Photo({this.albumId, this.id, this.title, this.url, this.thumbnailUrl});

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      albumId: json['albumId'] as int,
      id: json['id'] as int,
      title: json['title'] as String,
      url: json['url'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
    );
  }
}

