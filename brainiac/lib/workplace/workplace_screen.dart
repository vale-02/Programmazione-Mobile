import 'package:brainiac/model/exam.dart';
import 'package:brainiac/model/year.dart';
import 'package:brainiac/workplace/workplace_addexam.dart';
import 'package:brainiac/workplace/workplace_viewexam.dart';
import 'package:brainiac/years/years_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class WorkplaceScreen extends StatelessWidget {
  const WorkplaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WORKPLACE'),
        actions: [
          IconButton(
            onPressed: () {
              Hive.box('ExamBox').clear();
            },
            icon: Icon(Icons.delete_forever_rounded),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => WorkplaceAddexam(),
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
            final hiveBox = Hive.box('ExamBox');
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: YearsScreen(),
                ),
                Expanded(
                  child: ValueListenableBuilder(
                    valueListenable: hiveBox.listenable(),
                    builder: (context, Box box, child) {
                      return ListView.builder(
                        itemCount: hiveBox.length,
                        itemBuilder: (context, index) {
                          final helper = hiveBox.getAt(index) as Exam;
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
                                            hiveBox.deleteAt(index);
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
                      );
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
