import 'package:brainiac/model/video.dart';
import 'package:brainiac/youtube/api_service.dart';
import 'package:brainiac/youtube/widget/playlist_view.dart';
import 'package:brainiac/youtube/widget/video_view.dart';
import 'package:flutter/material.dart';

class YoutubeScreen extends StatefulWidget {
  const YoutubeScreen({super.key, required this.searchName});
  final String searchName;

  @override
  State<YoutubeScreen> createState() => _YoutubeScreen();
}

class _YoutubeScreen extends State<YoutubeScreen> {
  List<dynamic> _result = [];
  bool _isLoading = false;

  @override
  void initState() {
    _initVideo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _result.isNotEmpty
          ? NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scroll) {
                if (!_isLoading &&
                    scroll.metrics.pixels == scroll.metrics.maxScrollExtent) {
                  _loadMoreVideo();
                }
                return false;
              },
              child: ListView.builder(
                itemCount: _result.length,
                itemBuilder: (context, index) {
                  if (_result[index] is Video) {
                    return VideoView(onDelete: () => setState(() {}))
                        .buildVideo(context, _result[index], add: true);
                  } else {
                    return PlaylistView(onDelete: () => setState(() {}))
                        .builPlaylist(context, _result[index], add: true);
                  }
                },
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  void _initVideo() async {
    List<dynamic> result =
        await APIService.instance.fetchVideoFromSearch(widget.searchName);
    setState(() {
      _result = result;
    });
  }

  void _loadMoreVideo() async {
    _isLoading = true;
    List<dynamic> result = await APIService.instance
        .fetchVideoFromSearch(widget.searchName, loadMore: true);
    setState(() {
      _result.addAll(result);
    });

    _isLoading = false;
  }
}
