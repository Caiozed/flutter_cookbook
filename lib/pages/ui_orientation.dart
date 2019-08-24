import 'package:flutter/material.dart';

class UIOrientationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center (
        child: OrientationBuilder(
          builder: (context, orientation) {
            return GridView.count(
              // Create a grid with 2 columns in portrait mode,
              // or 3 columns in landscape mode.
              crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
              children: List.generate(100, (index) {
                return Center ( child:Text('Item $index',
                  style: Theme.of(context).textTheme.headline)
                );
              }),
            );
          },
        ),
      ),
    );
  }
}