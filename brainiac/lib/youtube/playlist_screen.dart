import 'package:brainiac/model/video.dart';
import 'package:brainiac/youtube/api_service.dart';
import 'package:brainiac/view/video_view.dart';
import 'package:flutter/material.dart';

class PlaylistScreen extends StatefulWidget {
  const PlaylistScreen({super.key, required this.id});
  final String id;

  @override
  State<PlaylistScreen> createState() => _PlaylistScreen();
}

// Schermata visualizzazione elenco video di una playlist
class _PlaylistScreen extends State<PlaylistScreen> {
  List<Video> _video = [];
  bool _isLoading = false;

  @override
  void initState() {
    _initPlaylist();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _video.isNotEmpty
          ? NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scroll) {
                if (!_isLoading &&
                    scroll.metrics.pixels == scroll.metrics.maxScrollExtent) {
                  _loadMoreVideo();
                }
                return false;
              },
              child: ListView.builder(
                itemCount: _video.length,
                itemBuilder: (context, index) {
                  return VideoView(onDelete: () => setState(() {}))
                      .buildVideo(context, _video[index], storage: true);
                },
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Future<void> _initPlaylist() async {
    List<Video> video =
        await APIService.instance.fetchVideoFromPlaylist(widget.id);
    setState(() {
      _video = video;
    });
  }

  void _loadMoreVideo() async {
    _isLoading = true;
    List<Video> video = await APIService.instance
        .fetchVideoFromPlaylist(widget.id, loadMore: true);
    setState(() {
      _video.addAll(video);
    });

    _isLoading = false;
  }
}
