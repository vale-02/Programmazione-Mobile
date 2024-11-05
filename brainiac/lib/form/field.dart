import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Field {
  TextFormField name(TextEditingController controller) {
    return TextFormField(
      style: TextStyle(
        fontFamily: 'Museo Moderno',
      ),
      controller: controller,
      decoration: _errorField('Nome esame'),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Campo obbligatorio';
        }
        return null;
      },
    );
  }

  TextFormField cfu(TextEditingController controller) {
    return TextFormField(
      style: TextStyle(
        fontFamily: 'Museo Moderno',
      ),
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: _errorField('CFU'),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Campo obbligatorio';
        }
        return null;
      },
    );
  }

  TextFormField grade(TextEditingController gradeController,
      bool statusController, String? hintText) {
    return TextFormField(
      style: TextStyle(
        fontFamily: 'Museo Moderno',
      ),
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
            return 'Il voto deve essere compreso tra 18 e 31';
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
      labelStyle: TextStyle(
        fontFamily: 'Museo Moderno',
      ),
      floatingLabelStyle: TextStyle(
        color: Color(0xFFFC8D0A),
        fontFamily: 'Museo Moderno',
      ),
      errorStyle: TextStyle(
        color: Colors.red,
        fontFamily: 'Museo Moderno',
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFFC8D0A)),
        borderRadius: BorderRadius.circular(17.0),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(17.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.circular(17.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFFC8D0A)),
        borderRadius: BorderRadius.circular(17.0),
      ),
    );
  }

  // Grafica per eventuali campi non inseriti correttamente
  InputDecoration _errorFieldGrade(String labelText, String? hintText) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: TextStyle(
        fontFamily: 'Museo Moderno',
      ),
      hintText: hintText,
      hintStyle: TextStyle(
        fontFamily: 'Museo Moderno',
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(17.0),
      ),
      floatingLabelStyle: TextStyle(
        color: Color(0xFFFC8D0A),
        fontFamily: 'Museo Moderno',
      ),
      errorStyle: TextStyle(
        color: Colors.red,
        fontFamily: 'Museo Moderno',
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFFC8D0A)),
        borderRadius: BorderRadius.circular(17.0),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(17.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.circular(17.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFFC8D0A)),
        borderRadius: BorderRadius.circular(17.0),
      ),
    );
  }
}
