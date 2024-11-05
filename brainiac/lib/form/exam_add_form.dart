import 'package:brainiac/form/field.dart';
import 'package:brainiac/services/api/ai.dart';
import 'package:flutter/material.dart';

class ExamAddForm extends StatelessWidget {
  const ExamAddForm(
      {super.key,
      required this.nameController,
      required this.cfuController,
      required this.descriptionController});
  final TextEditingController nameController;
  final TextEditingController cfuController;
  final TextEditingController descriptionController;

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
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
