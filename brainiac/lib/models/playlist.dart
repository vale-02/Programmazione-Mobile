import 'package:hive_flutter/hive_flutter.dart';

part 'playlist.g.dart';

@HiveType(typeId: 3)
class Playlist {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final String thumbnailsUrl;

  Playlist(
      {required this.id,
      required this.title,
      required this.description,
      required this.thumbnailsUrl});

  factory Playlist.fromMap(Map<String, dynamic> map) {
    return Playlist(
      id: map['id']['playlistId'] as String? ?? 'N/A',
      title: map['snippet']['title'] as String? ?? 'N/A',
      description: map['snippet']['description'] as String? ?? 'N/A',
      thumbnailsUrl:
          map['snippet']['thumbnails']['default']['url'] as String? ?? 'N/A',
    );
  }
}
