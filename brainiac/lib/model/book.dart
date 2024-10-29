import 'package:hive_flutter/hive_flutter.dart';

part 'book.g.dart';

@HiveType(typeId: 4)
class Book {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final String thumbnailUrl;
  @HiveField(4)
  final String previewLink;
  @HiveField(5)
  final String buyLink;

  Book({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnailUrl,
    required this.previewLink,
    required this.buyLink,
  });

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      id: map['id'] as String? ?? 'N/A',
      title: map['volumeInfo']['title'] as String? ?? 'N/A',
      description: map['volumeInfo']['description'] as String? ?? 'N/A',
      thumbnailUrl:
          map['volumeInfo']['imageLinks']['thumbnail'] as String? ?? 'N/A',
      previewLink: map['volumeInfo']['previewLink'] as String? ?? 'N/A',
      buyLink: map['volumeInfo']['canonicalVolumeLink'] as String? ?? 'N/A',
    );
  }
}
