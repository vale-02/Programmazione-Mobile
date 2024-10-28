import 'package:brainiac/workplace/widget/ai.dart';
import 'package:brainiac/workplace/form/field.dart';
import 'package:flutter/material.dart';

class ExamEditForm extends StatelessWidget {
  const ExamEditForm(
      {super.key,
      required this.nameController,
      required this.cfuController,
      required this.gradeController,
      required this.descriptionController,
      required this.status,
      required this.onStatusChanged});
  final TextEditingController nameController;
  final TextEditingController cfuController;
  final TextEditingController gradeController;
  final TextEditingController descriptionController;
  final bool status;
  final ValueChanged<bool?> onStatusChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Field().name(nameController),
        SizedBox(
          height: 20,
        ),
        Field().cfu(cfuController),
        SizedBox(
          height: 20,
        ),
        Ai(
          descriptionController: descriptionController,
          nameController: nameController,
          cfuController: cfuController,
        ),
        SizedBox(height: 20),
        DropdownButton<bool>(
          value: status,
          onChanged: onStatusChanged,
          items: [
            DropdownMenuItem(value: true, child: Text('Superato')),
            DropdownMenuItem(value: false, child: Text('In corso')),
          ],
        ),
        SizedBox(height: 20),
        Field().grade(gradeController, status, '0'),
      ],
    );
  }
}
