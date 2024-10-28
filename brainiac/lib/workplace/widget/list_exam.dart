import 'package:brainiac/model/exam.dart';
import 'package:brainiac/model/year.dart';
import 'package:brainiac/workplace/workplace_viewexam.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

// ignore: must_be_immutable
class ListExam extends StatelessWidget {
  ListExam(
      {super.key,
      required this.year,
      required this.selectedYear,
      required this.yearBox});
  Year year;
  final int selectedYear;
  Box yearBox;

  /*
      Visualizzazione anteprima esame con possibilità di premerlo e aprire una nuova pagina con i dettagli
      - Icona per eliminazione esame
      - Nome esame e CFU
      - Stato di completamento dell'esame
  */

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: year.exams?.length,
      itemBuilder: (context, index) {
        final helper = year.exams?[index];
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => WorkplaceViewexam(
                  yearBox: yearBox,
                  selectedYear: selectedYear,
                  id: helper.id,
                  name: helper.name,
                  cfu: helper.cfu,
                  status: helper.status,
                  grade: helper.grade,
                  description: helper.description,
                ),
              ),
            );
          },
          child: ListTile(
            leading: IconButton(
              onPressed: () {
                _deleteExamMessage(context, helper);
              },
              icon: Icon(Icons.delete),
            ),
            title: Text(helper!.name),
            subtitle: Text(helper.cfu.toString()),
            trailing: Icon(helper.status
                ? Icons.check_circle_outlined
                : Icons.pending_outlined),
          ),
        );
      },
    );
  }

  // Funzione di eliminazione dell'esame con relativo messaggio di conferma e cancellazione dal DB Hive
  void _deleteExamMessage(BuildContext context, Exam? helper) {
    showDialog(
      context: context,
      useSafeArea: true,
      builder: (context) => AlertDialog(
        scrollable: true,
        title: Text('Elimina esame'),
        content: Text('Vuoi eliminare definitivamente questo esame?'),
        actions: [
          ElevatedButton(
            onPressed: () {
              int selectedIndex = -1;

              for (int i = 0; i < yearBox.length; i++) {
                final yearData = yearBox.getAt(i) as Year;
                if (yearData.year == selectedYear) {
                  year = yearData;
                  selectedIndex = i;
                  break;
                }
              }

              year.exams!.removeWhere((item) => item.id == helper!.id);
              yearBox.putAt(selectedIndex, year);
              Navigator.pop(context);
            },
            child: Text('Elimina'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Annulla'),
          ),
        ],
      ),
    );
  }
}
