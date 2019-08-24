import 'package:flutter/material.dart';

class SnackbarPage extends StatelessWidget {
   

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SnackbarWidget()
    );
  }
}

class SnackbarWidget extends StatelessWidget {
  final snackBar = SnackBar(
            content: Text('Yay! A SnackBar!'),
            action: SnackBarAction(
              label: 'Undo',
              onPressed: () {
                // Some code to undo the change.
              },
            ),
          );
          
  @override
  Widget build(BuildContext context) {
    return Center( 
        child: RaisedButton(
          child: Text("Show Snackbar!"),
          onPressed: (){
            Scaffold.of(context).showSnackBar(this.snackBar);
          },
        ),
      );
  }
}