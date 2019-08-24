import 'package:flutter/material.dart';

class TabsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        bottomNavigationBar: BottomAppBar(
          child: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.access_time, color: Theme.of(context).accentColor,)),
              Tab(icon: Icon(Icons.account_balance, color: Theme.of(context).accentColor)),
              Tab(icon: Icon(Icons.favorite, color: Theme.of(context).accentColor))
            ],
          ),
        ),
      body: TabBarView(
          children: [ 
            Icon(Icons.access_time),
            Icon(Icons.account_balance),
            Icon(Icons.favorite)
          ],
        ),
      ),
    );
  }
}