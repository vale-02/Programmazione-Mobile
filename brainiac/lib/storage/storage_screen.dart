import 'package:brainiac/model/playlist.dart';
import 'package:brainiac/model/video.dart';
import 'package:brainiac/youtube/widget/playlist_view.dart';
import 'package:brainiac/youtube/widget/video_view.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class StorageScreen extends StatefulWidget {
  const StorageScreen({super.key});

  @override
  State<StorageScreen> createState() => _StorageScreenState();
}

class _StorageScreenState extends State<StorageScreen> {
  String currentCategory = 'video';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Archivio'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    currentCategory = 'video';
                  });
                },
                child: Text('Video'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    currentCategory = 'playlist';
                  });
                },
                child: Text('Playlist'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    currentCategory = 'book';
                  });
                },
                child: Text('Libri'),
              ),
            ],
          ),
        ),
      ),
      body: FutureBuilder<Box>(
        future: _getCurrentBox(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final box = snapshot.data!;
          final items = box.values.toList();

          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];

              if (item is Video) {
                return VideoView(onDelete: () => setState(() {}))
                    .buildVideo(context, item, delete: true);
              } else if (item is Playlist) {
                return PlaylistView(onDelete: () => setState(() {}))
                    .builPlaylist(context, item, delete: true);
              } /*else if (item is Book) {
                
              } */
              else {
                return Text('Nessuno oggetto selezionato');
              }
            },
          );
        },
      ),
    );
  }

  Future<Box> _getCurrentBox() async {
    switch (currentCategory) {
      case 'playlist':
        return Hive.box('PlaylistBox');
      case 'book':
        return Hive.box('BookBox');
      default:
        return Hive.box('VideoBox');
    }
  }
}
