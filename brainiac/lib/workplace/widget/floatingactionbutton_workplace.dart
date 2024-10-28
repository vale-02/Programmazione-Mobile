import 'package:brainiac/workplace/workplace_addexam.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FloatingactionbuttonWorkplace extends StatelessWidget {
  FloatingactionbuttonWorkplace({super.key, required this.selectedYear});
  int selectedYear;

  // Bottone per l'aggiunta di un nuovo esame con controllo di selezione dell'anno
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: selectedYear != -1
          ? () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => WorkplaceAddexam(
                    selectedYear: selectedYear,
                  ),
                ),
              );
            }
          : () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Devi selezionare un anno.'),
                  showCloseIcon: true,
                ),
              );
            },
      child: Icon(Icons.add),
    );
  }
}
