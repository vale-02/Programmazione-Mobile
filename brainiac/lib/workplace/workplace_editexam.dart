import 'package:brainiac/model/exam.dart';
import 'package:brainiac/model/year.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

// ignore: must_be_immutable
class WorkplaceEditexam extends StatefulWidget {
  WorkplaceEditexam(
      {super.key,
      required this.id,
      required this.name,
      required this.cfu,
      required this.status,
      required this.grade,
      required this.description,
      required this.year,
      required this.yearBox});
  final int year;
  final int id;
  final String name;
  final int cfu;
  final bool status;
  final int grade;
  final String description;
  Box yearBox;

  @override
  State<WorkplaceEditexam> createState() => _WorkplaceEditexam();
}

class _WorkplaceEditexam extends State<WorkplaceEditexam> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cfuController = TextEditingController();
  final TextEditingController _gradeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  late bool _statusController;

  @override
  void initState() {
    _nameController.text = widget.name;
    _cfuController.text = widget.cfu.toString();
    _statusController = widget.status;
    _descriptionController.text = widget.description;
    widget.grade == 0
        ? _gradeController.text = ''
        : _gradeController.text = widget.grade.toString();

    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _cfuController.dispose();
    _gradeController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modifica esame'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Nome esame',
                  hintText: widget.name,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: _cfuController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: InputDecoration(
                    labelText: 'CFU', hintText: widget.cfu.toString()),
              ),
              SizedBox(
                height: 20,
              ),
              SingleChildScrollView(
                child: TextField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Descrizione esame',
                    hintText: widget.description,
                  ),
                  maxLines: null,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              DropdownButton<bool>(
                value: _statusController,
                onChanged: (bool? newValue) {
                  setState(() {
                    _statusController = newValue!;
                  });
                },
                items: [
                  DropdownMenuItem(
                    value: true,
                    child: Text('Superato'),
                  ),
                  DropdownMenuItem(
                    value: false,
                    child: Text('In corso'),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: _gradeController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: InputDecoration(
                    labelText: 'Voto', hintText: widget.grade.toString()),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  _updateExamDB();
                },
                child: Text('Modifica esame'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _updateExamDB() {
    int selectedIndex = -1;

    Year? selectedYearData;

    for (int i = 0; i < widget.yearBox.length; i++) {
      final yearData = widget.yearBox.getAt(i) as Year;
      if (yearData.year == widget.year) {
        selectedYearData = yearData;
        selectedIndex = i;
        break;
      }
    }

    final value = Exam(
      id: widget.id,
      name: _nameController.text,
      cfu: int.parse(_cfuController.text),
      status: _statusController,
      grade: int.parse(_gradeController.text),
      description: _descriptionController.text,
    );

    final int examId =
        selectedYearData!.exams!.indexWhere((exam) => exam.id == widget.id);
    selectedYearData.exams![examId] = value;

    widget.yearBox.putAt(selectedIndex, selectedYearData);

    Navigator.pop(context, {
      'name': _nameController.text,
      'cfu': int.parse(_cfuController.text),
      'status': _statusController,
      'grade': int.parse(_gradeController.text),
      'description': _descriptionController.text,
    });
  }
}
