import 'exam.dart';
import 'package:hive/hive.dart';

part 'year.g.dart';

@HiveType(typeId: 1)
class Year {
  @HiveField(0)
  final int year;

  @HiveField(1)
  final List<Exam>? exams;

  Year({required this.year, required this.exams});
}
