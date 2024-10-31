import 'package:brainiac/model/year.dart';
import 'package:brainiac/workplace/widget/menu.dart';
import 'package:brainiac/workplace/widget/floatingactionbutton_workplace.dart';
import 'package:brainiac/workplace/widget/list_exam.dart';
import 'package:brainiac/years/year_selectionmodel.dart';
import 'package:brainiac/years/years_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gradient_text/flutter_gradient_text.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

class WorkplaceScreen extends StatelessWidget {
  const WorkplaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedYear = context.watch<YearSelectionModel>().selectedYear;

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
            'AREA DI LAVORO',
          ),
          colors: [
            Color(0xFFFC8D0A),
            Color(0xFFFE2C8D),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        actions: [
          Menu(),
        ],
      ),
      floatingActionButton:
          FloatingactionbuttonWorkplace(selectedYear: selectedYear),

      // Connessione al database Hive
      body: FutureBuilder(
        future: Future.wait([
          Hive.openBox('ExamBox'),
          Hive.openBox('YearBox'),
          Hive.openBox('VideoBox'),
          Hive.openBox('PlaylistBox'),
          Hive.openBox('BookBox'),
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
                      if (Hive.box('YearBox').isEmpty) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              'Aggiungi un anno con il pulsante in alto a sinistra',
                              style: TextStyle(
                                color: Color.fromARGB(255, 224, 193, 255),
                                fontFamily: 'Museo Moderno',
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      } else if (selectedYear == -1) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              'Seleziona un anno per visualizzare gli esami',
                              style: TextStyle(
                                color: Color.fromARGB(255, 224, 193, 255),
                                fontFamily: 'Museo Moderno',
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
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
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  'Non ci sono esami inseriti per questo anno',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 224, 193, 255),
                                    fontFamily: 'Museo Moderno',
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
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
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                'Errore nella selezione dell\'anno da visualizzare',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 224, 193, 255),
                                  fontFamily: 'Museo Moderno',
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
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
