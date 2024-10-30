import 'package:brainiac/book/book_preview.dart';
import 'package:brainiac/model/book.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class BookView {
  BookView({required this.onDelete});
  void Function() onDelete;

  Widget buildBook(BuildContext context, Book book, {bool delete = false}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BookPreview(
              book: book,
            ),
          ),
        );
      },
      onLongPress: () {
        if (delete) {
          deleteVideo(context, book);
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
        padding: EdgeInsets.all(5.0),
        child: Row(
          children: [
            Image.network(
              book.thumbnailUrl,
              width: 150.0,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 150.0,
                  height: 140.0,
                  color: Colors.grey,
                  child: Icon(Icons.error),
                );
              },
            ),
            SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: Text(
                book.title,
              ),
            ),
          ],
        ),
      ),
    );
  }

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

  void deleteVideo(BuildContext context, Book book) {
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
