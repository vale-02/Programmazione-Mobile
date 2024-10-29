import 'package:brainiac/model/video.dart';
import 'package:brainiac/youtube/api_service.dart';
import 'package:brainiac/youtube/video_screen.dart';
import 'package:flutter/material.dart';

class PlaylistScreen extends StatefulWidget {
  const PlaylistScreen({super.key, required this.id});
  final String id;

  @override
  State<PlaylistScreen> createState() => _PlaylistScreen();
}

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
                  return _buildVideo(_video[index]);
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

  Widget _buildVideo(Video video) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => VideoScreen(id: video.id),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
        padding: EdgeInsets.all(10.0),
        child: Row(
          children: [
            Stack(
              children: [
                Image.network(
                  video.thumbnailsUrl,
                  width: 150.0,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 150.0,
                      height: 140.0,
                      color: Colors.grey, // Colore di sfondo per l'errore
                      child: Icon(Icons.error), // Icona di errore
                    );
                  },
                ),
                Positioned(
                  top: 10,
                  left: 10,
                  child: Icon(Icons.play_arrow),
                ),
              ],
            ),
            SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: Text(
                video.title,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
