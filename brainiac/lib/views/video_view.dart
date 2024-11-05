import 'package:auto_size_text/auto_size_text.dart';
import 'package:brainiac/models/video.dart';
import 'package:brainiac/services/database/add_video.dart';
import 'package:brainiac/services/database/delete_video.dart';
import 'package:brainiac/utils/video_player.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

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
            builder: (_) => VideoPlayer(video: video),
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
                  child: CircleAvatar(
                      backgroundColor: Colors.red,
                      child: Icon(
                        Icons.play_arrow_rounded,
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
                video.title,
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
        icon: HugeIcon(
          icon: HugeIcons.strokeRoundedFolderAdd,
          color: Color(0xFFFC8D0A),
        ),
      );
    }
    if (storage) {
      return HugeIcon(
        icon: HugeIcons.strokeRoundedArrowRight01,
        color: Color(0xFFFC8D0A),
      );
    }
    return IconButton(
      onPressed: () {
        DeleteVideo(onDelete: onDelete).deleteVideo(context, video);
      },
      icon: HugeIcon(
        icon: HugeIcons.strokeRoundedFolderRemove,
        color: Color(0xFFFC8D0A),
      ),
    );
  }
}
