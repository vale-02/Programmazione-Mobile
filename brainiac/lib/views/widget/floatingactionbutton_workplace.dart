import 'package:brainiac/services/database/workplace_addexam.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FloatingactionbuttonWorkplace extends StatelessWidget {
  FloatingactionbuttonWorkplace({super.key, required this.selectedYear});
  int selectedYear;

  // Bottone per l'aggiunta di un nuovo esame con controllo di selezione dell'anno
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      mini: true,
      backgroundColor: Color(0xFFFC8D0A),
      foregroundColor: Colors.black87,
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
                  content: Text(
                    'Devi selezionare un anno.',
                    style: TextStyle(
                      fontFamily: 'Museo Moderno',
                    ),
                  ),
                  showCloseIcon: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              );
            },
      child: Icon(Icons.add),
    );
  }
}
