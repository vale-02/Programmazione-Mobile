import 'package:brainiac/models/video.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gradient_text/flutter_gradient_text.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayer extends StatefulWidget {
  const VideoPlayer({super.key, required this.video});
  final Video video;

  @override
  State<VideoPlayer> createState() => _VideoPlayer();
}

// Miniplayer di un video
class _VideoPlayer extends State<VideoPlayer> {
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
      appBar: _playerController.value.isFullScreen
          ? null
          : AppBar(
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(1.0),
                child: Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.white,
                ),
              ),
              centerTitle: true,
              titleTextStyle: TextStyle(
                fontSize: 20,
                fontFamily: 'Museo Moderno',
              ),
              title: GradientText(
                Text(
                  widget.video.channelTitle,
                ),
                colors: [
                  Color(0xFFFC8D0A),
                  Color(0xFFFE2C8D),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
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
              Text(
                widget.video.title,
                style: TextStyle(
                  color: Color(0xFFFC8D0A),
                  fontSize: 15,
                  fontFamily: 'Museo Moderno',
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.video.description,
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'Museo Moderno',
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
