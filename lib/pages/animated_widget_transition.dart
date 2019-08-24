import 'package:flutter/material.dart';

Hero heroImage =  Hero(
          tag: "image",
          child: Image.network('https://picsum.photos/250?image=9'),
        );

class WidgetTransitionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String myTitleBar = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(title: Text(myTitleBar)),
      body: Center (
        child: 
        GestureDetector(
          child: heroImage,
          onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
            return ImagePage();
          }));
        })
      ),
    );
  }
}

class ImagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center (
        child: GestureDetector(
          child: heroImage,
          onTap: () { Navigator.pop(context); })
      )
    );
  }
}