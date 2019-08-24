import 'package:flutter/material.dart';

class MixedListPage extends StatelessWidget{
  final List<ListItem> items = List.generate(100, (index) {
               return index % 6 == 0 ? 
                HeadingItem('Heading: $index')
               :
                MessageItem('Sender: $index', 'message: $index');
              });
  @override
  Widget build(context){
    return Scaffold(
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, i){
        final item = items[i];
        if(items[i] is HeadingItem){
          return ListTile(
            title: Text(
              (item as HeadingItem).heading, 
              style: Theme.of(context).textTheme.headline),
          );
        } else if(item is MessageItem){
          return ListTile(
            title: Text(item.sender),
            subtitle: Text(item.body),
          );
        }
      })
    
    );
  }
}

abstract class ListItem {}

class HeadingItem implements ListItem {
  final String heading;

  HeadingItem(this.heading);
}

class MessageItem implements ListItem {
  final String sender;
  final String body;

  MessageItem(this.sender, this.body);
}