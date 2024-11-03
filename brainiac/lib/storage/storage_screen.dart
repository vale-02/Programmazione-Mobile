import 'package:brainiac/view/book_view.dart';
import 'package:brainiac/model/playlist.dart';
import 'package:brainiac/model/video.dart';
import 'package:brainiac/view/playlist_view.dart';
import 'package:brainiac/view/video_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gradient_text/flutter_gradient_text.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class StorageScreen extends StatefulWidget {
  const StorageScreen({super.key});

  @override
  State<StorageScreen> createState() => _StorageScreenState();
}

//Schermata archivio
class _StorageScreenState extends State<StorageScreen> {
  String currentCategory = 'video';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontFamily: 'Museo Moderno',
        ),
        title: GradientText(
          Text(
            'Archivio',
          ),
          colors: [
            Color(0xFFFC8D0A),
            Color(0xFFFE2C8D),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
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
                style: ElevatedButton.styleFrom(
                  backgroundColor: currentCategory == 'video'
                      ? Color(0xFFFE2C8D)
                      : Color(0xFFFC8D0A),
                ),
                child: Text(
                  'Video',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Museo Moderno',
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    currentCategory = 'playlist';
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: currentCategory == 'playlist'
                      ? Color(0xFFFE2C8D)
                      : Color(0xFFFC8D0A),
                ),
                child: Text(
                  'Playlist',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Museo Moderno',
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    currentCategory = 'book';
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: currentCategory == 'book'
                      ? Color(0xFFFE2C8D)
                      : Color(0xFFFC8D0A),
                ),
                child: Text(
                  'Libri',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Museo Moderno',
                  ),
                ),
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

          if (items.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'Nessun elemento salvato in archivio',
                  style: TextStyle(
                    color: Color.fromARGB(255, 224, 193, 255),
                    fontFamily: 'Museo Moderno',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          } else {
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
                } else {
                  return BookView(onDelete: () => setState(() {}))
                      .buildBook(context, item, delete: true);
                }
              },
            );
          }
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
