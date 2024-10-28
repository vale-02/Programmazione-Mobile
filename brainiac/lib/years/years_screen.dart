import 'package:brainiac/model/year.dart';
import 'package:brainiac/years/year_add.dart';
import 'package:brainiac/years/year_delete_select.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

// ignore: must_be_immutable
class YearsScreen extends StatefulWidget {
  YearsScreen({super.key, required this.onYearSelected});
  // Funzione provider per la selezione dell'anno
  Function(int) onYearSelected;

  @override
  State<YearsScreen> createState() => _YearsScreen();
}

class _YearsScreen extends State<YearsScreen> {
  final hiveBox = Hive.box('YearBox');

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
          valueListenable: Hive.box('YearBox').listenable(),
          builder: (context, Box box, child) {
            // Pulsante aggiunta di un anno nel database YearBox
            return YearAdd();
          },
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ValueListenableBuilder(
              valueListenable: hiveBox.listenable(),
              builder: (context, Box box, child) {
                // Gestione visualizzazione anni in ordine crescente
                List<Year> years = [];
                for (int i = 0; i < box.length; i++) {
                  years.add(box.getAt(i) as Year);
                }
                years.sort((a, b) => a.year.compareTo(b.year));

                List<Widget> yearButtons = years.map((year) {
                  return YearDeleteSelect(
                    selectedYear: year,
                    onYearSelected: widget.onYearSelected,
                  );
                }).toList();

                return Row(
                  children: yearButtons,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
