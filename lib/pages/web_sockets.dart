import 'package:web_socket_channel/io.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';


class WebSocketsPage extends StatefulWidget{
  @override
  WebSocketsState createState() => WebSocketsState();
}

class WebSocketsState extends State<WebSocketsPage>{
  TextEditingController _controller = TextEditingController();
  final WebSocketChannel channel = IOWebSocketChannel.connect('ws://echo.websocket.org');

  @override
  Widget build(context){
    return Scaffold(
      body: 
      Center(
        child: 
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
                Form(
                  child: TextFormField(
                    controller: _controller ,
                    decoration: InputDecoration(labelText: 'Send a message'),
                  ),
                ),
              StreamBuilder(
                stream: channel.stream,
                builder: (context, snapshot) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24.0),
                    child: Text(snapshot.hasData ? '${snapshot.data}' : ''),
                  );
                },
            )
          ])
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendMessage,
        tooltip: 'Send message',
        child: Icon(Icons.send),
      ), 
    );
  }

  _sendMessage () {
    channel.sink.add(_controller.text);
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }
}