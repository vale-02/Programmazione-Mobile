import 'package:brainiac/models/book.dart';
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
        title: Text(
          'Elimina libro',
          textAlign: TextAlign.center,
        ),
        titleTextStyle: TextStyle(
          color: Colors.red,
          fontFamily: 'Museo Moderno',
        ),
        content: Text(
          'Vuoi eliminare ${book.title} dall\'archivio?',
          textAlign: TextAlign.center,
        ),
        contentTextStyle: TextStyle(
          color: Colors.white,
          fontFamily: 'Museo Moderno',
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
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
                child: Text(
                  'Elimina',
                  style: TextStyle(
                    color: Colors.red,
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
        ],
      ),
    );
  }
}
