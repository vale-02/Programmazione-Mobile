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
        title: Text(
          'Elimina video',
          textAlign: TextAlign.center,
        ),
        titleTextStyle: TextStyle(
          color: Colors.red,
          fontFamily: 'Museo Moderno',
        ),
        content: Text(
          'Vuoi eliminare ${video.title} dall\'archivio?',
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
