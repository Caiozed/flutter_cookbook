import 'dart:math';
import 'package:flutter/material.dart';

class HorizontalListPage extends StatelessWidget{
  final List<Container> itens = List.generate(5, (context) {
                print(Random().nextInt(255));
               return Container( width: 160, color: Color.fromRGBO(Random().nextInt(255), Random().nextInt(255), Random().nextInt(255), 1));
              });
  @override
  Widget build(context){
    return Scaffold(
      body: 
      Center(
        child:
        Container(
          height: 200.0,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: itens
          )
        ),
      )
    );
  }
}