import 'package:brainiac/model/year.dart';
import 'package:brainiac/widget/delete_db.dart';
import 'package:brainiac/widget/floatingactionbutton_workplace.dart';
import 'package:brainiac/widget/list_exam.dart';
import 'package:brainiac/years/year_selectionmodel.dart';
import 'package:brainiac/years/years_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

class WorkplaceScreen extends StatelessWidget {
  const WorkplaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedYear = context.watch<YearSelectionModel>().selectedYear;

    return Scaffold(
      appBar: AppBar(
        title: Text('WORKPLACE'),
        actions: [
          DeleteDb(),
        ],
      ),
      floatingActionButton:
          FloatingactionbuttonWorkplace(selectedYear: selectedYear),

      // Connessione al database Hive
      body: FutureBuilder(
        future: Future.wait([
          Hive.openBox('ExamBox'),
          Hive.openBox('YearBox'),
        ]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final yearBox = Hive.box('YearBox');
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),

                  // Visualizzazione anni
                  child: YearsScreen(
                    onYearSelected: (int year) {
                      context.read<YearSelectionModel>().selectYear(year);
                    },
                  ),
                ),

                /*
                    1. Visualizzazione messaggio per l'utente se non è stato selezionato un anno
                    2. Se nell'anno selezionato non ci sono esami visualizzazione messaggio informativo
                    3. Visualizzazione lista esami presenti in quell'anno
                    4. Eventuale messaggio di errore in caso di eccezioni del sistema
                */
                Expanded(
                  child: ValueListenableBuilder(
                    valueListenable: yearBox.listenable(),
                    builder: (context, Box box, child) {
                      if (selectedYear == -1) {
                        return Center(
                          child: Text(
                              'Seleziona un anno per visualizzare gli esami'),
                        );
                      } else {
                        Year? selectedYearData;
                        for (int i = 0; i < box.length; i++) {
                          final yearData = box.getAt(i) as Year;
                          if (yearData.year == selectedYear) {
                            selectedYearData = yearData;
                            break;
                          }
                        }

                        if (selectedYearData != null) {
                          if (selectedYearData.exams!.isEmpty) {
                            return Center(
                              child: Text(
                                  'Non ci sono esami inseriti per questo anno'),
                            );
                          } else {
                            return ListExam(
                              year: selectedYearData,
                              selectedYear: selectedYear,
                              yearBox: yearBox,
                            );
                          }
                        } else {
                          return Center(
                            child: Text(
                                'Errore nella selezione dell\'anno da visualizzare'),
                          );
                        }
                      }
                    },
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
