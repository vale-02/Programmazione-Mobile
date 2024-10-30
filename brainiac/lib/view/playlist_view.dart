import 'package:brainiac/model/playlist.dart';
import 'package:brainiac/storage/function/add_playlist.dart';
import 'package:brainiac/storage/function/delete_playlist.dart';
import 'package:brainiac/youtube/playlist_screen.dart';
import 'package:flutter/material.dart';

class PlaylistView {
  PlaylistView({required this.onDelete});
  void Function() onDelete;

  //Funzione visualizzazione modello Playlist con gestione tocco e icona per l'archivio
  Widget builPlaylist(BuildContext context, Playlist playlist,
      {bool delete = false}) {
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
            icon(delete, context, playlist)
          ],
        ),
      ),
    );
  }

  Widget icon(bool delete, BuildContext context, Playlist playlist) {
    if (!delete) {
      return IconButton(
        onPressed: () {
          AddPlaylist().addPlaylist(context, playlist);
        },
        icon: Icon(Icons.folder_open_outlined),
      );
    }
    return IconButton(
      onPressed: () {
        DeletePlaylist(onDelete: onDelete).deletePlaylist(context, playlist);
      },
      icon: Icon(Icons.folder_delete_rounded),
    );
  }
}
