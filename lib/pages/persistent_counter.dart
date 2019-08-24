import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath; 
  return File("$path/counter.txt");
}

Future<int> readCounter() async{
  try{
    final file = await _localFile;
    String counter = await file.readAsString();
    return int.parse(counter);
  }catch (e){
    return 0;
  }
}

Future<File> writeCounter(int counter) async {
  final file = await _localFile;

  return file.writeAsString("$counter");
}

class PersistenCounterPage extends StatefulWidget {
  @override
  PersistenCounterState createState() => PersistenCounterState();
}

class PersistenCounterState extends State<PersistenCounterPage>{
  int _counter;

  @override
  void initState() {
    super.initState();
    readCounter().then(
      (int value){
        setState(() {
          _counter = value; 
        });
      }
    );
  }

  @override  
  Widget build(BuildContext context){
    return Scaffold(
      body: Center( 
        child:
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton(
              child: Icon(Icons.add),
              onPressed: _incrementCounter,
              shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
            ),
            Text("$_counter")
          ],
        )  
      )
    );
  }

  _incrementCounter(){
    setState(() {
     _counter++; 
    });
    writeCounter(_counter);
  }
}