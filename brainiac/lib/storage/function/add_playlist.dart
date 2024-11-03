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
        title: Text(
          'Aggiungi playlist',
          textAlign: TextAlign.center,
        ),
        titleTextStyle: TextStyle(
          color: Color.fromARGB(255, 224, 193, 255),
          fontFamily: 'Museo Moderno',
        ),
        content: Text(
          'Vuoi aggiungere ${playlist.title} all\'archivio?',
          textAlign: TextAlign.center,
        ),
        contentTextStyle: TextStyle(
          color: Colors.white,
          fontFamily: 'Museo Moderno',
        ),
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
                    content: Text(
                      'Playlist già presente nell\'archivio',
                      style: TextStyle(
                        fontFamily: 'Museo Moderno',
                      ),
                    ),
                    showCloseIcon: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                );
              } else {
                Hive.box('PlaylistBox').add(playlist);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Playlist aggiunta all\'archivio',
                      style: TextStyle(
                        fontFamily: 'Museo Moderno',
                      ),
                    ),
                    showCloseIcon: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                );
              }

              Navigator.pop(context);
            },
            child: Text(
              'Aggiungi',
              style: TextStyle(
                color: Color(0xFFFC8D0A),
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
