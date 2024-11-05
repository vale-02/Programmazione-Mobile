import 'package:brainiac/models/exam.dart';
import 'package:brainiac/models/year.dart';
import 'package:brainiac/views/workplace_viewexam.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hugeicons/hugeicons.dart';

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
        return ListTile(
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
          leading: IconButton(
            onPressed: () {
              _deleteExamMessage(context, helper);
            },
            icon: HugeIcon(
              icon: HugeIcons.strokeRoundedDelete02,
              color: Color.fromARGB(255, 235, 16, 16),
              size: 20,
            ),
          ),
          title: Text(helper!.name),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontFamily: 'Museo Moderno',
          ),
          subtitle: Text('CFU : ${helper.cfu.toString()}'),
          subtitleTextStyle: TextStyle(
            color: Color.fromARGB(255, 224, 193, 255),
            fontFamily: 'Museo Moderno',
          ),
          trailing: helper.status
              ? HugeIcon(
                  icon: HugeIcons.strokeRoundedCheckmarkBadge02,
                  color: Colors.lightGreenAccent)
              : HugeIcon(
                  icon: HugeIcons.strokeRoundedLoading02,
                  color: Colors.lightBlueAccent),
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
        title: Text(
          'Elimina esame',
          textAlign: TextAlign.center,
        ),
        titleTextStyle: TextStyle(
          color: Color.fromARGB(255, 224, 193, 255),
          fontFamily: 'Museo Moderno',
        ),
        content: Text(
          'Vuoi eliminare definitivamente ${helper!.name} ?',
          textAlign: TextAlign.center,
        ),
        contentTextStyle: TextStyle(
          fontFamily: 'Museo Moderno',
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
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

                  year.exams!.removeWhere((item) => item.id == helper.id);
                  yearBox.putAt(selectedIndex, year);
                  Navigator.pop(context);
                },
                child: Text(
                  'Elimina',
                  style: TextStyle(
                    color: Color.fromARGB(255, 235, 16, 16),
                    fontFamily: 'Museo Moderno',
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Annulla',
                  style: TextStyle(
                    color: Color.fromARGB(255, 224, 193, 255),
                    fontFamily: 'Museo Moderno',
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
