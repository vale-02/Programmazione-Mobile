import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:hugeicons/hugeicons.dart';

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
  final ValueNotifier<bool> isLoading = ValueNotifier(false);

  // Widget per la gestione della descrizione manuale o con Gemini
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Genera descrizione',
              style: TextStyle(
                color: Color(0xFFFE2C8D),
                fontFamily: 'Museo Moderno',
              ),
            ),
            IconButton(
              onPressed: () {
                _generateDescription(context);
              },
              icon: HugeIcon(
                icon: HugeIcons.strokeRoundedMagicWand01,
                color: Color(0xFFFE2C8D),
              ),
            ),
          ],
        ),
        ValueListenableBuilder<bool>(
            valueListenable: isLoading,
            builder: (context, loading, child) {
              return Container(
                height: MediaQuery.of(context).size.height * 0.5,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(17.0),
                ),
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: TextField(
                          style: TextStyle(
                            fontFamily: 'Museo Moderno',
                          ),
                          controller: descriptionController,
                          decoration: _decoration('Descrizione esame', context),
                          maxLines: null,
                        ),
                      ),
                    ),
                    if (loading)
                      Center(
                        child: CircularProgressIndicator(),
                      )
                  ],
                ),
              );
            }),
      ],
    );
  }

  InputDecoration _decoration(String labelText, BuildContext context) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: TextStyle(
        fontFamily: 'Museo Moderno',
      ),
      border: InputBorder.none,
      floatingLabelStyle: TextStyle(
        color: Color(0xFFFC8D0A),
        fontFamily: 'Museo Moderno',
      ),
    );
  }

  String _removeFormat(String text) {
    return text.replaceAll(RegExp(r'\*\*'), '').trim();
  }

  Future<void> _generateDescription(BuildContext context) async {
    if (nameController.text.isEmpty || cfuController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Nome e CFU devono essere inseriti',
            style: TextStyle(
              fontFamily: 'Museo Moderno',
            ),
          ),
          showCloseIcon: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
      );
      return;
    }

    isLoading.value = true;

    descriptionController.clear();

    final model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: dotenv.env['API_AI'] ?? 'API key non trovata',
    );
    final prompt =
        'Dammi una breve descrizione degli obiettivi e dei contenuti dell\'esame universitario di ${nameController.text} da ${cfuController.text} CFU';

    final response = await model.generateContent([Content.text(prompt)]);
    final text = _removeFormat(response.text!);
    descriptionController.text = text;
    isLoading.value = false;
  }
}
