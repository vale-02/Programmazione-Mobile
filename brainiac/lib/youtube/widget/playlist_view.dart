import 'package:brainiac/model/playlist.dart';
import 'package:brainiac/youtube/playlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class PlaylistView {
  PlaylistView({required this.onDelete});
  void Function() onDelete;

  Widget builPlaylist(BuildContext context, Playlist playlist,
      {bool add = false, bool delete = false}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => PlaylistScreen(id: playlist.id),
          ),
        );
      },
      onLongPress: () {
        if (add) {
          _addVideo(context, playlist);
        }
        if (delete) {
          _deleteVideo(context, playlist);
        }
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
                      color: Colors.grey,
                      child: Icon(Icons.error),
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

  void _addVideo(BuildContext context, Playlist playlist) {
    showDialog(
      context: context,
      useSafeArea: true,
      builder: (context) => AlertDialog(
        scrollable: true,
        title: Text('Aggiungi playlist'),
        content: Text('Vuoi aggiungere ${playlist.title} all\'archivio?'),
        actions: [
          ElevatedButton(
            onPressed: () {
              bool videoExists = false;
              for (int i = 0; i < Hive.box('PlaylistBox').length; i++) {
                final result = Hive.box('PlaylistBox').getAt(i) as Playlist;
                if (result.title == playlist.title) {
                  videoExists = true;
                  break;
                }
              }
              if (videoExists) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Playlist già presente nell\'archivio'),
                    showCloseIcon: true,
                  ),
                );
              } else {
                Hive.box('PlaylistBox').add(playlist);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Playlist aggiunta all\'archivio'),
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

  void _deleteVideo(BuildContext context, Playlist playlist) {
    showDialog(
      context: context,
      useSafeArea: true,
      builder: (context) => AlertDialog(
        scrollable: true,
        title: Text('Elimina playlist'),
        content: Text('Vuoi eliminare ${playlist.title} dall\'archivio?'),
        actions: [
          ElevatedButton(
            onPressed: () {
              int selectedIndex = -1;

              for (int i = 0; i < Hive.box('PlaylistBox').length; i++) {
                final result = Hive.box('PlaylistBox').getAt(i) as Playlist;
                if (result.id == playlist.id) {
                  selectedIndex = i;
                  break;
                }
              }
              Hive.box('PlaylistBox').deleteAt(selectedIndex);
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
