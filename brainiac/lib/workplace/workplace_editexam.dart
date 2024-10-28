import 'package:brainiac/model/exam.dart';
import 'package:brainiac/model/year.dart';
import 'package:brainiac/workplace/form/exam_edit_form.dart';
import 'package:flutter/material.dart';
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
  final _formKey = GlobalKey<FormState>();

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

  /*
      Schermata per la modifica dell'esame selezionato
      Visualizzazione di tutti i campi
      Controllo correttezza nuovi dati
      Aggiunta modifiche al DB
  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modifica esame'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ExamEditForm(
                    nameController: _nameController,
                    cfuController: _cfuController,
                    gradeController: _gradeController,
                    descriptionController: _descriptionController,
                    status: _statusController,
                    onStatusChanged: (newValue) {
                      setState(() {
                        if (newValue == false && _statusController == true) {
                          _gradeController.clear();
                          _gradeController.text = '0';
                        }
                        _statusController = newValue!;
                      });
                    }),
                ElevatedButton(
                  onPressed: () {
                    _submit();
                  },
                  child: Text('Modifica esame'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //Controllo validità del form
  void _submit() {
    if (_formKey.currentState!.validate()) {
      _editExamToDatabase();
      Navigator.pop(context, {
        'name': _nameController.text,
        'cfu': int.parse(_cfuController.text),
        'status': _statusController,
        'grade': _gradeController.text.isEmpty
            ? 0
            : int.parse(_gradeController.text),
        'description': _descriptionController.text,
      });
    }
  }

  // Aggiornamento del DB con i nuovi dati
  void _editExamToDatabase() {
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
      grade:
          _gradeController.text.isEmpty ? 0 : int.parse(_gradeController.text),
      description: _descriptionController.text,
    );

    final int examId =
        selectedYearData!.exams!.indexWhere((exam) => exam.id == widget.id);
    selectedYearData.exams![examId] = value;

    widget.yearBox.putAt(selectedIndex, selectedYearData);
  }
}
