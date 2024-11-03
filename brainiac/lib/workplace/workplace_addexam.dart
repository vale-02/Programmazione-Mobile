import 'package:brainiac/model/exam.dart';
import 'package:brainiac/model/year.dart';
import 'package:brainiac/workplace/form/exam_add_form.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:flutter_gradient_text/flutter_gradient_text.dart';

class WorkplaceAddexam extends StatefulWidget {
  const WorkplaceAddexam({super.key, required this.selectedYear});
  final int selectedYear;

  @override
  State<WorkplaceAddexam> createState() => _WorkplaceAddexam();
}

class _WorkplaceAddexam extends State<WorkplaceAddexam> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cfuController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _cfuController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  // Schermata aggiunta nuovo esame
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(
            height: 1,
            width: double.infinity,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontFamily: 'Museo Moderno',
        ),
        title: GradientText(
          Text(
            'Inserisci esame',
          ),
          colors: [
            Color(0xFFFC8D0A),
            Color(0xFFFE2C8D),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ExamAddForm(
                    nameController: _nameController,
                    cfuController: _cfuController,
                    descriptionController: _descriptionController),
                ElevatedButton(
                  onPressed: () {
                    _submit();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFE2C8D),
                  ),
                  child: Text(
                    'Aggiungi esame',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Museo Moderno',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Controllo validità del form
  void _submit() {
    if (_formKey.currentState!.validate()) {
      _addExamToDatabase();
      Navigator.pop(context);
    }
  }

  // Aggiunta dell'esame al DB
  void _addExamToDatabase() {
    int index = -1;

    for (int i = 0; i < Hive.box('YearBox').length; i++) {
      Year storedYear = Hive.box('YearBox').getAt(i) as Year;
      if (storedYear.year == widget.selectedYear) {
        index = i;
        break;
      }
    }

    Year existingYear = Hive.box('YearBox').getAt(index) as Year;
    List<Exam> updatedExams = List.from(existingYear.exams ?? []);

    final value = Exam(
      id: updatedExams.length + 1,
      name: _nameController.text,
      cfu: int.parse(_cfuController.text),
      status: false,
      grade: 0,
      description: _descriptionController.text,
    );

    updatedExams.add(value);

    final updatedYear = Year(year: existingYear.year, exams: updatedExams);
    Hive.box('YearBox').putAt(index, updatedYear);
  }
}
