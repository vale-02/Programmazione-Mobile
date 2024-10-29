import 'package:hive_flutter/hive_flutter.dart';

part 'video.g.dart';

@HiveType(typeId: 2)
class Video {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final String thumbnailsUrl;
  @HiveField(4)
  final String channelTitle;

  Video({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnailsUrl,
    required this.channelTitle,
  });

  factory Video.fromMap(Map<String, dynamic> map) {
    return Video(
      id: map['kind'] == 'youtube#playlistItem'
          ? map['snippet']['resourceId']['videoId'] as String? ?? 'N/A'
          : map['id']['videoId'] as String? ?? 'N/A',
      title: map['snippet']['title'] as String? ?? 'N/A',
      description: map['snippet']['description'] as String? ?? 'N/A',
      thumbnailsUrl:
          map['snippet']['thumbnails']['default']['url'] as String? ?? 'N/A',
      channelTitle: map['snippet']['channelTitle'] as String? ?? 'N/A',
    );
  }
}
