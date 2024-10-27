import 'package:flutter/material.dart';

class YearSelectionModel with ChangeNotifier {
  int _selectedYear = -1;

  int get selectedYear => _selectedYear;

  void selectYear(int year) {
    _selectedYear = year;
    notifyListeners();
  }

  void resetSelectedYear() {
    _selectedYear = -1;
    notifyListeners();
  }
}
