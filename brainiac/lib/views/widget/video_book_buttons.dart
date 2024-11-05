import 'package:brainiac/views/screen/book_screen.dart';
import 'package:brainiac/views/screen/youtube_screen.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class VideoBookButtons extends StatelessWidget {
  const VideoBookButtons({super.key, required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => YoutubeScreen(searchName: name),
              ),
            );
          },
          child: Row(
            children: [
              HugeIcon(
                icon: HugeIcons.strokeRoundedYoutube,
                color: Colors.red,
                size: 20,
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                'Video',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Museo Moderno',
                ),
              ),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => BookScreen(searchName: name),
              ),
            );
          },
          child: Row(
            children: [
              HugeIcon(
                icon: HugeIcons.strokeRoundedBookBookmark02,
                color: Colors.blue,
                size: 20,
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                'Libri',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Museo Moderno',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
