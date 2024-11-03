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
        title: Text(
          'Aggiungi libro',
          textAlign: TextAlign.center,
        ),
        titleTextStyle: TextStyle(
          color: Color.fromARGB(255, 224, 193, 255),
          fontFamily: 'Museo Moderno',
        ),
        content: Text(
          'Vuoi aggiungere ${book.title} all\'archivio?',
          textAlign: TextAlign.center,
        ),
        contentTextStyle: TextStyle(
          color: Colors.white,
          fontFamily: 'Museo Moderno',
        ),
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
                    content: Text(
                      'Libro già presente nell\'archivio',
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
              } else {
                Hive.box('BookBox').add(book);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Libro aggiunto all\'archivio',
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
              }

              Navigator.pop(context);
            },
            child: Text(
              'Aggiungi',
              style: TextStyle(
                color: Color(0xFFFC8D0A),
                fontFamily: 'Museo Moderno',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Annulla',
              style: TextStyle(
                color: Color.fromARGB(255, 224, 193, 255),
                fontFamily: 'Museo Moderno',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
