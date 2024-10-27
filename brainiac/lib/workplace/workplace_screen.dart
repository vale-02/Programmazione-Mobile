import 'package:brainiac/model/exam.dart';
import 'package:brainiac/model/year.dart';
import 'package:brainiac/workplace/workplace_addexam.dart';
import 'package:brainiac/workplace/workplace_viewexam.dart';
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
          IconButton(
            onPressed: selectedYear != -1
                ? () {
                    //implementare ricerca esami in base ad anno
                    Hive.box('ExamBox').clear();
                  }
                : () {
                    //implementare showdialog per dire che bisogna selezionare anno
                  },
            icon: Icon(Icons.delete_forever_rounded),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: selectedYear != -1
            ? () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => WorkplaceAddexam(
                      selectedYear: selectedYear,
                    ),
                  ),
                );
              }
            : () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Seleziona un anno. $selectedYear'),
                    showCloseIcon: true,
                  ),
                );
              },
        child: Icon(Icons.add),
      ),
      body: FutureBuilder(
        future: Future.wait([
          Hive.openBox('ExamBox'),
          Hive.openBox('YearBox'),
        ]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final examBox = Hive.box('ExamBox');
            final yearBox = Hive.box('YearBox');
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: YearsScreen(
                    onYearSelected: (int year) {
                      context.read<YearSelectionModel>().selectYear(year);
                    },
                  ),
                ),
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
                            return ListView.builder(
                              itemCount: selectedYearData.exams?.length,
                              itemBuilder: (context, index) {
                                final helper = selectedYearData!.exams?[index];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => WorkplaceViewexam(
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
                                        showDialog(
                                          context: context,
                                          useSafeArea: true,
                                          builder: (context) => AlertDialog(
                                            scrollable: true,
                                            title: Text('Elimina esame'),
                                            content: Text(
                                                'Vuoi eliminare definitivamente questo esame?'),
                                            actions: [
                                              ElevatedButton(
                                                onPressed: () {
                                                  int selectedIndex = -1;

                                                  for (int i = 0;
                                                      i < yearBox.length;
                                                      i++) {
                                                    final yearData = yearBox
                                                        .getAt(i) as Year;
                                                    if (yearData.year ==
                                                        selectedYear) {
                                                      selectedYearData =
                                                          yearData;
                                                      selectedIndex = i;
                                                      break;
                                                    }
                                                  }

                                                  selectedYearData!.exams!
                                                      .removeWhere((item) =>
                                                          item.id ==
                                                          helper!.id);
                                                  yearBox.putAt(selectedIndex,
                                                      selectedYearData);
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
                        } else {
                          return Center(
                            child: Text('Seleziona un anno da visualizzare'),
                          );
                        }
                      }

                      /*return ListView.builder(
                        itemCount: examBox.length,
                        itemBuilder: (context, index) {
                          final helper = examBox.getAt(index) as Exam;
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => WorkplaceViewexam(
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
                                  showDialog(
                                    context: context,
                                    useSafeArea: true,
                                    builder: (context) => AlertDialog(
                                      scrollable: true,
                                      title: Text('Elimina esame'),
                                      content: Text(
                                          'Vuoi eliminare definitivamente questo esame?'),
                                      actions: [
                                        ElevatedButton(
                                          onPressed: () {
                                            examBox.deleteAt(index);
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
                                },
                                icon: Icon(Icons.delete),
                              ),
                              title: Text(helper.name),
                              subtitle: Text(helper.cfu.toString()),
                              trailing: Icon(helper.status
                                  ? Icons.check_circle_outlined
                                  : Icons.pending_outlined),
                            ),
                          );
                        },
                      );*/
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
