import 'package:flutter/material.dart';

class DataListPage extends StatelessWidget {
    final List<String> items = List.generate(100, (i) => "Item $i");
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, i) {
          return ListTile(
            title: Text(items[i]),
            onTap: () { 
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_){
                    return DataItem(items[i]);
                  }
                )
              );
            }
          );
        })
      );
  }
}

class DataItem extends StatelessWidget {
    final String item;
    DataItem(this.item);

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text(item),
        ),
        body: Center(
          child: Text(item),
        ),
      );
    }
}

