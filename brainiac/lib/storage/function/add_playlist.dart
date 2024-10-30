import 'package:brainiac/model/playlist.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

//Funzione aggiunta modello Playlist all'archivio
class AddPlaylist {
  void addPlaylist(BuildContext context, Playlist playlist) {
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
}
