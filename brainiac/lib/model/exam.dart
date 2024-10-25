import 'package:hive/hive.dart';

part 'exam.g.dart';

@HiveType(typeId: 0)
class Exam {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  Exam({required this.id, required this.name});
}
