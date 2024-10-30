import 'package:brainiac/model/video.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

//Funzione cancellazione modello Video dall'archivio
class DeleteVideo {
  DeleteVideo({required this.onDelete});
  void Function() onDelete;

  void deleteVideo(BuildContext context, Video video) {
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
