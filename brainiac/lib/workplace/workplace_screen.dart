import 'package:brainiac/main.dart';
import 'package:brainiac/model/exam.dart';
import 'package:brainiac/workplace/workplace_addexam.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class WorkplaceScreen extends StatelessWidget {
  const WorkplaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WORKPLACE'),
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
                      title: Text(helper.name),
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
