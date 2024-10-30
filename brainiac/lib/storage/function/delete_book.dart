import 'package:brainiac/model/book.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

//Funzione cancellazione modello Book dall'archivio
class DeleteBook {
  DeleteBook({required this.onDelete});
  void Function() onDelete;

  void deleteBook(BuildContext context, Book book) {
    showDialog(
      context: context,
      useSafeArea: true,
      builder: (context) => AlertDialog(
        scrollable: true,
        title: Text('Elimina libro'),
        content: Text('Vuoi eliminare ${book.title} dall\'archivio?'),
        actions: [
          ElevatedButton(
            onPressed: () {
              int selectedIndex = -1;

              for (int i = 0; i < Hive.box('BookBox').length; i++) {
                final result = Hive.box('BookBox').getAt(i) as Book;
                if (result.id == book.id) {
                  selectedIndex = i;
                  break;
                }
              }
              Hive.box('BookBox').deleteAt(selectedIndex);
              onDelete();
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
