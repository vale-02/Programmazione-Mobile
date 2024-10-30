import 'package:brainiac/model/playlist.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

//Funzione cancellazione modello Playlist dall'archivio
class DeletePlaylist {
  DeletePlaylist({required this.onDelete});
  void Function() onDelete;

  void deletePlaylist(BuildContext context, Playlist playlist) {
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
