import 'package:brainiac/model/playlist.dart';
import 'package:brainiac/model/video.dart';
import 'package:brainiac/youtube/api_service.dart';
import 'package:brainiac/youtube/playlist_screen.dart';
import 'package:brainiac/youtube/video_screen.dart';
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
                    return _buildVideo(_result[index]);
                  } else {
                    return _builPlaylist(_result[index]);
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

  void _loadMoreVideo() async {
    _isLoading = true;
    List<dynamic> result = await APIService.instance
        .fetchVideoFromSearch(widget.searchName, loadMore: true);
    setState(() {
      _result.addAll(result);
    });

    _isLoading = false;
  }

  Widget _builPlaylist(Playlist playlist) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => PlaylistScreen(id: playlist.id),
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
                  playlist.thumbnailsUrl,
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
                  child: Icon(Icons.playlist_play_outlined),
                ),
              ],
            ),
            SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: Text(
                playlist.title,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
