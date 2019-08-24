import 'package:flutter/material.dart';


class AsyncPage extends StatelessWidget {
    
    @override
    Widget build(BuildContext context) {
      return Scaffold(
          body: Center (
            child: AsyncButton()
        ),
      );
    }
}

class AsyncButton extends StatelessWidget {
    
    @override
    Widget build(BuildContext context) {
      return RaisedButton(
        child: Text("Press Me!"),
        onPressed: () {_navigateAndDisplaySelection(context);}
      );
    }

    _navigateAndDisplaySelection(BuildContext context) async {
      // Navigator.push returns a Future that completes after calling
      // Navigator.pop on the Selection Screen.
      final result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => YesNoPage()),
      );
      Scaffold.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text("You selected $result")));
  }
}

class YesNoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center (
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             RaisedButton(
              child: Text("Yes!"),
              onPressed: () { 
                Navigator.pop(context, "Yes");
            }),
            RaisedButton(
              child: Text("No!"),
              onPressed: () { 
                Navigator.pop(context, "No");
            }),
          ],
        )
      ),
    );
  }
}

