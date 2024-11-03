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
        title: Text(
          'Elimina playlist',
          textAlign: TextAlign.center,
        ),
        titleTextStyle: TextStyle(
          color: Colors.red,
          fontFamily: 'Museo Moderno',
        ),
        content: Text(
          'Vuoi eliminare ${playlist.title} dall\'archivio?',
          textAlign: TextAlign.center,
        ),
        contentTextStyle: TextStyle(
          color: Colors.white,
          fontFamily: 'Museo Moderno',
        ),
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
            child: Text(
              'Elimina',
              style: TextStyle(
                color: Colors.red,
                fontFamily: 'Museo Moderno',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Annulla',
              style: TextStyle(
                color: Color.fromARGB(255, 224, 193, 255),
                fontFamily: 'Museo Moderno',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
