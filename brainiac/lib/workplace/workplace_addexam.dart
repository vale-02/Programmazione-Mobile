import 'package:brainiac/model/exam.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class WorkplaceAddexam extends StatefulWidget {
  const WorkplaceAddexam({super.key});

  @override
  State<WorkplaceAddexam> createState() => _WorkplaceAddexam();
}

class _WorkplaceAddexam extends State<WorkplaceAddexam> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cfuController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _cfuController.dispose();
    _descriptionController.dispose();
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
              TextField(
                controller: _cfuController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: InputDecoration(labelText: 'CFU'),
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  TextField(
                    controller: _descriptionController,
                    decoration: InputDecoration(labelText: 'Descrizione esame'),
                    maxLines: null,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final model = GenerativeModel(
                        model: 'gemini-1.5-flash',
                        apiKey: dotenv.env['API_AI'] ?? 'API key non trovata',
                      );
                      final prompt =
                          'Dammi una breve descrizione degli obiettivi e dei contenuti dell\'esame universitario di ${_nameController.text} da ${_cfuController.text} CFU';

                      final response =
                          await model.generateContent([Content.text(prompt)]);
                      _descriptionController.text = response.text!;
                    },
                    child: Text('Genera con l\'AI'),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  final value = Exam(
                    id: _getNextId(),
                    name: _nameController.text,
                    cfu: int.parse(_cfuController.text),
                    status: false,
                    grade: 0,
                    description: _descriptionController.text,
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
