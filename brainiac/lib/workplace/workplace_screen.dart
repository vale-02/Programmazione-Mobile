import 'package:brainiac/model/exam.dart';
import 'package:brainiac/workplace/workplace_addexam.dart';
import 'package:brainiac/workplace/workplace_editexam.dart';
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
        future: Hive.openBox('ExamBox'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final hiveBox = Hive.box('ExamBox');
            return ValueListenableBuilder(
              valueListenable: hiveBox.listenable(),
              builder: (context, Box box, child) {
                return ListView.builder(
                  itemCount: hiveBox.length,
                  itemBuilder: (context, index) {
                    final helper = hiveBox.getAt(index) as Exam;
                    return ListTile(
                      leading: IconButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => WorkplaceEditexam(
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
                        icon: Icon(Icons.edit),
                      ),
                      title: Text(helper.name),
                      subtitle: Text(helper.cfu.toString()),
                      trailing: Column(
                        children: [
                          Icon(helper.status
                              ? Icons.check_circle_outlined
                              : Icons.pending_outlined),
                          IconButton(
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
                        ],
                      ),
                    );
                  },
                );
              },
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
