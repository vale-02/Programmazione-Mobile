import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

// ignore: must_be_immutable
class Ai extends StatelessWidget {
  Ai(
      {super.key,
      required this.descriptionController,
      required this.nameController,
      required this.cfuController});
  TextEditingController descriptionController;
  TextEditingController nameController;
  TextEditingController cfuController;

  // Widget per la gestione della descrizione manuale o con Gemini
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            _generateDescription(context);
          },
          child: Text('Genera con l\'AI'),
        ),
        SizedBox(
          height: 200,
          child: SingleChildScrollView(
            child: TextFormField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Descrizione esame'),
              maxLines: null,
            ),
          ),
        ),
      ],
    );
  }

  void _generateDescription(BuildContext context) async {
    if (nameController.text.isEmpty || cfuController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Nome e CFU devono essere inseriti')),
      );
      return;
    }

    descriptionController.clear();

    final model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: dotenv.env['API_AI'] ?? 'API key non trovata',
    );
    final prompt =
        'Dammi una breve descrizione degli obiettivi e dei contenuti dell\'esame universitario di ${nameController.text} da ${cfuController.text} CFU';

    final response = await model.generateContent([Content.text(prompt)]);
    descriptionController.text = response.text!;
  }
}
