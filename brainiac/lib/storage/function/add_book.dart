import 'package:brainiac/model/book.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

//Funzione aggiunta modello Book all'archivio
class AddBook {
  void addBook(BuildContext context, Book book) {
    showDialog(
      context: context,
      useSafeArea: true,
      builder: (context) => AlertDialog(
        scrollable: true,
        title: Text('Aggiungi libro'),
        content: Text('Vuoi aggiungere ${book.title} all\'archivio?'),
        actions: [
          ElevatedButton(
            onPressed: () {
              bool bookExists = false;
              for (int i = 0; i < Hive.box('BookBox').length; i++) {
                final result = Hive.box('BookBox').getAt(i) as Book;
                if (result.title == book.title) {
                  bookExists = true;
                  break;
                }
              }
              if (bookExists) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Libro già presente nell\'archivio'),
                    showCloseIcon: true,
                  ),
                );
              } else {
                Hive.box('BookBox').add(book);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Libro aggiunto all\'archivio'),
                    showCloseIcon: true,
                  ),
                );
              }

              Navigator.pop(context);
            },
            child: Text('Aggiungi'),
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
