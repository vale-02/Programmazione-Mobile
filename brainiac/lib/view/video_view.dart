import 'package:brainiac/model/video.dart';
import 'package:brainiac/storage/function/add_video.dart';
import 'package:brainiac/storage/function/delete_video.dart';
import 'package:brainiac/youtube/video_screen.dart';
import 'package:flutter/material.dart';

class VideoView {
  VideoView({required this.onDelete});
  void Function() onDelete;

  //Funzione visualizzazione modello Video con gestione tocco e icona per l'archivio
  Widget buildVideo(BuildContext context, Video video,
      {bool delete = false, bool storage = false}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => VideoScreen(video: video),
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
                  video.thumbnailsUrl,
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
                  child: Icon(Icons.play_arrow),
                ),
              ],
            ),
            SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: Text(
                video.title,
              ),
            ),
            icon(storage, delete, context, video),
          ],
        ),
      ),
    );
  }

  Widget icon(bool storage, bool delete, BuildContext context, Video video) {
    if (!delete && !storage) {
      return IconButton(
        onPressed: () {
          AddVideo().addVideo(context, video);
        },
        icon: Icon(Icons.folder_open_outlined),
      );
    }
    if (storage) {
      return Icon(Icons.linear_scale);
    }
    return IconButton(
      onPressed: () {
        DeleteVideo(onDelete: onDelete).deleteVideo(context, video);
      },
      icon: Icon(Icons.folder_delete_rounded),
    );
  }
}
