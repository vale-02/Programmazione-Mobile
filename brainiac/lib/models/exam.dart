import 'package:hive/hive.dart';

part 'exam.g.dart';

@HiveType(typeId: 1)
class Exam {
  @HiveField(0)
  final int id;

  @HiveField(1)
  String name;

  @HiveField(2)
  int cfu;

  @HiveField(3)
  bool status;

  @HiveField(4)
  int grade;

  @HiveField(5)
  String description;

  Exam(
      {required this.id,
      required this.name,
      required this.cfu,
      required this.status,
      required this.grade,
      required this.description});
}
