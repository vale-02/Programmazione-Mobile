import 'package:brainiac/model/video.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key, required this.video});
  final Video video;

  @override
  State<VideoScreen> createState() => _VideoScreen();
}

// Miniplayer di un video
class _VideoScreen extends State<VideoScreen> {
  late YoutubePlayerController _playerController;

  @override
  void initState() {
    super.initState();
    _playerController = YoutubePlayerController(
      initialVideoId: widget.video.id,
      flags: YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
      ),
    );

    _playerController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _playerController.value.isFullScreen ? null : AppBar(),
      body: PopScope(
        canPop: true,
        onPopInvokedWithResult: (didPop, result) {
          if (_playerController.value.isFullScreen) {
            _playerController.toggleFullScreenMode();
          }
        },
        child: Column(
          children: [
            Expanded(
              child: YoutubePlayer(
                controller: _playerController,
                showVideoProgressIndicator: true,
              ),
            ),
            if (!_playerController.value.isFullScreen) fullScreen(),
          ],
        ),
      ),
    );
  }

  Widget fullScreen() {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(widget.video.title),
              SizedBox(
                height: 5,
              ),
              Text(widget.video.channelTitle),
              SizedBox(
                height: 5,
              ),
              Text(widget.video.description),
            ],
          ),
        ),
      ),
    );
  }
}
