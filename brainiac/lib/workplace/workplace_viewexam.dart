import 'package:brainiac/workplace/workplace_editexam.dart';
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
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      _editExamScreen(context);
                    },
                    icon: Icon(Icons.edit)),
                SizedBox(
                  width: 20,
                ),
                Text(widget.name),
                SizedBox(
                  width: 20,
                ),
                Text(_getGrade()),
              ],
            ),
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

  String _getGrade() {
    return widget.grade == 0 ? '' : widget.grade.toString();
  }

  // Funzione per la modifica dell'esame che si sta vedendo e aggiornamento dei dati relativi ad esso
  void _editExamScreen(BuildContext context) async {
    final updatedValues = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => WorkplaceEditexam(
          yearBox: widget.yearBox,
          year: widget.selectedYear,
          id: widget.id,
          name: widget.name,
          cfu: widget.cfu,
          status: widget.status,
          grade: widget.grade,
          description: widget.description,
        ),
      ),
    );

    if (updatedValues != null) {
      setState(() {
        widget.name = updatedValues['name'] ?? widget.name;
        widget.cfu = updatedValues['cfu'] ?? widget.cfu;
        widget.status = updatedValues['status'] ?? widget.status;
        widget.grade = updatedValues['grade'] ?? widget.grade;
        widget.description = updatedValues['description'] ?? widget.description;
      });
    }
  }
}
