import 'package:brainiac/model/video.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

//Funzione aggiunta modello Video all'archivio
class AddVideo {
  void addVideo(BuildContext context, Video video) {
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
}
