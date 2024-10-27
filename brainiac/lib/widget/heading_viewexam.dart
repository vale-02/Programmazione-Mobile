import 'package:brainiac/model/exam.dart';
import 'package:brainiac/workplace/workplace_editexam.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

// ignore: must_be_immutable
class HeadingViewexam extends StatefulWidget {
  HeadingViewexam(
      {super.key,
      required this.exam,
      required this.selectedYear,
      required this.year});
  Exam exam;
  final int selectedYear;
  Box year;

  @override
  State<HeadingViewexam> createState() => _HeadingViewexam();
}

/*
  Heading con dettagli esame 
  - Pulsante di modifica
  - Nome esame
  - Valutazione
*/

class _HeadingViewexam extends State<HeadingViewexam> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            onPressed: () {
              _editExamScreen(context);
            },
            icon: Icon(Icons.edit)),
        SizedBox(
          width: 20,
        ),
        Text(widget.exam.name),
        SizedBox(
          width: 20,
        ),
        Text(_getGrade()),
      ],
    );
  }

  String _getGrade() {
    return widget.exam.grade == 0 ? '' : widget.exam.grade.toString();
  }

  // Funzione per la modifica dell'esame che si sta vedendo e aggiornamento dei dati relativi ad esso
  void _editExamScreen(BuildContext context) async {
    final updatedValues = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => WorkplaceEditexam(
          yearBox: widget.year,
          year: widget.selectedYear,
          id: widget.exam.id,
          name: widget.exam.name,
          cfu: widget.exam.cfu,
          status: widget.exam.status,
          grade: widget.exam.grade,
          description: widget.exam.description,
        ),
      ),
    );

    setState(() {
      widget.exam.name = updatedValues['name'];
      widget.exam.cfu = updatedValues['cfu'];
      widget.exam.status = updatedValues['status'];
      widget.exam.grade = updatedValues['grade'];
      widget.exam.description = updatedValues['description'];
    });
  }
}
