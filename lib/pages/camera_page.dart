import 'package:flutter/material.dart';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class CameraPage extends StatefulWidget {
  @override
  CameraState createState() => CameraState();
}

class CameraState extends State<CameraPage>{
  CameraDescription camera;
  CameraController _controller;

 Future<CameraDescription> get getFirstCamera async {
    return (await availableCameras())[0];
 }

 @override
  void initState() {
    super.initState();
    getFirstCamera.then(
      (value){
        setState(() {
         camera = value; 
        });
        _controller = CameraController(camera, ResolutionPreset.medium);
        _controller.initialize();
      }
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }


  @override  
  Widget build(BuildContext context){
    return Scaffold(
      body: Center( 
          child: AspectRatio(
        aspectRatio:
        _controller.value.aspectRatio,
        child: CameraPreview(_controller))
      ),
       floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),
        // Provide an onPressed callback.
        onPressed: () async {
          // Take the Picture in a try / catch block. If anything goes wrong,
          // catch the error.
          try {
            // pattern package.
            final path = join(
              (await getTemporaryDirectory()).path,
              '${DateTime.now()}.png',
            );

            // Attempt to take a picture and log where it's been saved.
            await _controller.takePicture(path);

            // If the picture was taken, display it on a new screen.
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DisplayPictureScreen(imagePath: path),
              ),
            );
          } catch (e) {
            // If an error occurs, log the error to the console.
            print(e);
          }
        },
       )
    );
  }
}

class DisplayPictureScreen extends StatelessWidget{
  final String imagePath;
  DisplayPictureScreen({this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center( 
        child: Image.file(File(imagePath))
      )
    );
  }
}