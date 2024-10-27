import 'package:flutter/material.dart';

class YearSelectionModel with ChangeNotifier {
  int _selectedYear = -1;

  int get selectedYear => _selectedYear;

  //Provider per la selezione dell'anno su cui lavorare
  void selectYear(int year) {
    _selectedYear = year;
    notifyListeners();
  }

  //Provider per la deselezione dell'anno
  void resetYear() {
    _selectedYear = -1;
    notifyListeners();
  }
}
