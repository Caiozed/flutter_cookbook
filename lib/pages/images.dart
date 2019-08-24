import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ImagesPage extends StatelessWidget{
  @override
  Widget build(context){
    return Scaffold(
      body: 
        Center(
          child: CachedNetworkImage(
            placeholder: (context, url) => CircularProgressIndicator(),
            imageUrl: 'https://picsum.photos/250?image=9',
          ),
        ),
    );
  }
}