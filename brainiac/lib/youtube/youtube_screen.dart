import 'package:brainiac/model/video.dart';
import 'package:brainiac/youtube/api_service.dart';
import 'package:brainiac/youtube/video_screen.dart';
import 'package:flutter/material.dart';

class YoutubeScreen extends StatefulWidget {
  const YoutubeScreen(
      {super.key, required this.searchName, required this.searchCfu});
  final String searchName;
  final int searchCfu;

  @override
  State<YoutubeScreen> createState() => _YoutubeScreen();
}

class _YoutubeScreen extends State<YoutubeScreen> {
  List<Video> _video = [];

  @override
  void initState() {
    _initVideo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: _video.length,
        itemBuilder: (context, index) {
          Video video = _video[index];
          return _buildVideo(video);
        },
      ),
    );
  }

  void _initVideo() async {
    List<Video> video = await APIService.instance
        .fetchVideoFromSearch(widget.searchName, widget.searchCfu);
    setState(() {
      _video = video;
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



/*class _YoutubeScreen extends State<YoutubeScreen> {
  late Channel _channel;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initChannel();
  }

  void _loadMoreVideos() async {
    _isLoading = true;
    List<Video> moreVideos = await APIService.instance
        .fetchVideoFromPlaylist(playlistId: _channel.uploadPlaylistId);
    _channel.videos?.addAll(moreVideos);
    List<Video> allVideos = _channel.videos!;
    setState(() {
      _channel.videos = allVideos;
    });
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Video'),
        ),
        // ignore: unnecessary_null_comparison
        body: _channel != null
            ? NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification scrollDetails) {
                  if (!_isLoading &&
                      _channel.videos!.length !=
                          int.parse(_channel.videoCount) &&
                      scrollDetails.metrics.pixels ==
                          scrollDetails.metrics.maxScrollExtent) {
                    _loadMoreVideos();
                  }
                  return false;
                },
                child: ListView.builder(
                  itemCount: 1 + _channel.videos!.length,
                  itemBuilder: (context, index) {
                    Video video = _channel.videos![index - 1];
                    return _buildVideo(video);
                  },
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              ));
  }

  void _initChannel() async {
    Channel channel =
        await APIService.instance.fetchChannel(channelId: channelId);
    setState(() {
      _channel = channel;
    });
  }

  _buildVideo(Video video) {
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
        height: 140.0,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              offset: Offset(0, 1),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Row(
          children: [
            Image(
              width: 150.0,
              image: NetworkImage(video.thumbnailUrl),
            ),
            SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: Text(
                video.title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}*/
