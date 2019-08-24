import 'package:flutter/material.dart';

class DismissiblePage extends StatefulWidget {
  @override
  DismissiblePageState createState() => DismissiblePageState();
}

class DismissiblePageState extends State<DismissiblePage>{
  @override  
  Widget build(BuildContext context){
    return Scaffold(
      body: Center( 
        child: DismissibleList())
    );
  }
}


class DismissibleList extends StatefulWidget {
  @override
  DismissibleListState createState() => DismissibleListState();
}

class DismissibleListState extends State<DismissibleList>{
  final items = List.generate(100, (index) => "Item $index" );
  @override  
  Widget build(BuildContext context){
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index){
        final item = items[index];
        return Dismissible(
          key: Key(item),
            onDismissed: (direction) {
                // Remove the item from the data source.
                setState(() {
                  items.removeAt(index);
                });

                // Then show a snackbar.
                Scaffold.of(context)
                    .showSnackBar(SnackBar(content: Text("$item dismissed")));
              },
              // Show a red background as the item is swiped away.
              background: Container(color: Colors.red),
              child: ListTile(title: Text('$item')),
            );
          }
        );
      }
}