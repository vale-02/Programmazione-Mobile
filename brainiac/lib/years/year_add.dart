import 'package:brainiac/model/year.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class YearAdd extends StatelessWidget {
  const YearAdd({super.key});

  //Inserimento del nuovo anno nel database fino al raggiungimento del quinto anno
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: Hive.box('YearBox').length < 5
          ? () {
              final value = Year(year: _getYear(), exams: []);
              Hive.box('YearBox').add(value);
            }
          : () {},
      icon: Icon(Icons.add),
    );
  }

  //Trovare il primo anno da inserire (da 1 a 5) in ordine crescente
  int _getYear() {
    final hiveBox = Hive.box('YearBox');
    List<int> existingYears = [];

    for (int i = 0; i < hiveBox.length; i++) {
      final year = hiveBox.getAt(i) as Year;
      existingYears.add(year.year);
    }

    int newYear;
    for (newYear = 1; newYear < 5; newYear++) {
      if (!existingYears.contains(newYear)) {
        break;
      }
    }
    return newYear;
  }
}
