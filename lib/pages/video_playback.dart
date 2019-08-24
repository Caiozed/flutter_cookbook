import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:custom_chewie/custom_chewie.dart';

class VideoPlaybackPage extends StatefulWidget {
  @override
  VideoPlaybackState createState() => VideoPlaybackState();
}

class VideoPlaybackState extends State<VideoPlaybackPage>{
  VideoPlayerController _controller = VideoPlayerController.network("https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4");
  Future<void> _video;

  @override
  void initState() {
    _video = _controller.initialize();
    super.initState();
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  @override  
  Widget build(BuildContext context){
    return Scaffold(
      body: Center( 
        child: FutureBuilder(
          future: _video,
          builder: (context, snapshot){
            if(snapshot.connectionState == ConnectionState.done){
              return Chewie(
                  _controller,
                  aspectRatio: 3 / 2,
                  autoPlay: true,
                  looping: true,
              // GestureDetector(
              //     onTap: _playPause,
              //     child:AspectRatio(
              //     aspectRatio: _controller.value.aspectRatio,
              //     child: VideoPlayer(_controller),
              //   )
              // );
              );
            }else{
              return Center(child: CircularProgressIndicator());
            }
          }
        )
      )
    );
  }

  _playPause(){
    if(_controller.value.isPlaying){
      _controller.pause();
    }else{
      _controller.play();
    }
  }
}