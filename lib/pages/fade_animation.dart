import 'package:flutter/material.dart';

class FadeAnimationPage extends StatefulWidget {
  @override
  FadeAnimationState createState() => FadeAnimationState();
}

class FadeAnimationState extends State<FadeAnimationPage>{
  bool _visible = true;

  @override  
  Widget build(BuildContext context){
    return Scaffold(
      body: Center( 
          child: AnimatedOpacity(
          duration: Duration(milliseconds: 500), 
          opacity: _visible ? 1 : 0,
          child: Container(
            width: 200.0,
            height: 200.0,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(8)
            ),
          )
        )
      ), 
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Call setState. This tells Flutter to rebuild the
          // UI with the changes.
          setState(() {
            _visible = !_visible;
          });
        },
        tooltip: 'Toggle Opacity',
        child: Icon(Icons.flip),
      ),
    );
  }
}