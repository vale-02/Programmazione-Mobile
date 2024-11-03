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
        title: Text(
          'Aggiungi video',
          textAlign: TextAlign.center,
        ),
        titleTextStyle: TextStyle(
          color: Color.fromARGB(255, 224, 193, 255),
          fontFamily: 'Museo Moderno',
        ),
        content: Text(
          'Vuoi aggiungere ${video.title} all\'archivio?',
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
                    content: Text(
                      'Video già presente nell\'archivio',
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
                Hive.box('VideoBox').add(video);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Video aggiunto all\'archivio',
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
