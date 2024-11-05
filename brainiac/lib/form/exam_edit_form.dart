import 'package:brainiac/services/api/ai.dart';
import 'package:brainiac/form/field.dart';
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
        Container(
          width: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(17.0),
            border: Border.all(
              color: Colors.grey,
              width: 1.0,
            ),
          ),
          child: Center(
            child: DropdownButton<bool>(
              value: status,
              onChanged: onStatusChanged,
              style: TextStyle(
                color: Color(0xFFFE2C8D),
                fontFamily: 'Museo Moderno',
              ),
              borderRadius: BorderRadius.circular(17.0),
              underline: SizedBox.shrink(),
              items: [
                DropdownMenuItem(value: true, child: Text('Superato')),
                DropdownMenuItem(value: false, child: Text('In corso')),
              ],
            ),
          ),
        ),
        SizedBox(height: 20),
        Field().grade(gradeController, status, '0'),
        SizedBox(height: 20),
      ],
    );
  }
}
