import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Field {
  TextFormField name(TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: _errorField('Nome esame'),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Nome esame obbligatorio';
        }
        return null;
      },
    );
  }

  TextFormField cfu(TextEditingController controller) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: _errorField('CFU'),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Il CFU è obbligatorio';
        }
        return null;
      },
    );
  }

  TextFormField grade(TextEditingController gradeController,
      bool statusController, String? hintText) {
    return TextFormField(
      controller: gradeController,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      decoration: _errorFieldGrade('Voto', hintText),
      enabled: statusController,
      validator: (value) {
        if (statusController) {
          if (value == null || value.isEmpty) {
            return 'Campo obbligatorio';
          }
          final grade = int.tryParse(value);
          if (grade == null || grade < 18 || grade > 31) {
            return 'Il voto deve essere compreso tra 18 e 30';
          }
        }
        return null;
      },
    );
  }

  // Grafica per eventuali campi non inseriti correttamente
  InputDecoration _errorField(String labelText) {
    return InputDecoration(
      labelText: labelText,
      border: OutlineInputBorder(),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blue),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
      ),
    );
  }

  // Grafica per eventuali campi non inseriti correttamente
  InputDecoration _errorFieldGrade(String labelText, String? hintText) {
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      border: OutlineInputBorder(),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blue),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
      ),
    );
  }
}
