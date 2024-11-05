import 'package:auto_size_text/auto_size_text.dart';
import 'package:brainiac/models/playlist.dart';
import 'package:brainiac/services/database/add_playlist.dart';
import 'package:brainiac/services/database/delete_playlist.dart';
import 'package:brainiac/views/screen/playlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

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
            builder: (_) => PlaylistScreen(
              id: playlist.id,
              title: playlist.title,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
        padding: EdgeInsets.all(5.0),
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
                  child: CircleAvatar(
                      backgroundColor: Colors.red,
                      child: Icon(
                        Icons.playlist_play_rounded,
                        color: Colors.black,
                      )),
                ),
              ],
            ),
            SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: AutoSizeText(
                playlist.title,
                maxLines: 3,
                minFontSize: 13,
                stepGranularity: 1,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: 'Museo Moderno',
                ),
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
        icon: HugeIcon(
          icon: HugeIcons.strokeRoundedFolderAdd,
          color: Color(0xFFFC8D0A),
        ),
      );
    }
    return IconButton(
      onPressed: () {
        DeletePlaylist(onDelete: onDelete).deletePlaylist(context, playlist);
      },
      icon: HugeIcon(
        icon: HugeIcons.strokeRoundedFolderRemove,
        color: Color(0xFFFC8D0A),
      ),
    );
  }
}
