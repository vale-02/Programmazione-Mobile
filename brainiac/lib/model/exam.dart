import 'package:hive/hive.dart';

part 'exam.g.dart';

@HiveType(typeId: 0)
class Exam {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final int cfu;

  @HiveField(3)
  final bool status;

  @HiveField(4)
  final int grade;

  @HiveField(5)
  final String description;

  Exam(
      {required this.id,
      required this.name,
      required this.cfu,
      required this.status,
      required this.grade,
      required this.description});
}
