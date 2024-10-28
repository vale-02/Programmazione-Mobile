import 'package:brainiac/years/year_selectionmodel.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class DeleteDb extends StatelessWidget {
  const DeleteDb({super.key});

  // Pulsante per eliminare completamente il DB con messaggio di conferma e deselezione anno
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showDialog(
          context: context,
          useSafeArea: true,
          builder: (context) => AlertDialog(
            scrollable: true,
            title: Text('Eliminare tutti i dati'),
            content: Text(
                'Vuoi eliminare definitivamente tutti i dati sul dispositivo?'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  final model =
                      Provider.of<YearSelectionModel>(context, listen: false);
                  Hive.box('YearBox').clear();
                  Hive.box('ExamBox').clear();
                  model.resetYear();
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
      },
      icon: Icon(Icons.delete_forever_rounded),
    );
  }
}
