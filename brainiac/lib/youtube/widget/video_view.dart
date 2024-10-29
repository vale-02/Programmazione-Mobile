import 'package:brainiac/model/video.dart';
import 'package:brainiac/youtube/video_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class VideoView {
  VideoView({required this.onDelete});
  void Function() onDelete;

  Widget buildVideo(BuildContext context, Video video,
      {bool add = false, bool delete = false}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => VideoScreen(id: video.id),
          ),
        );
      },
      onLongPress: () {
        if (add) {
          _addVideo(context, video);
        }
        if (delete) {
          _deleteVideo(context, video);
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
        padding: EdgeInsets.all(5.0),
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

  void _addVideo(BuildContext context, Video video) {
    showDialog(
      context: context,
      useSafeArea: true,
      builder: (context) => AlertDialog(
        scrollable: true,
        title: Text('Aggiungi video'),
        content: Text('Vuoi aggiungere ${video.title} all\'archivio?'),
        actions: [
          ElevatedButton(
            onPressed: () {
              bool videoExists = false;
              for (int i = 0; i < Hive.box('VideoBox').length; i++) {
                final result = Hive.box('VideoBox').getAt(i) as Video;
                if (result.title == video.title) {
                  videoExists = true;
                  break;
                }
              }
              if (videoExists) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Video già presente nell\'archivio'),
                    showCloseIcon: true,
                  ),
                );
              } else {
                Hive.box('VideoBox').add(video);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Video aggiunto all\'archivio'),
                    showCloseIcon: true,
                  ),
                );
              }

              Navigator.pop(context);
            },
            child: Text('Aggiungi'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Annulla'),
          ),
        ],
      ),
    );
  }

  void _deleteVideo(BuildContext context, Video video) {
    showDialog(
      context: context,
      useSafeArea: true,
      builder: (context) => AlertDialog(
        scrollable: true,
        title: Text('Elimina video'),
        content: Text('Vuoi eliminare ${video.title} dall\'archivio?'),
        actions: [
          ElevatedButton(
            onPressed: () {
              int selectedIndex = -1;

              for (int i = 0; i < Hive.box('VideoBox').length; i++) {
                final result = Hive.box('VideoBox').getAt(i) as Video;
                if (result.id == video.id) {
                  selectedIndex = i;
                  break;
                }
              }
              Hive.box('VideoBox').deleteAt(selectedIndex);
              onDelete();
              Navigator.pop(context);
            },
            child: Text('Elimina'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Annulla'),
          ),
        ],
      ),
    );
  }
}
