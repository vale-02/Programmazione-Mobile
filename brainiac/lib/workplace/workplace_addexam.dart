import 'package:brainiac/model/exam.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';

class WorkplaceAddexam extends StatefulWidget {
  const WorkplaceAddexam({super.key});

  @override
  State<WorkplaceAddexam> createState() => _WorkplaceAddexam();
}

class _WorkplaceAddexam extends State<WorkplaceAddexam> {
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  int _getNextId() {
    final box = Hive.box('ExamBox');
    return box.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inserisci i dati dell\'esame'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nome esame'),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  final value = Exam(
                    id: _getNextId(),
                    name: _nameController.text,
                  );
                  Hive.box('ExamBox').add(value);
                  Navigator.pop(context);
                },
                child: Text('Aggiungi esame'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
