import 'package:brainiac/models/video.dart';
import 'package:brainiac/services/api/video_api_service.dart';
import 'package:brainiac/views/video_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gradient_text/flutter_gradient_text.dart';

class PlaylistScreen extends StatefulWidget {
  const PlaylistScreen({super.key, required this.id, required this.title});
  final String id;
  final String title;

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
      appBar: AppBar(
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
            widget.title,
          ),
          colors: [
            Color(0xFFFC8D0A),
            Color(0xFFFE2C8D),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
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
