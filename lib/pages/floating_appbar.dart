import 'dart:math';
import 'package:flutter/material.dart';

class FloatingAppBarPage extends StatelessWidget{
  @override
  Widget build(context){
    return Scaffold(
      body: 
      CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text("My Floating app bar"),
            floating: true,
            flexibleSpace: Placeholder(),
            expandedHeight: 200,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, i) => ListTile(title: Text("item $i")),
              childCount: 100
            )
          )
        ]
      )
    );
  }
}