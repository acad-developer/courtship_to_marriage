import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
// import 'package:lecle_yoyo_player/lecle_yoyo_player.dart';

class CourseVideo extends StatefulWidget {
  const CourseVideo({super.key});

  @override
  State<CourseVideo> createState() => _CourseVideoState();
}

class _CourseVideoState extends State<CourseVideo> {
  static const apikey = "80be8c9c-fa57-40c6-8d42-89f4f92693b6";
  static const video_id = "699f7e71-1b79-4495-b0a5-902d3cb8fded";

  bool fullscreen = false;
  bool getVideoCheck = true;
  String videolink =
      "https://iframe.mediadelivery.net/embed/165554/699f7e71-1b79-4495-b0a5-902d3cb8fded?token=4fb5f477746b22f8c8bffc5ffad845f73e88a177892a5298823cf44f33ae89b5&expires=1729270222";

  getVideo() {
    var date = new DateTime(2021, 1, 29);
    var newdate = DateTime(date.year + 1, date.month, date.day);
    print(newdate);
    var expiry = "1729270222";
    var key = utf8.encode(apikey + video_id + expiry);
    print(key);

    var digest = sha256.convert(key);
    print(digest);
    var link =
        "https://iframe.mediadelivery.net/embed/165554/${video_id}?token=${digest}&expires=${expiry}";
    print(link);
    setState(() {
      getVideoCheck = true;
      videolink = link;
    });
  }

  late VideoPlayerController controller;
  
  @override
  void initState() {
    super.initState();
    getVideo();
    controller = VideoPlayerController.networkUrl(Uri.parse(videolink))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {
          controller.play();
        });
      });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text("Video Test"),
          centerTitle: true,
          actions: [
            ElevatedButton(child: Text("Play Video"), onPressed: getVideo)
          ],
        ),
        body: Padding(
          padding:
              fullscreen ? EdgeInsets.zero : const EdgeInsets.only(top: 32.0),
              child:  AspectRatio(
                  aspectRatio: controller.value.aspectRatio,
                  child: VideoPlayer(controller),
                ),
          // child: YoYoPlayer(
          //   aspectRatio: 16 / 9,
          //   url: videolink,
          //   allowCacheFile: true,
          //   onCacheFileFailed: (error) {
          //     print('Cache file error ::: $error');
          //   },
          //   autoPlayVideoAfterInit: false,
          //   videoStyle: VideoStyle(
          //     qualityStyle: TextStyle(
          //       fontSize: 16.0,
          //       fontWeight: FontWeight.w500,
          //       color: Colors.white,
          //     ),
          //     forwardAndBackwardBtSize: 30.0,
          //     playButtonIconSize: 40.0,
          //     playIcon: Icon(
          //       Icons.add_circle_outline_outlined,
          //       size: 40.0,
          //       color: Colors.white,
          //     ),
          //     pauseIcon: Icon(
          //       Icons.remove_circle_outline_outlined,
          //       size: 40.0,
          //       color: Colors.white,
          //     ),
          //     videoQualityPadding: EdgeInsets.all(5.0),
          //   ),
          //   videoLoadingStyle: VideoLoadingStyle(
          //     loading: Center(
          //       child: Text("Loading video"),
          //     ),
          //   ),
          // ),
        ),
      ),
    );
  }
}