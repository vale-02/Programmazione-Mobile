import 'package:brainiac/model/exam.dart';
import 'package:brainiac/widget/heading_viewexam.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

// ignore: must_be_immutable
class WorkplaceViewexam extends StatefulWidget {
  WorkplaceViewexam(
      {super.key,
      required this.id,
      required this.name,
      required this.cfu,
      required this.status,
      required this.grade,
      required this.description,
      required this.selectedYear,
      required this.yearBox});
  Box yearBox;
  final int selectedYear;
  final int id;
  String name;
  int cfu;
  bool status;
  int grade;
  String description;

  @override
  State<WorkplaceViewexam> createState() => _WorkplaceViewexam();
}

// Pagina di visualizzazione dell'esame selezionato con il GestureDetector in ListExam
// ** da aggiungere le miniature video e libri prese con API **
class _WorkplaceViewexam extends State<WorkplaceViewexam> {
  @override
  Widget build(BuildContext context) {
    Exam exam = Exam(
        id: widget.id,
        name: widget.name,
        cfu: widget.cfu,
        status: widget.status,
        grade: widget.grade,
        description: widget.description);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeadingViewexam(
                exam: exam,
                year: widget.yearBox,
                selectedYear: widget.selectedYear),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text('CFU: ${widget.cfu.toString()}'),
                SizedBox(
                  width: 50,
                ),
                Text('Stato: ${_getStatus()}'),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text('Descrizione :'),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 200,
              child: SingleChildScrollView(
                child: Text(
                  widget.description,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getStatus() {
    return widget.status ? 'Superato' : 'In corso';
  }
}
