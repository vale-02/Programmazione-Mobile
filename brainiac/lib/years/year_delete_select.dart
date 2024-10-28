import 'package:brainiac/model/year.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class YearDeleteSelect extends StatelessWidget {
  YearDeleteSelect(
      {super.key, required this.selectedYear, required this.onYearSelected});
  final Year selectedYear;
  final Function(int) onYearSelected;
  final hiveBox = Hive.box('YearBox');

  /*
    Funzionalità dei bottoni degli anni
    1. Cancellazione dell'anno dal database Hive e degli eventuali esami registrati all'interno
    2. Selezione dell'anno da usare come area di lavoro
  */
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: ElevatedButton(
        onLongPress: () {
          _showDeleteDialog(context);
        },
        onPressed: () {
          onYearSelected(selectedYear.year);
        },
        child: Text('Anno ${selectedYear.year}'),
      ),
    );
  }

  // Messaggio di conferma per la cancellazione, eliminazione dal database e deselezione dell'anno
  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      useSafeArea: true,
      builder: (context) => AlertDialog(
        scrollable: true,
        title: Text('Elimina Anno ${selectedYear.year}'),
        content: Text('Vuoi eliminare definitivamente questo anno?'),
        actions: [
          ElevatedButton(
            onPressed: () {
              int index = -1;
              for (int i = 0; i < hiveBox.length; i++) {
                Year storedYear = hiveBox.getAt(i) as Year;
                if (storedYear.year == selectedYear.year) {
                  index = i;
                  break;
                }
              }
              if (index != -1) {
                hiveBox.deleteAt(index);
                onYearSelected(-1);
              }
              Navigator.pop(context);
            },
            child: Text('Elimina'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Annulla'),
          ),
        ],
      ),
    );
  }
}
